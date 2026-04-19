#include "spmv_csr.h"

void spmv_csr(int num_rows, int num_cols, const int *A_row_index, const int *A_col_index, const float *A_values, const float *x, float *y)
{
    #pragma HLS INTERFACE m_axi port=A_row_index offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=A_col_index offset=slave bundle=gmem1
    #pragma HLS INTERFACE m_axi port=A_values offset=slave bundle=gmem2
    #pragma HLS INTERFACE m_axi port=x offset=slave bundle=gmem3
    #pragma HLS INTERFACE m_axi port=y offset=slave bundle=gmem4

    #pragma HLS INTERFACE s_axilite port=num_rows bundle=control
    #pragma HLS INTERFACE s_axilite port=num_cols bundle=control
    #pragma HLS INTERFACE s_axilite port=A_row_index bundle=control
    #pragma HLS INTERFACE s_axilite port=A_col_index bundle=control
    #pragma HLS INTERFACE s_axilite port=A_values bundle=control
    #pragma HLS INTERFACE s_axilite port=x bundle=control
    #pragma HLS INTERFACE s_axilite port=y bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    float x_buf[MAX_COLS];

    READ_X:
    for (int i = 0; i < num_cols; i++) {
    #pragma HLS PIPELINE II=1
        x_buf[i] = x[i];
    }

    L1:
    for (int i = 0; i < num_rows; i++) {
        float sum = 0;

        int row_start = A_row_index[i];
        int row_end = A_row_index[i + 1];

        L2:
        for (int j = row_start; j < row_end; j++) {
        #pragma HLS PIPELINE II=1

            float val = A_values[j];
            int col = A_col_index[j];
            sum += val * x_buf[col];
    }
        y[i] = sum;
    }
}