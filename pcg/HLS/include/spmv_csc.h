#ifndef SPMV_CSC_H
#define SPMV_CSC_H

#include "hls_stream.h"
#include "hls_vector.h"

#ifndef MAX_COLS
#define MAX_COLS 1024
#endif

#ifndef MAX_ROWS
#define MAX_ROWS 1024
#endif

// Max number of non-zeros supported by the kernel (runtime nnz must be <= MAX_NNZ).
// IMPORTANT: keep this realistic. Setting MAX_NNZ = MAX_ROWS*MAX_COLS (dense) can make
// cosim wrappers copy huge buffers and may run out of host memory.
#ifndef MAX_NNZ
#define MAX_NNZ 200000 // For Vitis simulation purposes, not determining for hw
#endif

#ifndef PACK_SIZE
#define PACK_SIZE 16
#endif

#define CEIL_DIV(a, b) (((a) + (b) - 1) / (b))

#define MAX_COL_PTR (MAX_COLS + 1)
#define MAX_COL_WORDS CEIL_DIV(MAX_COLS, PACK_SIZE)
#define MAX_ROW_WORDS CEIL_DIV(MAX_ROWS, PACK_SIZE)
#define MAX_NNZ_WORDS CEIL_DIV(MAX_NNZ, PACK_SIZE)

// 512 bit packed types (16 floats per packet)
typedef hls::vector<float, PACK_SIZE> float16;
typedef hls::vector<int, PACK_SIZE> int16;

void spmv_csc(int num_rows,
              int num_cols,
              int nnz,
              const int16 *A_row_idx,
              const int *A_col_ptr,
              const float16 *A_values,
              const float *x,
              float *y);

#endif // SPMV_CSC_H