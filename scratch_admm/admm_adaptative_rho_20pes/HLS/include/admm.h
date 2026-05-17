#ifndef ADMM_H
#define ADMM_H

#include "spmv_csc.h"
#include "pcg.h"
#include "hls_math.h"

#ifndef MAX_SIZE
#define MAX_SIZE 1024
#endif

void admm(int num_rows,
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
          const float *P_diag,
          const float *l_in,
          const float *u_in,
          const float *q_in,
          float sigma,
          float alpha,
          float *rho_in,
          int admm_max_iterations,
          int pcg_max_iterations,
          bool adaptive_rho,
          float eps_abs,
          float eps_rel,
          float pcg_tol_fraction,
          float *x_out,
          float *y_out,
          int *admm_num_iterations_out,
          int *pcg_num_iterations_out,
          float *r_prim_out,
          float *r_dual_out,
          int *status_out);

#endif // ADMM_H
