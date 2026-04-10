#ifndef SPMV_H
#define SPMV_H

#define MAX_COLS 1024
#define MAX_ROWS 1024

void spmv_csr(int num_rows, int num_cols, const int *A_row_index, const int *A_col_index, const float *A_values, const float *x, float *y);

#endif // SPMV_H