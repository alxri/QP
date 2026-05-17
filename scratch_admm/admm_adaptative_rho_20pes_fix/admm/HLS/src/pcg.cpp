#include "pcg.h"

#define RESHAPE_FACTOR 8

static float dot_prod(const float *x, const float *y, int size)
{
    // 4 accumulators to hide the final FP addition latency
    float acc0 = 0.0f;
    float acc1 = 0.0f;
    float acc2 = 0.0f;
    float acc3 = 0.0f;

    int i = 0;
    for (; i + 3 < size; i += 4) {
#pragma HLS PIPELINE II = 1
        // unroll 4 iterations of the loop
        const float p0 = x[i] * y[i];
        const float p1 = x[i + 1] * y[i + 1];
        const float p2 = x[i + 2] * y[i + 2];
        const float p3 = x[i + 3] * y[i + 3];

        // Add into the oldest partial sum, then rotate.
        const float sum_ab = p0 + p1;
        const float sum_cd = p2 + p3;
        const float sum_all = sum_ab + sum_cd;

        const float updated = acc0 + sum_all;
        acc0 = acc1;
        acc1 = acc2;
        acc2 = acc3;
        acc3 = updated;
    }

    for (; i < size; ++i) {
#pragma HLS PIPELINE II = 1
        acc0 += x[i] * y[i];
    }
    // Final reduction
    return (acc0 + acc1) + (acc2 + acc3);
}

// make struct for CSC data to reduce number of arguments and simplify function calls ?
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
         const float *M_inv,
         const float *rho,
         const float sigma,
         const float epsilon_sq,
         float *x,
         float *b,
         float *scratch1,
         float *scratch2,
         int *pcg_num_iterations,
         int pcg_max_iterations)
{
#pragma HLS INLINE
/* From ADMM receive
*   - Pointers of Matrix P in CSC format (P_col_ptr, P_row_idx, P_values) - read from DDR
*   - Pointers of Matrix A in CSC format (A_col_ptr, A_row_idx, A_values) - read from DDR
*   - Pointers of Transpose of A in CSC format (A_col_ptr_T, A_row_idx_T, A_values_T) - read from DDR
*
*   - Diagonal preconditioner M_inv (as a vector)
*
*   - Vector b, computed in ADMM
*   - Diagonal matrix rho (as a vector of its diagonal entries)
*   - Scalar sigma
*   - Scalar epsilon_sq (epsilon squared from CPU)
*/



// Local vector buffers for computation (Cannot be shared)
// float x_local[MAX_SIZE];
float r[MAX_SIZE];
float p[MAX_SIZE];
// float K_p[MAX_SIZE];
// float M_inv[MAX_SIZE];
// float rho[MAX_SIZE];

// Reusable scratchpads
// float scratch1[MAX_SIZE]; // b and tmp0 can share the same buffer as they are used at different times in the algorithm
// float scratch2[MAX_SIZE]; // y can also be used to store intermediate results like A*p and AT*(rho*(A*p)) to save memory, as they are used at different times in the algorithm

// #pragma HLS BIND_STORAGE variable=x_local type=RAM_T2P impl=URAM
// #pragma HLS ARRAY_RESHAPE variable=x_local type=cyclic factor=RESHAPE_FACTOR dim=1
// #pragma HLS BIND_STORAGE variable=scratch1 type=RAM_T2P impl=URAM
// #pragma HLS ARRAY_RESHAPE variable=scratch1 type=cyclic factor=RESHAPE_FACTOR dim=1
// #pragma HLS BIND_STORAGE variable=scratch2 type=RAM_T2P impl=URAM
// #pragma HLS ARRAY_RESHAPE variable=scratch2 type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=r type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=r type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=p type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=p type=cyclic factor=RESHAPE_FACTOR dim=1
// #pragma HLS BIND_STORAGE variable=K_p type=RAM_T2P impl=URAM
// #pragma HLS ARRAY_RESHAPE variable=K_p type=cyclic factor=RESHAPE_FACTOR dim=1


// #pragma HLS BIND_STORAGE variable=M_inv type=RAM_T2P impl=URAM
// #pragma HLS ARRAY_RESHAPE variable=M_inv type=cyclic factor=RESHAPE_FACTOR dim=1
// Note: rho is length num_rows (constraints).


// Scalar variables for PCG
float alpha;
float beta;

// Warm-started PCG:
// - Treat incoming x as an initial guess (ADMM keeps x_tilde across iterations).
// - Compute initial residual r = b - K*x, then proceed with standard PCG.
// scratch1 is used for intermediate SpMVs; scratch2 temporarily holds K*x and then z=M^{-1}r.

// scratch1[0..num_rows): A*x
spmv_csc(num_rows, num_cols, A_nnz, A_row_idx, A_col_ptr, A_values, x, scratch1);

// scratch1 = rho .* (A*x)
for (int i = 0; i < num_rows; i += RESHAPE_FACTOR)
{
#pragma HLS PIPELINE II = 1
    for (int j = 0; j < RESHAPE_FACTOR; ++j)
    {
#pragma HLS UNROLL
        const int idx = i + j;
        if (idx < num_rows)
        {
            scratch1[idx] = rho[idx] * scratch1[idx];
        }
    }
}

// scratch2[0..num_cols): A^T * (rho .* (A*x))
spmv_csc(num_cols, num_rows, A_nnz, AT_row_idx, AT_col_ptr, AT_values, scratch1, scratch2);

// scratch1[0..num_cols): P*x
spmv_csc(num_cols, num_cols, P_nnz, P_row_idx, P_col_ptr, P_values, x, scratch1);

// scratch2[0..num_cols): K*x = P*x + sigma*x + A^T*(rho*(A*x))
for (int i = 0; i < num_cols; i += RESHAPE_FACTOR)
{
#pragma HLS PIPELINE II = 1
    for (int j = 0; j < RESHAPE_FACTOR; ++j)
    {
#pragma HLS UNROLL
        const int idx = i + j;
        if (idx < num_cols)
        {
            scratch2[idx] = scratch2[idx] + sigma * x[idx] + scratch1[idx];
        }
    }
}

// init r=b-Kx, z=M_inv*r, p=z
for (int i = 0; i < num_cols; ++i)
{
#pragma HLS PIPELINE II = 1
    const float r0 = b[i] - scratch2[i];
    r[i] = r0;
    const float z0 = M_inv[i] * r0;
    scratch2[i] = z0; // z
    p[i] = z0;
}



float rT_y = dot_prod(r, scratch2, num_cols); // r^T y
float rT_r = dot_prod(r, r, num_cols);        // ||r||_2^2

// Relative residual stop: ||r||^2 <= eps^2 * ||b||^2
const float norm_b_sq = dot_prod(b, b, num_cols);
const float threshold = epsilon_sq * norm_b_sq;

#define K_p b // Reuse b's memory to store K*p result since b is not needed after initialization
// float *K_p = b; // Reuse b's memory to store K*p result since b is not needed after initialization

int iter_count = 0;

for (int k = 0; k < pcg_max_iterations && rT_r > threshold; ++k)
{
    // //#pragma HLS DATAFLOW ?
    // float A_p[MAX_SIZE] = spmv_csc(A, p);
    // float rho_A_p[MAX_SIZE] = rho * A_p; // Element-wise vector product of rho matrix (diagonal) with A_p
    // float AT_rho_A_p[MAX_SIZE] = spmv_csc(AT, rho_A_p);


    // float P_p[MAX_SIZE] = spmv_csc(P, p);
    // float sigma_p = sigma * p; // Dot product of sigma scalar with p

    // K_p = P_p + sigma_p + AT_rho_A_p; // Vector addition


    // scratch1[0..num_rows): A*p
    spmv_csc(num_rows, num_cols, A_nnz, A_row_idx, A_col_ptr, A_values, p, scratch1);

    // scratch1 = rho .* (A*p)
    for (int i = 0; i < num_rows; i += RESHAPE_FACTOR)
    {
#pragma HLS PIPELINE II = 1
        for (int j = 0; j < RESHAPE_FACTOR; ++j)
        {
#pragma HLS UNROLL
            const int idx = i + j;
            if (idx < num_rows)
            {
                scratch1[idx] = rho[idx] * scratch1[idx];
            }
        }
    }

    // K_p = A^T * (rho .* (A*p))
    spmv_csc(num_cols, num_rows, A_nnz, AT_row_idx, AT_col_ptr, AT_values, scratch1, K_p);

    // scratch1[0..num_cols): P*p
    spmv_csc(num_cols, num_cols, P_nnz, P_row_idx, P_col_ptr, P_values, p, scratch1);

    // K_p = P*p + sigma*p + A^T*(rho*(A*p))
    for (int i = 0; i < num_cols; i += RESHAPE_FACTOR)
    {
#pragma HLS PIPELINE II = 1
        for (int j = 0; j < RESHAPE_FACTOR; ++j)
        {
#pragma HLS UNROLL
            const int idx = i + j;
            if (idx < num_cols)
            {
                K_p[idx] = K_p[idx] + sigma * p[idx] + scratch1[idx];
            }
        }
    }

    float pT_K_p = dot_prod(p, K_p, num_cols); // Dot product of p and K_p, INSERT INTO PREVIOUS LOOP?

    alpha = rT_y / pT_K_p; // Scalar division

    for (int i = 0; i < num_cols; i += RESHAPE_FACTOR)
    {
#pragma HLS PIPELINE II = 1
        for (int j = 0; j < RESHAPE_FACTOR; ++j)
        {
#pragma HLS UNROLL
            const int idx = i + j;
            if (idx < num_cols)
            {
                const float p_val = p[idx];
                const float K_p_val = K_p[idx];
                const float x_old = x[idx];
                const float r_old = r[idx];

                const float r_new = r_old - alpha * K_p_val; // r_new = r_old - alpha * K_p

                x[idx] = x_old + alpha * p_val;
                r[idx] = r_new;
                scratch2[idx] = M_inv[idx] * r_new; // y = M_inv * r_new
            }
        }
    }

    float rT_y_next = dot_prod(r, scratch2, num_cols); // Dot product of r and y // INSERT INTO PREVIOUS LOOP, CANNOT CALL DOT PROD FUNCTION

    rT_r = dot_prod(r, r, num_cols); // Dot product of r with itself

    beta = rT_y_next / rT_y; // Scalar division

    for (int i = 0; i < num_cols; i += RESHAPE_FACTOR)
    {
#pragma HLS PIPELINE II = 1
        for (int j = 0; j < RESHAPE_FACTOR; ++j)
        {
#pragma HLS UNROLL
            const int idx = i + j;
            if (idx < num_cols)
            {
                p[idx] = scratch2[idx] + beta * p[idx]; // p = y + beta * p
            }
        }
    }

    rT_y = rT_y_next;
    iter_count++;
}

    *pcg_num_iterations = iter_count;
}