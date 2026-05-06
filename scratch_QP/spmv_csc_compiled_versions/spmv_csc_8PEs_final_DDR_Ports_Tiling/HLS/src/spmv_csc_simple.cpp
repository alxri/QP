#include "spmv_csc.h"

static void compute_spmv(int          num_cols,
                         const int   *A_col_ptr,
                         const int   *A_row_idx,
                         const float *A_values,
                         const float *x,
                               float  y_buf[MAX_ROWS])
{
    for (int i = 0; i < num_cols; i++) {
        int   col_start = A_col_ptr[i];
        int   col_end   = A_col_ptr[i + 1];
        float x_i       = x[i]; // Read sequentially directly from AXI

        for (int k = col_start; k < col_end; k++) {
#pragma HLS PIPELINE II=1
// #pragma HLS DEPENDENCE variable=y_buf type=inter false
            // Read sequentially directly from AXI
            int   row = A_row_idx[k];
            float val = A_values[k];
            
            // Random access happens safely inside the fast BRAM
            y_buf[row] += val * x_i;
        }
    }
}

void spmv_csc(int    num_rows,
              int    num_cols,
              int    nnz,
              int   *A_row_idx,
              int   *A_col_ptr,
              float *A_values,
              float *x,
              float *y)
{
#pragma HLS INTERFACE m_axi port=A_row_idx offset=slave bundle=gmem0 depth=106000
#pragma HLS INTERFACE m_axi port=A_col_ptr offset=slave bundle=gmem1 depth=1025
#pragma HLS INTERFACE m_axi port=A_values  offset=slave bundle=gmem2 depth=106000
#pragma HLS INTERFACE m_axi port=x         offset=slave bundle=gmem3 depth=1024
#pragma HLS INTERFACE m_axi port=y         offset=slave bundle=gmem4 depth=1024

#pragma HLS INTERFACE s_axilite port=num_rows  bundle=control
#pragma HLS INTERFACE s_axilite port=num_cols  bundle=control
#pragma HLS INTERFACE s_axilite port=nnz       bundle=control
#pragma HLS INTERFACE s_axilite port=A_row_idx bundle=control
#pragma HLS INTERFACE s_axilite port=A_col_ptr bundle=control
#pragma HLS INTERFACE s_axilite port=A_values  bundle=control
#pragma HLS INTERFACE s_axilite port=x         bundle=control
#pragma HLS INTERFACE s_axilite port=y         bundle=control
#pragma HLS INTERFACE s_axilite port=return    bundle=control

    // ONLY allocate y_buf in local BRAM because it requires random access
    float y_buf[MAX_ROWS];

    // Initialize y_buf to zero
    for (int i = 0; i < num_rows; i++) {
#pragma HLS PIPELINE II=1
        y_buf[i] = 0.0f;
    }

    // Compute (reading streaming data directly from DDR)
    compute_spmv(num_cols, A_col_ptr, A_row_idx, A_values, x, y_buf);

    // Write output burst back to DDR
    for (int i = 0; i < num_rows; i++) {
#pragma HLS PIPELINE II=1
        y[i] = y_buf[i];
    }
}