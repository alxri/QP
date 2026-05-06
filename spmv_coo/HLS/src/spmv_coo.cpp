#include "spmv_coo.h"

#include "ap_int.h"

#ifndef NUM_PES
#define NUM_PES 1
#endif

static constexpr int NNZ_LANES = (NUM_PES < PACK_SIZE) ? NUM_PES : PACK_SIZE;

struct NnzPack
{
    int row[NNZ_LANES];
    int col[NNZ_LANES];
    float val[NNZ_LANES];
    float x[NNZ_LANES];    // Prefetched x values from x[col]
    ap_uint<8> n;
};

struct NnzPkt
{
    int row;
    float val;
    float x;
    bool last;
};

static void load_x(int num_cols, const float16 *x_in, float x_local[NNZ_LANES][MAX_COLS])
{
#pragma HLS INLINE off
    const int words = CEIL_DIV(num_cols, PACK_SIZE);

    for (int w = 0; w < words; ++w)
    {
#pragma HLS PIPELINE II = 1
        float16 val_word = x_in[w];
        
        for (int i = 0; i < PACK_SIZE; ++i)
        {
#pragma HLS UNROLL
            int col = w * PACK_SIZE + i;
            if (col < MAX_COLS) // Safety bound
            {
                // Broadcast to all BRAM/URAM copies simultaneously
                for (int lane = 0; lane < NNZ_LANES; ++lane)
                {
#pragma HLS UNROLL
                    x_local[lane][col] = (col < num_cols) ? val_word[i] : 0.0f;
                }
            }
        }
    }
}

/*
* Read COO (row, col, value) triplets in groups of 16 (PACK_SIZE) in bursts.
* Each burst is repacked into NnzPack structs containing up to NNZ_LANES valid entries.
* x values are prefetched from x_local[col] for each triplet to eliminate lookup latency.
*/
static void read_nnz_packed(int nnz,
                            int num_cols,
                            const int16 *row_in,
                            const int16 *col_in,
                            const float16 *val_in,
                            const float x_local[NNZ_LANES][MAX_COLS],
                            hls::stream<NnzPack> &nnz_stream)
{
#pragma HLS INLINE off
    const int words = CEIL_DIV(nnz, PACK_SIZE);
    int idx = 0;

    for (int w = 0; w < words; ++w)
    {
        int16 rows = row_in[w];
        int16 cols = col_in[w];
        float16 vals = val_in[w];

        for (int base = 0; base < PACK_SIZE; base += NNZ_LANES)
        {
#pragma HLS PIPELINE II = 1
            if (idx >= nnz)
                continue;

            // How many nnz remain
            int count = nnz - idx;
            // How many elements are left in the current word starting from base
            const int max_in_word = PACK_SIZE - base;
            // We can only pack up to NNZ_LANES at a time
            const int max_this_pack = (max_in_word < NNZ_LANES) ? max_in_word : NNZ_LANES;
            if (count > max_this_pack)
            {
                // How many elements are being packed in this iteration
                count = max_this_pack;
            }
            NnzPack pack;
            pack.n = (ap_uint<8>)count;

            for (int i = 0; i < NNZ_LANES; ++i)
            {
#pragma HLS UNROLL
                const bool valid_lane = (i < count);
                if (valid_lane)
                {
                    pack.row[i] = rows[base + i];
                    pack.col[i] = cols[base + i];
                    pack.val[i] = vals[base + i];
                    const int col = cols[base + i];
                    pack.x[i] = ((unsigned)col < (unsigned)num_cols) ? x_local[i][col] : 0.0f;
                }
                else
                {
                    pack.row[i] = 0;
                    pack.col[i] = 0;
                    pack.val[i] = 0.0f;
                    pack.x[i] = 0.0f;
                }
            }

            nnz_stream.write(pack);
            idx += count;
        }
    }
}

/*
* Distributes COO nnz elements (with prefetched x values) to PEs in a continuous round-robin way.
* Each cycle, up to NNZ_LANES elements are dispatched in parallel.
*
* x values are already prefetched in the NnzPack, eliminating lookup latency.
* When all nnz have been dispatched, termination packets with last=true are sent to each PE.
*/
static void distribute_to_pe(int nnz,
                             hls::stream<NnzPack> &nnz_stream,
                             hls::stream<NnzPkt> pe_streams[NUM_PES])
{
#pragma HLS INLINE off
    // Which PE is next in line to receive work
    int pe = 0;

    NnzPack pack;
#pragma HLS ARRAY_PARTITION variable = pack.row complete
#pragma HLS ARRAY_PARTITION variable = pack.col complete
#pragma HLS ARRAY_PARTITION variable = pack.val complete
#pragma HLS ARRAY_PARTITION variable = pack.x complete
    // Total nnz distributed so far (for termination)
    int distributed = 0; 

    while (distributed < nnz)
    {
#pragma HLS PIPELINE II = 1
        pack = nnz_stream.read();
        const int send = (int)pack.n;

        // Unrolled for each PE
        // Write one nnz element to each PE stream in a round-robin way until we've sent 'send' elements
        for (int p = 0; p < NUM_PES; ++p)
        {
#pragma HLS UNROLL
            int rel = p - pe;
            if (rel < 0)
                rel += NUM_PES;

            if (rel < send)
            {
                NnzPkt pkt;
                pkt.row = pack.row[rel];
                pkt.val = pack.val[rel];
                pkt.x = pack.x[rel];  // Use prefetched x value (no lookup)
                pkt.last = false;
                pe_streams[p].write(pkt);
            }
        }
        // Move the current PE pointer forward by 'send' positions in a round-robin way
        pe += send;
        // Wrap around if we exceed the number of PEs
        if (pe >= NUM_PES){
            pe -= NUM_PES;
        }

        // Update counters
        distributed += send;
    }

    // After all nnz have been distributed, send termination packets to each PE
    for (int i = 0; i < NUM_PES; ++i)
    {
#pragma HLS PIPELINE II = 1
        NnzPkt end;
        end.row = 0;
        end.val = 0.0f;
        end.x = 0.0f;
        end.last = true;
        pe_streams[i].write(end);
    }
}

static void compute_pe(int num_rows, hls::stream<NnzPkt> &in, float y_partial[MAX_ROWS])
{
#pragma HLS INLINE off
//     for (int i = 0; i < num_rows; ++i)
//     {
// #pragma HLS PIPELINE II = 1
//         y_partial[i] = 0.0f;
//     }

    while (true)
    {
#pragma HLS PIPELINE II = 1
        NnzPkt pkt = in.read();
        if (pkt.last)
        {
            break;
        }

        int row = pkt.row;
        if ((unsigned)row < (unsigned)num_rows)
        {
            y_partial[row] += pkt.val * pkt.x;
        }
    }
}

static void reduce_and_write_packed(int num_rows, float y_partial[NUM_PES][MAX_ROWS], float16 *y_out)
{
#pragma HLS INLINE off
    const int words = CEIL_DIV(num_rows, PACK_SIZE);

    for (int w = 0; w < words; ++w)
    {
        float16 out_word;

        for (int lane = 0; lane < PACK_SIZE; ++lane)
        {
#pragma HLS PIPELINE II = 1
            const int idx = w * PACK_SIZE + lane;
            float sum = 0.0f;

            if (idx < num_rows)
            {
                for (int pe = 0; pe < NUM_PES; ++pe)
                {
#pragma HLS UNROLL
                    sum += y_partial[pe][idx];
                    y_partial[pe][idx] = 0.0f;
                }
            }

            out_word[lane] = (idx < num_rows) ? sum : 0.0f;
        }

        y_out[w] = out_word;
    }
}

static void spmv_coo_dataflow(int num_rows,
                              int num_cols,
                              int nnz,
                              const int16 *A_row_idx,
                              const int16 *A_col_idx,
                              const float16 *A_values,
                              const float x_local[NNZ_LANES][MAX_COLS],
                              float y_partial[NUM_PES][MAX_ROWS])
{
#pragma HLS INLINE off
    hls::stream<NnzPack> nnz_stream("nnz_stream");
    hls::stream<NnzPkt> pe_streams[NUM_PES];

#pragma HLS STREAM variable = nnz_stream depth = 256
#pragma HLS STREAM variable = pe_streams depth = 256

#pragma HLS DATAFLOW
    read_nnz_packed(nnz, num_cols, A_row_idx, A_col_idx, A_values, x_local, nnz_stream);
    distribute_to_pe(nnz, nnz_stream, pe_streams);

    for (int pe = 0; pe < NUM_PES; ++pe)
    {
#pragma HLS UNROLL
        compute_pe(num_rows, pe_streams[pe], y_partial[pe]);
    }
}

void spmv_coo(int num_rows,
              int num_cols,
              int nnz,
              const int16 *A_row_idx,
              const int16 *A_col_idx,
              const float16 *A_values,
              const float16 *x,
              float16 *y)
{
#pragma HLS INTERFACE m_axi port = A_row_idx offset = slave bundle = gmem0 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = A_col_idx offset = slave bundle = gmem1 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = A_values offset = slave bundle = gmem2 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = y offset = slave bundle = gmem4 depth = MAX_ROW_WORDS

#pragma HLS INTERFACE s_axilite port = num_rows bundle = control
#pragma HLS INTERFACE s_axilite port = num_cols bundle = control
#pragma HLS INTERFACE s_axilite port = nnz bundle = control
#pragma HLS INTERFACE s_axilite port = A_row_idx bundle = control
#pragma HLS INTERFACE s_axilite port = A_col_idx bundle = control
#pragma HLS INTERFACE s_axilite port = A_values bundle = control
#pragma HLS INTERFACE s_axilite port = x bundle = control
#pragma HLS INTERFACE s_axilite port = y bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

    if (num_rows > MAX_ROWS || num_cols > MAX_COLS || nnz > MAX_NNZ)
    {
        return;
    }

    float x_local[NNZ_LANES][MAX_COLS];
#pragma HLS ARRAY_PARTITION variable = x_local complete dim = 1
// #pragma HLS BIND_STORAGE variable = x_local type = ram_t2p impl = uram
    load_x(num_cols, x, x_local);

    static float y_partial[NUM_PES][MAX_ROWS];

#pragma HLS ARRAY_PARTITION variable = y_partial complete dim = 1
#pragma HLS BIND_STORAGE variable = y_partial type = ram_t2p impl = uram

    // Execute dataflow computation (x values are prefetched during NNZ reading)
    spmv_coo_dataflow(num_rows, num_cols, nnz, A_row_idx, A_col_idx, A_values, x_local, y_partial);

    reduce_and_write_packed(num_rows, y_partial, y);
}
