#include "spmv_csc.h"

#ifndef MAX_ROWS
#define MAX_ROWS 65536
#endif

void spmv_csc(int num_rows,
                       int num_cols,
                       int nnz,
                       const int *A_row_idx,
                       const int *A_col_ptr,
                       const float *A_values,
                       const float *x,
                       float *y,
                       bool clear_y,
                       bool write_y)
{
#pragma HLS INTERFACE m_axi port = A_row_idx offset = slave bundle = gmem0 depth = MAX_NNZ
#pragma HLS INTERFACE m_axi port = A_col_ptr offset = slave bundle = gmem1 depth = MAX_COLS + 1
#pragma HLS INTERFACE m_axi port = A_values  offset = slave bundle = gmem2 depth = MAX_NNZ
#pragma HLS INTERFACE m_axi port = x         offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = y         offset = slave bundle = gmem4 depth = MAX_ROWS

#pragma HLS INTERFACE s_axilite port = num_rows  bundle = control
#pragma HLS INTERFACE s_axilite port = num_cols  bundle = control
#pragma HLS INTERFACE s_axilite port = nnz       bundle = control
#pragma HLS INTERFACE s_axilite port = clear_y   bundle = control
#pragma HLS INTERFACE s_axilite port = write_y   bundle = control
#pragma HLS INTERFACE s_axilite port = return    bundle = control

    if (num_rows > MAX_ROWS || num_cols > MAX_COLS)
    {
        return;
    }

    static float y_internal[MAX_ROWS];

    if (clear_y)
    {
        for (int i = 0; i < num_rows; ++i)
        {
            y_internal[i] = 0.0f;
        }
    }

    for (int col = 0; col < num_cols; ++col)
    {
        float x_val = x[col];
        int start_idx = A_col_ptr[col];
        int end_idx = A_col_ptr[col + 1];

        for (int i = start_idx; i < end_idx; ++i)
        {
            int row = A_row_idx[i];
            
            if ((unsigned)row < (unsigned)num_rows)
            {
                y_internal[row] += A_values[i] * x_val;
            }
        }
    }

    if (write_y)
    {
        for (int i = 0; i < num_rows; ++i)
        {
            y[i] = y_internal[i];
        }
    }
}