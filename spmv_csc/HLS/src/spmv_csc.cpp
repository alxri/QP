#include "spmv_csc.h"

#ifndef NUM_PES
#define NUM_PES 8
#endif

struct NnzPair
{
    int row;
    float val;
};

struct NnzPkt
{
    int row;
    float val;
    float x;
    bool last;
};

static void read_x_packed(int num_cols, const float16 *x_in, hls::stream<float> &x_stream)
{
#pragma HLS INLINE off
    const int words = CEIL_DIV(num_cols, PACK_SIZE);
    int idx = 0;

    for (int w = 0; w < words; ++w)
    {
        float16 xw = x_in[w];
        for (int lane = 0; lane < PACK_SIZE; ++lane)
        {
#pragma HLS PIPELINE II = 1
            if (idx < num_cols)
            {
                x_stream.write(xw[lane]);
                ++idx;
            }
        }
    }
}

static void read_nnz_packed(int nnz,
                            const int16 *row_in,
                            const float16 *val_in,
                            hls::stream<NnzPair> &nnz_stream)
{
#pragma HLS INLINE off
    const int words = CEIL_DIV(nnz, PACK_SIZE);
    int idx = 0;

    for (int w = 0; w < words; ++w)
    {
        int16 rows = row_in[w];
        float16 vals = val_in[w];
        for (int lane = 0; lane < PACK_SIZE; ++lane)
        {
#pragma HLS PIPELINE II = 1
            if (idx < nnz)
            {
                NnzPair p;
                p.row = rows[lane];
                p.val = vals[lane];
                nnz_stream.write(p);
                ++idx;
            }
        }
    }
}

static void distribute_to_pe(int num_cols,
                          const int *A_col_ptr,
                          hls::stream<float> &x_stream,
                          hls::stream<NnzPair> &nnz_stream,
                          hls::stream<NnzPkt> pe_streams[NUM_PES])
{
#pragma HLS INLINE off
    int prev = A_col_ptr[0];
    int pe = 0;

    for (int col = 0; col < num_cols; ++col)
    {
        int next = A_col_ptr[col + 1];
        int col_nnz = next - prev;
        prev = next;

        float x_i = x_stream.read();

        for (int t = 0; t < col_nnz; ++t)
        {
#pragma HLS PIPELINE II = 1
            NnzPair pair = nnz_stream.read();

            NnzPkt pkt;
            pkt.row = pair.row;
            pkt.val = pair.val;
            pkt.x = x_i;
            pkt.last = false;

            pe_streams[pe].write(pkt);
            pe = (pe == (NUM_PES - 1)) ? 0 : (pe + 1);
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

    hls::stream<float> x_stream("x_stream");
    hls::stream<NnzPair> nnz_stream("nnz_stream");
    hls::stream<NnzPkt> pe_streams[NUM_PES];

#pragma HLS STREAM variable = x_stream depth = 64
#pragma HLS STREAM variable = nnz_stream depth = 256
#pragma HLS STREAM variable = pe_streams depth = 256

#pragma HLS DATAFLOW
    read_x_packed(num_cols, x, x_stream);
    read_nnz_packed(nnz, A_row_idx, A_values, nnz_stream);
    distribute_to_pe(num_cols, A_col_ptr, x_stream, nnz_stream, pe_streams);

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