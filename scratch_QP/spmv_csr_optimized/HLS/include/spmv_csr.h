#ifndef SPMV_CSR_H
#define SPMV_CSR_H

#include "hls_stream.h"
#include "hls_vector.h"

#define MAX_COLS 1024
#define MAX_ROWS 1024

#define PACK_SIZE 16

// 512 bit packed types (16 floats per packet)
typedef hls::vector<float, PACK_SIZE> float16;
typedef hls::vector<int, PACK_SIZE> int16;

void spmv_csr(int num_rows, int num_cols, int nnz, const int *A_row_index, const int16 *A_col_index, const float16 *A_values, const float16 *x, float *y);

#endif // SPMV_CSR_H