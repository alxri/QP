#include "spmv_csc.h"

#include "ap_int.h"

#ifndef NUM_PES
#define NUM_PES 8
#endif

static constexpr int NNZ_LANES = (NUM_PES < PACK_SIZE) ? NUM_PES : PACK_SIZE;

struct NnzPack
{
    int row[NNZ_LANES];
    float val[NNZ_LANES];
    ap_uint<8> n;
};

struct NnzPkt
{
    int row;
    float val;
    float x;
    bool last;
};

struct ColMeta
{
    int nnz;
    float x;
};

static void read_col_meta(int num_cols,
                          const int *A_col_ptr,
                          const float16 *x_in,
                          hls::stream<ColMeta> &col_meta_stream)
{
#pragma HLS INLINE off
    int prev = A_col_ptr[0];

    const int words = CEIL_DIV(num_cols, PACK_SIZE);
    int col = 0;
    for (int w = 0; w < words; ++w)
    {
        float16 xw = x_in[w];
        for (int lane = 0; lane < PACK_SIZE; ++lane)
        {
#pragma HLS PIPELINE II = 1
            if (col < num_cols)
            {
                int next = A_col_ptr[col + 1];

                ColMeta meta;
                meta.nnz = next - prev;
                meta.x = xw[lane];
                col_meta_stream.write(meta);

                prev = next;
                ++col;
            }
        }
    }
}

static void read_nnz_packed(int nnz,
                            const int16 *row_in,
                            const float16 *val_in,
                            hls::stream<NnzPack> &nnz_stream)
{
#pragma HLS INLINE off
    const int words = CEIL_DIV(nnz, PACK_SIZE);
    int idx = 0;

    for (int w = 0; w < words; ++w)
    {
        int16 rows = row_in[w];
        float16 vals = val_in[w];

        for (int base = 0; base < PACK_SIZE; base += NNZ_LANES)
        {
#pragma HLS PIPELINE II = 1
            if (idx < nnz)
            {
                NnzPack pack;
                int count = nnz - idx;
                if (count > NNZ_LANES)
                    count = NNZ_LANES;
                const int remaining_in_word = PACK_SIZE - base;
                if (count > remaining_in_word)
                    count = remaining_in_word;

                pack.n = (ap_uint<8>)count;

                for (int i = 0; i < NNZ_LANES; ++i)
                {
#pragma HLS UNROLL
                    if (i < count)
                    {
                        pack.row[i] = rows[base + i];
                        pack.val[i] = vals[base + i];
                    }
                    else
                    {
                        pack.row[i] = 0;
                        pack.val[i] = 0.0f;
                    }
                }

                nnz_stream.write(pack);
                idx += count;
            }
        }
    }
}

static void distribute_to_pe(int num_cols,
                             hls::stream<ColMeta> &col_meta_stream,
                             hls::stream<NnzPack> &nnz_stream,
                             hls::stream<NnzPkt> pe_streams[NUM_PES])
{
#pragma HLS INLINE off
    int pe = 0;

    NnzPack pack;
#pragma HLS ARRAY_PARTITION variable = pack.row complete
#pragma HLS ARRAY_PARTITION variable = pack.val complete
    int pack_pos = 0;
    int pack_n = 0;

    int cols_loaded = 0;
    int col_nnz = 0;
    float x_i = 0.0f;

    // Flattened control: one pipelined loop handles both
    // (a) loading per-column metadata and (b) distributing NNZs.
    // Tail-chaining the next column meta hides the boundary bubble when
    // columns have few NNZs.
    while ((cols_loaded < num_cols) || (col_nnz > 0))
    {
#pragma HLS PIPELINE II = 1
        if (col_nnz == 0)
        {
            ColMeta meta = col_meta_stream.read();
            ++cols_loaded;
            col_nnz = meta.nnz;
            x_i = meta.x;
            continue;
        }

        const float x_cur = x_i;

        if (pack_pos >= pack_n)
        {
            pack = nnz_stream.read();
            pack_n = (int)pack.n;
            pack_pos = 0;
        }

        int available = pack_n - pack_pos;
        int send = (available < col_nnz) ? available : col_nnz;
        if (send > NNZ_LANES)
            send = NNZ_LANES;

        NnzPkt pkts[NNZ_LANES];
#pragma HLS ARRAY_PARTITION variable = pkts complete

        for (int i = 0; i < NNZ_LANES; ++i)
        {
#pragma HLS UNROLL
            if (i < send)
            {
                pkts[i].row = pack.row[pack_pos + i];
                pkts[i].val = pack.val[pack_pos + i];
                pkts[i].x = x_cur;
                pkts[i].last = false;
            }
            else
            {
                pkts[i].row = 0;
                pkts[i].val = 0.0f;
                pkts[i].x = 0.0f;
                pkts[i].last = false;
            }
        }

        for (int j = 0; j < NUM_PES; ++j)
        {
#pragma HLS UNROLL
            int rel = j - pe;
            if (rel < 0)
                rel += NUM_PES;
            if (rel < send)
            {
                pe_streams[j].write(pkts[rel]);
            }
        }

        pe += send;
        if (pe >= NUM_PES)
            pe -= NUM_PES;
        pack_pos += send;
        col_nnz -= send;

        // Tail-chain: if we just finished this column, load the next column's
        // metadata in the same cycle so the next iteration can immediately
        // start distributing.
        if ((col_nnz == 0) && (cols_loaded < num_cols))
        {
            ColMeta meta = col_meta_stream.read();
            ++cols_loaded;
            col_nnz = meta.nnz;
            x_i = meta.x;
        }
    }

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

static void compute_pe(int num_rows, hls::stream<NnzPkt> &in, float y_local[MAX_ROWS])
{
#pragma HLS INLINE off
    for (int i = 0; i < num_rows; ++i)
    {
#pragma HLS PIPELINE II = 1
        y_local[i] = 0.0f;
    }

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
            y_local[row] += pkt.val * pkt.x;
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
                }
            }

            out_word[lane] = (idx < num_rows) ? sum : 0.0f;
        }

        y_out[w] = out_word;
    }
}

static void spmv_csc_dataflow(int num_rows,
                              int num_cols,
                              int nnz,
                              const int16 *A_row_idx,
                              const int *A_col_ptr,
                              const float16 *A_values,
                              const float16 *x,
                              float y_partial[NUM_PES][MAX_ROWS])
{
#pragma HLS INLINE off

    hls::stream<ColMeta> col_meta_stream("col_meta_stream");
    hls::stream<NnzPack> nnz_stream("nnz_stream");
    hls::stream<NnzPkt> pe_streams[NUM_PES];

#pragma HLS STREAM variable = col_meta_stream depth = 64
#pragma HLS STREAM variable = nnz_stream depth = 256
#pragma HLS STREAM variable = pe_streams depth = 256

#pragma HLS DATAFLOW
    read_col_meta(num_cols, A_col_ptr, x, col_meta_stream);
    read_nnz_packed(nnz, A_row_idx, A_values, nnz_stream);
    distribute_to_pe(num_cols, col_meta_stream, nnz_stream, pe_streams);

    for (int pe = 0; pe < NUM_PES; ++pe)
    {
#pragma HLS UNROLL
        compute_pe(num_rows, pe_streams[pe], y_partial[pe]);
    }
}

void spmv_csc(int num_rows,
              int num_cols,
              int nnz,
              const int16 *A_row_idx,
              const int *A_col_ptr,
              const float16 *A_values,
              const float16 *x,
              float16 *y)
{
#pragma HLS INTERFACE m_axi port = A_row_idx offset = slave bundle = gmem0 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = A_col_ptr offset = slave bundle = gmem1 depth = MAX_COL_PTR
#pragma HLS INTERFACE m_axi port = A_values offset = slave bundle = gmem2 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = gmem3 depth = MAX_COL_WORDS
#pragma HLS INTERFACE m_axi port = y offset = slave bundle = gmem4 depth = MAX_ROW_WORDS

#pragma HLS INTERFACE s_axilite port = num_rows bundle = control
#pragma HLS INTERFACE s_axilite port = num_cols bundle = control
#pragma HLS INTERFACE s_axilite port = nnz bundle = control
#pragma HLS INTERFACE s_axilite port = A_row_idx bundle = control
#pragma HLS INTERFACE s_axilite port = A_col_ptr bundle = control
#pragma HLS INTERFACE s_axilite port = A_values bundle = control
#pragma HLS INTERFACE s_axilite port = x bundle = control
#pragma HLS INTERFACE s_axilite port = y bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

    if (num_rows > MAX_ROWS || num_cols > MAX_COLS || nnz > MAX_NNZ)
    {
        return;
    }

    float y_partial[NUM_PES][MAX_ROWS];
#pragma HLS ARRAY_PARTITION variable = y_partial complete dim = 1

    spmv_csc_dataflow(num_rows, num_cols, nnz, A_row_idx, A_col_ptr, A_values, x, y_partial);

    reduce_and_write_packed(num_rows, y_partial, y);
}