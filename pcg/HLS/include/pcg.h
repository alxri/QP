#ifndef PCG_H
#define PCG_H

#include "spmv_csc.h"

#ifndef MAX_SIZE
#define MAX_SIZE 65536
#endif

void pcg(int num_rows,
         int num_cols,
         const int16 *A_row_idx,
         const int *A_col_ptr,
         const float16 *A_values,
         int A_nnz,
         const int16 *AT_row_idx,
         const int *AT_col_ptr,
         const float16 *AT_values,
         const int16 *P_row_idx,
         const int *P_col_ptr,
         const float16 *P_values,
         int P_nnz,
         const float *M_inv_in,
         const float *b_in,
         const float *rho_in,
         const float sigma,
         const float epsilon_sq,
         float *x);

#endif // PCG_H