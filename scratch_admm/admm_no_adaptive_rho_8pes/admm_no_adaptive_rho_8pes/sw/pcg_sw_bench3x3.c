#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>
#include <time.h>
#include <string.h>

#define NUM_ROWS 3
#define NUM_COLS 3
#define MAX_ITER 1000

// =====================================================================
// Helper Functions
// =====================================================================
double get_time_ms() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (ts.tv_sec * 1000.0) + (ts.tv_nsec / 1000000.0);
}

void spmv_sw_csc(int rows, int cols, const int *col_ptr, const int *row_idx, 
                 const float *values, const float *x, float *y) 
{
    for(int i = 0; i < rows; i++) y[i] = 0.0f;
    for (int c = 0; c < cols; ++c) {
        float xc = x[c];
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx) {
            y[row_idx[idx]] += values[idx] * xc;
        }
    }
}

void transpose_csc(int rows, int cols, const int *col_ptr, const int *row_idx, const float *values,
                   int *col_ptr_t, int *row_idx_t, float *values_t) 
{
    for(int i = 0; i <= rows; i++) col_ptr_t[i] = 0;
    int *nnz_per_col = (int*)calloc(rows, sizeof(int));
    int nnz = col_ptr[cols];

    for (int idx = 0; idx < nnz; ++idx) nnz_per_col[row_idx[idx]]++;
    for (int c = 0; c < rows; ++c) col_ptr_t[c + 1] = col_ptr_t[c] + nnz_per_col[c];

    int *next = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) next[i] = col_ptr_t[i];

    for (int c = 0; c < cols; ++c) {
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx) {
            int r = row_idx[idx];
            int dst = next[r]++;
            row_idx_t[dst] = c;
            values_t[dst] = values[idx];
        }
    }
    free(nnz_per_col); free(next);
}

// Applies the operator K = P + sigma*I + AT*diag(rho)*A
void apply_K(int rows, int cols, const int *A_col_ptr, const int *A_row_idx, const float *A_values,
             const int *AT_col_ptr, const int *AT_row_idx, const float *AT_values,
             const int *P_col_ptr, const int *P_row_idx, const float *P_values,
             const float *rho, float sigma, const float *x, float *y) 
{
    float tmp0[NUM_ROWS], tmp1[NUM_ROWS], tmp2[NUM_COLS], px[NUM_COLS];

    spmv_sw_csc(rows, cols, A_col_ptr, A_row_idx, A_values, x, tmp0);
    for (int i = 0; i < rows; ++i) tmp1[i] = rho[i] * tmp0[i];
    
    spmv_sw_csc(cols, rows, AT_col_ptr, AT_row_idx, AT_values, tmp1, tmp2);
    spmv_sw_csc(cols, cols, P_col_ptr, P_row_idx, P_values, x, px);

    for (int i = 0; i < cols; ++i) {
        y[i] = tmp2[i] + px[i] + (sigma * x[i]);
    }
}

// Software implementation of the PCG Solver
int pcg_solver(int rows, int cols, 
               const int *A_col_ptr, const int *A_row_idx, const float *A_values,
               const int *AT_col_ptr, const int *AT_row_idx, const float *AT_values,
               const int *P_col_ptr, const int *P_row_idx, const float *P_values,
               const float *M_inv, const float *b, const float *rho, 
               float sigma, float epsilon_sq, float *x) 
{
    float r[NUM_COLS], z[NUM_COLS], p[NUM_COLS], Kp[NUM_COLS];

    double norm_b2 = 0.0;
    for(int i=0; i<cols; i++) {
        x[i] = 0.0f;             // Initial guess x = 0
        r[i] = b[i];             // r = b - Kx => r = b
        norm_b2 += b[i] * b[i];
        z[i] = M_inv[i] * r[i];  // z = M_inv * r
        p[i] = z[i];             // p = z
    }

    double rsold = 0.0;
    for(int i=0; i<cols; i++) rsold += r[i] * z[i];

    int iter;
    for (iter = 0; iter < MAX_ITER; ++iter) {
        // Kp = K * p
        apply_K(rows, cols, A_col_ptr, A_row_idx, A_values, AT_col_ptr, AT_row_idx, AT_values,
                P_col_ptr, P_row_idx, P_values, rho, sigma, p, Kp);

        double p_Kp = 0.0;
        for(int i=0; i<cols; i++) p_Kp += p[i] * Kp[i];

        double alpha = rsold / p_Kp;

        double norm_r2 = 0.0;
        for(int i=0; i<cols; i++) {
            x[i] = x[i] + alpha * p[i];
            r[i] = r[i] - alpha * Kp[i];
            norm_r2 += r[i] * r[i];
        }

        // Convergence check
        if (norm_r2 < epsilon_sq * norm_b2) break;

        double rsnew = 0.0;
        for(int i=0; i<cols; i++) {
            z[i] = M_inv[i] * r[i];
            rsnew += r[i] * z[i];
        }

        double beta = rsnew / rsold;
        for(int i=0; i<cols; i++) {
            p[i] = z[i] + beta * p[i];
        }
        rsold = rsnew;
    }

    return iter + 1; // Return number of iterations it took
}

// =====================================================================
// Main Logic
// =====================================================================
int main() {
    printf("\n--- Starting PCG Software Baseline (3x3 Denser Case, 1-Thread C) ---\n");

    float sigma = 0.1f;
    float epsilon_sq = 1e-8f;

    // 1. Matrix Setup (Denser 3x3 Case)
    int A_col_ptr[] = {0, 2, 3, 5};
    int A_row_idx[] = {0, 2, 1, 0, 2};
    float A_values[]  = {1.5f, 0.5f, 2.0f, -0.5f, 1.5f};
    int A_nnz = 5;

    int AT_col_ptr[NUM_COLS + 1];
    int AT_row_idx[A_nnz];
    float AT_values[A_nnz];
    transpose_csc(NUM_ROWS, NUM_COLS, A_col_ptr, A_row_idx, A_values, AT_col_ptr, AT_row_idx, AT_values);

    int P_col_ptr[] = {0, 1, 2, 3};
    int P_row_idx[] = {0, 1, 2};
    float P_values[]  = {5.0f, 1.0f, 3.0f};

    float rho[] = {2.0f, 0.5f, 1.0f};
    float b[]   = {4.0f, -1.0f, 2.0f};
    float M_inv[NUM_COLS];
    float x_out[NUM_COLS];

    for (int c = 0; c < NUM_COLS; ++c) {
        float diagK = P_values[c] + sigma;
        for (int idx = A_col_ptr[c]; idx < A_col_ptr[c + 1]; ++idx) {
            float v = A_values[idx];
            diagK += rho[A_row_idx[idx]] * (v * v);
        }
        M_inv[c] = 1.0f / diagK;
        x_out[c] = 0.0f;
    }

    // 2. Execute PCG Solver
    printf("Starting CPU PCG Solver...\n");
    double sw_start = get_time_ms();

    int iters = pcg_solver(NUM_ROWS, NUM_COLS, 
                           A_col_ptr, A_row_idx, A_values,
                           AT_col_ptr, AT_row_idx, AT_values,
                           P_col_ptr, P_row_idx, P_values,
                           M_inv, b, rho, sigma, epsilon_sq, x_out);

    double sw_end = get_time_ms();
    
    printf("CPU Execution Time: %.4f ms\n", sw_end - sw_start);
    printf("PCG Converged in %d iterations.\n", iters);
    printf("x_out = [%.6f, %.6f, %.6f]\n", x_out[0], x_out[1], x_out[2]);

    // 3. Verification Check
    float Kx[NUM_COLS];
    apply_K(NUM_ROWS, NUM_COLS, A_col_ptr, A_row_idx, A_values, 
            AT_col_ptr, AT_row_idx, AT_values, P_col_ptr, P_row_idx, P_values, 
            rho, sigma, x_out, Kx);

    double norm_b2 = 0.0, norm_r2 = 0.0;
    for (int i = 0; i < NUM_COLS; ++i) {
        double bi = (double)b[i];
        double ri = (double)Kx[i] - bi;
        norm_b2 += bi * bi;
        norm_r2 += ri * ri;
    }

    double rel_res = sqrt(norm_r2 / (norm_b2 + 1e-30));
    double target = sqrt(epsilon_sq);

    printf("\n--- Results ---\n");
    printf("||b||^2    = %e\n", norm_b2);
    printf("||Kx-b||^2 = %e\n", norm_r2);
    printf("rel_res    = %e\n", rel_res);

    if (rel_res <= 5.0 * target) {
        printf(">>> SUCCESS: PCG SW residual meets tolerance (~%e)! <<<\n", target);
    } else {
        printf(">>> ERROR: Residual too large (Target ~ %e). <<<\n", target);
    }

    return 0;
}