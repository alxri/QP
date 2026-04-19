#include "spmv_csr.h"
 

// Number of 512 bit packets read per burst
#define BURST_SIZE 16


// Worker 1: Fetches matrix data from global memory and feeds it into the pipeline
void fetch_matrix(int nnz, const float16 *A_values, const int16 *A_col_index, hls::stream<float> &val_stream, hls::stream<int> &col_stream)
{
   // Total number of 16-element chunks in the whole matrix
    int total_chunks = (nnz + PACK_SIZE - 1) / PACK_SIZE;

    // Outer Loop: Request one burst of data at a time
    for (int chunk = 0; chunk < total_chunks; chunk += BURST_SIZE) {
        
        // Calculate how many elements to read in this specific burst
        int current_burst_size = BURST_SIZE;
        if (chunk + BURST_SIZE > total_chunks) {
            current_burst_size = total_chunks - chunk;
        }

        // Inner Loop: The actual memory fetch
        // Because this loop is small, if the FIFO fills up after this loop finishes,
        // the AXI bus is in a safe, idle state and can wait forever.
        for (int i = 0; i < current_burst_size; i++) {
            #pragma HLS PIPELINE II=1
            
            float16 v_chunk = A_values[chunk + i];
            int16   c_chunk = A_col_index[chunk + i];

            // Unpack the 512-bit vector into the streams
            for (int k = 0; k < PACK_SIZE; k++) {
                int global_idx = (chunk + i) * PACK_SIZE + k;
                if (global_idx < nnz) {
                    val_stream.write(v_chunk[k]);
                    col_stream.write(c_chunk[k]);
                }
            }
        }
    }
}

#define ACC_LATENCY 4
// Worker 2: Consumes matrix data from the FIFO streams and performs the SpMV computation
void compute_spmv(int num_rows, const int *A_row_index, const float *x_buf, hls::stream<float> &val_stream, hls::stream<int> &col_stream, float *y)
{
    for (int i = 0; i < num_rows; i++) {
        
        // 1. Create buckets to hide the floating point latency
        float partial_sums[ACC_LATENCY];
        #pragma HLS ARRAY_PARTITION variable=partial_sums complete
        
        for (int p = 0; p < ACC_LATENCY; p++) {
            #pragma HLS UNROLL
            partial_sums[p] = 0.0f;
        }

        int row_start = A_row_index[i];
        int row_end = A_row_index[i + 1];

        // For each non-zero in the row, read from the streams and perform the multiply-add
        for (int j = row_start; j < row_end; j++) {
            #pragma HLS PIPELINE II=1
            // CRITICAL: Force compiler to ignore the loop dependency
            #pragma HLS DEPENDENCE variable=partial_sums type=inter false
            
            float val = val_stream.read();
            int col = col_stream.read();
            
            // 2. Distribute the math round-robin across the buckets
            int acc_idx = (j - row_start) % ACC_LATENCY;
            partial_sums[acc_idx] += val * x_buf[col];
        }

        // 3. Add the buckets together at the end of the row
        float final_sum = 0.0f;
        for (int p = 0; p < ACC_LATENCY; p++) {
            #pragma HLS UNROLL
            final_sum += partial_sums[p];
        }
        
        y[i] = final_sum;
    }
}

// Top level function
void spmv_csr(int num_rows, int num_cols, int nnz, const int *A_row_index, const int16 *A_col_index, const float16 *A_values, const float16 *x, float *y)
{
    // AXI Master Interfaces
    // Depth only for cosim!!!!!
    #pragma HLS INTERFACE m_axi port=A_row_index offset=slave bundle=gmem0 depth=1025
    #pragma HLS INTERFACE m_axi port=A_col_index offset=slave bundle=gmem1 depth=8000
    #pragma HLS INTERFACE m_axi port=A_values    offset=slave bundle=gmem2 depth=8000
    #pragma HLS INTERFACE m_axi port=x           offset=slave bundle=gmem3 depth=64
    #pragma HLS INTERFACE m_axi port=y           offset=slave bundle=gmem4 depth=1024

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

    // Read A_row_index into local buffer
    int A_row_buf[MAX_ROWS + 1];
    for (int i = 0; i < num_rows + 1; i++) {
        #pragma HLS PIPELINE II=1
        A_row_buf[i] = A_row_index[i];
    }
        
    // Run dataflow workers in parallel
    hls::stream<float> val_stream;
    hls::stream<int> col_stream;

    // Set FIFO sizes
    #pragma HLS STREAM variable=val_stream depth=1024
    #pragma HLS STREAM variable=col_stream depth=1024

    #pragma HLS DATAFLOW
    fetch_matrix(nnz, A_values, A_col_index, val_stream, col_stream);
    compute_spmv(num_rows, A_row_buf, x_buf, val_stream, col_stream, y);
}
    