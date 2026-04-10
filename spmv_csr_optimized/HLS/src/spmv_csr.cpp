#include "spmv_csr.h"
 

// Worker 1: Fetches matrix data from global memory and feeds it into the pipeline
void fetch_matrix(int nnz, const float16 *A_values, const int16 *A_col_index, hls::stream<float> &val_stream, hls::stream<int> &col_stream)
{
    // Calculate how many 16-element chunks we need to read
    int nnz_full_chunks = nnz / PACK_SIZE;
    int nnz_remainder = nnz % PACK_SIZE;

    for (int i = 0; i < nnz_full_chunks; i++) {
#pragma HLS PIPELINE II=1
        
        // Fetch 512 bits (16 elements) in one clock cycle per stream
        float16 A_val_chunk = A_values[i];
        int16 A_col_chunk = A_col_index[i];

         for (int k = 0; k < PACK_SIZE; k++) {
            val_stream.write(A_val_chunk[k]);
            col_stream.write(A_col_chunk[k]);
        }
    }

    // Fetch remaining elements if nnz is not a multiple of PACK_SIZE
    if (nnz_remainder > 0) {
        float16 A_val_chunk = A_values[nnz_full_chunks];
        int16   A_col_chunk = A_col_index[nnz_full_chunks];
        for (int k = 0; k < nnz_remainder; k++) {
            val_stream.write(A_val_chunk[k]);
            col_stream.write(A_col_chunk[k]);
        }
    }
}

// Worker 2: Consumes matrix data from the FIFO streams and performs the SpMV computation
void compute_spmv(int nnz, int num_rows, const int *A_row_index, const float *x_buf, hls::stream<float> &val_stream, hls::stream<int> &col_stream, float *y)
{
    float sum = 0.0f;
    int current_row = 0;
    int row_end = A_row_index[1]; // end of row 0

    for (int j = 0; j < nnz; j++) {
#pragma HLS PIPELINE II=1
        float val = val_stream.read();
        int   col = col_stream.read();
        sum += val * x_buf[col];

        // Check if we've finished the current row
        if (j + 1 == row_end) {
            y[current_row] = sum;
            sum = 0.0f;
            current_row++;
            if (current_row < num_rows)
                row_end = A_row_index[current_row + 1];
        }
    }
}

// Top level function
void spmv_csr(int num_rows, int num_cols, int nnz, const int *A_row_index, const int16 *A_col_index, const float16 *A_values, const float16 *x, float *y)
{
    // AXI Master Interfaces
    #pragma HLS INTERFACE m_axi port=A_row_index offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi port=A_col_index offset=slave bundle=gmem1
    #pragma HLS INTERFACE m_axi port=A_values    offset=slave bundle=gmem2
    #pragma HLS INTERFACE m_axi port=x           offset=slave bundle=gmem3
    #pragma HLS INTERFACE m_axi port=y           offset=slave bundle=gmem4

    // AXI Lite Control Interfaces
    #pragma HLS INTERFACE s_axilite port=num_rows bundle=control
    #pragma HLS INTERFACE s_axilite port=num_cols bundle=control
    #pragma HLS INTERFACE s_axilite port=nnz      bundle=control
    #pragma HLS INTERFACE s_axilite port=A_row_index bundle=control
    #pragma HLS INTERFACE s_axilite port=A_col_index bundle=control
    #pragma HLS INTERFACE s_axilite port=A_values bundle=control
    #pragma HLS INTERFACE s_axilite port=x bundle=control
    #pragma HLS INTERFACE s_axilite port=y bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    // Read vector x
    float x_buf[MAX_COLS];
    int x_chunks = (num_cols + PACK_SIZE - 1) / PACK_SIZE;
    
    for (int i = 0; i < x_chunks; i++) {
        #pragma HLS PIPELINE II=1
        float16 x_chunk = x[i];
        for (int k = 0; k < PACK_SIZE; k++) {
            if (i * PACK_SIZE + k < num_cols) {
                x_buf[i * PACK_SIZE + k] = x_chunk[k];
            }
        }
    }

    // Read row index array
    int A_row_index_buf[MAX_ROWS + 1];
    for (int i = 0; i < num_rows + 1; i++) {
        #pragma HLS PIPELINE II=1
        A_row_index_buf[i] = A_row_index[i];
    }

    // Run dataflow workers in parallel
    hls::stream<float> val_stream;
    hls::stream<int> col_stream;

    // Set FIFO sizes
    #pragma HLS STREAM variable=val_stream depth=1024
    #pragma HLS STREAM variable=col_stream depth=1024

    #pragma HLS DATAFLOW
    fetch_matrix(nnz, A_values, A_col_index, val_stream, col_stream);
    compute_spmv(nnz, num_rows, A_row_index_buf, x_buf, val_stream, col_stream, y);
}
    