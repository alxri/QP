#include "pcg.h"

#define RESHAPE_FACTOR 8

// How many dot product engines?? Need to limit?
static float dot_prod(const float *x, const float *y, int size)
{
    // 4 accumulators to hide the final FP addition latency
    float acc0 = 0.0f;
    float acc1 = 0.0f;
    float acc2 = 0.0f;
    float acc3 = 0.0f;

    for (int i = 0; i < size; i += 4) {
        #pragma HLS PIPELINE II = 1
        // unroll 4 iterations of the loop
        float p0 = x[i]   * y[i];
        float p1 = x[i+1] * y[i+1];
        float p2 = x[i+2] * y[i+2];
        float p3 = x[i+3] * y[i+3];

        // Add into the oldest partial sum, then rotate.
        float sum_ab = p0 + p1;
        float sum_cd = p2 + p3;
        float sum_all = sum_ab + sum_cd;

        float updated = acc0 + sum_all;
        acc0 = acc1;
        acc1 = acc2;
        acc2 = acc3;
        acc3 = updated;
    }
    // Final reduction
    return (acc0 + acc1) + (acc2 + acc3);
}
// make struct for CSC data to reduce number of arguments and simplify function calls
void pcg(int num_rows,
         int num_cols,
         const int16 *A_row_idx,
         const int *A_col_ptr,
         const float16 *A_values,
         int A_nnz, // needed?
         const int16 *AT_row_idx,
         const int *AT_col_ptr,
         const float16 *AT_values,
         const int16 *P_row_idx,
         const int *P_col_ptr,
         const float16 *P_values,
         int P_nnz, // needed?
         const float *M_inv_in,
         const float *b_in,
         const float *rho_in,
         const float sigma,
         const float epsilon_sq,
         float *x) // ?
{

/* From ADMM receive
*   - Pointers of Matrix P in CSC format (P_col_ptr, P_row_idx, P_values) - read from DDR
*   - Pointers of Matrix A in CSC format (A_col_ptr, A_row_idx, A_values) - read from DDR
*   - Pointers of Transpose of A in CSC format (A_col_ptr_T, A_row_idx_T, A_values_T) - read from DDR
*
*   - Diagonal preconditioner M_inv (as a vector) - read from DDR / keep in URAM/BRAM?
*
*   - Vector b, computed in ADMM
*   - Diagonal matrix rho (as a vector of its diagonal entries)
*   - Scalar sigma
*   - Scalar epsilon_sq (epsilon squared from CPU)
*/

#pragma HLS INTERFACE m_axi port = A_row_idx offset = slave bundle = gmem0 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = A_col_ptr offset = slave bundle = gmem1 depth = MAX_COL_PTR
#pragma HLS INTERFACE m_axi port = A_values offset = slave bundle = gmem2 depth = MAX_NNZ_WORDS

#pragma HLS INTERFACE m_axi port = AT_row_idx offset = slave bundle = gmem0 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = AT_col_ptr offset = slave bundle = gmem1 depth = MAX_COL_PTR
#pragma HLS INTERFACE m_axi port = AT_values offset = slave bundle = gmem2 depth = MAX_NNZ_WORDS

#pragma HLS INTERFACE m_axi port = P_row_idx offset = slave bundle = gmem0 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = P_col_ptr offset = slave bundle = gmem1 depth = MAX_COL_PTR
#pragma HLS INTERFACE m_axi port = P_values offset = slave bundle = gmem2 depth = MAX_NNZ_WORDS

#pragma HLS INTERFACE m_axi port = b_in offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = rho_in offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = M_inv_in offset = slave bundle = gmem3 depth = MAX_COLS

#pragma HLS INTERFACE s_axilite port = num_rows bundle = control
#pragma HLS INTERFACE s_axilite port = num_cols bundle = control
#pragma HLS INTERFACE s_axilite port = A_nnz bundle = control
#pragma HLS INTERFACE s_axilite port = P_nnz bundle = control
#pragma HLS INTERFACE s_axilite port = sigma bundle = control
#pragma HLS INTERFACE s_axilite port = epsilon_sq bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

// Only one SpMV engine
#pragma HLS ALLOCATION instances=spmv_csc limit=1 function

// Local vector buffers for computation (Cannot be shared)
float x_local[MAX_SIZE];
float r[MAX_SIZE];
float p[MAX_SIZE];
float K_p[MAX_SIZE];
float M_inv[MAX_SIZE];
float rho[MAX_SIZE];

// Reusable scratchpads
float scratch1[MAX_SIZE]; // b and tmp0 can share the same buffer as they are used at different times in the algorithm
float scratch2[MAX_SIZE]; // y can also be used to store intermediate results like A*p and AT*(rho*(A*p)) to save memory, as they are used at different times in the algorithm

#pragma HLS BIND_STORAGE variable=x_local type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=x_local type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=scratch1 type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=scratch1 type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=scratch2 type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=scratch2 type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=r type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=r type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=p type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=p type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=K_p type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=K_p type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=M_inv type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=M_inv type=cyclic factor=RESHAPE_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=rho type=RAM_T2P impl=URAM
#pragma HLS ARRAY_RESHAPE variable=rho type=cyclic factor=RESHAPE_FACTOR dim=1


// Scalar variables for PCG
float alpha;
float beta;


for (int i = 0; i < num_cols; ++i)
{
#pragma HLS PIPELINE II = 1
    scratch1[i] = b_in[i]; // not necessary in final implementation but needed now
    M_inv[i] = M_inv_in[i];
    rho[i] = rho_in[i];
    x_local[i] = 0.0f;
    r[i] = scratch1[i];
    scratch2[i] = M_inv[i] * r[i];
    p[i] = scratch2[i];
}

float rT_y = dot_prod(r, scratch2, num_cols); // Dot product of r and y

// scratch1=b
float norm_b_sq = dot_prod(scratch1, scratch1, num_cols); // Dot product of b with itself


float threshold = epsilon_sq * norm_b_sq;


float rT_r = dot_prod(r, r, num_cols); // Dot product of r with itself

// EDIT SPMV FUNCTION TO NOT WRITE IN DDR. WRITE DIRECTLY IN OUTPUT BUFFER

const int max_iters = MAX_SIZE;
for (int k = 0; k < max_iters && rT_r > threshold; ++k)
{
    // //#pragma HLS DATAFLOW ?
    // float A_p[MAX_SIZE] = spmv_csc(A, p);
    // float rho_A_p[MAX_SIZE] = rho * A_p; // Element-wise vector product of rho matrix (diagonal) with A_p
    // float AT_rho_A_p[MAX_SIZE] = spmv_csc(AT, rho_A_p);


    // float P_p[MAX_SIZE] = spmv_csc(P, p);
    // float sigma_p = sigma * p; // Dot product of sigma scalar with p

    // K_p = P_p + sigma_p + AT_rho_A_p; // Vector addition


    spmv_csc(num_rows, num_cols, A_nnz, A_row_idx, A_col_ptr, A_values, p, scratch1); // A*p 

    for (int i = 0; i < num_cols; i += RESHAPE_FACTOR)
    {
#pragma HLS PIPELINE II = 1
        for (int j = 0; j < RESHAPE_FACTOR; ++j)
        {
#pragma HLS UNROLL
            const int idx = i + j;
            if (idx < num_cols)
            {
                scratch1[idx] = rho[idx] * scratch1[idx]; // rho*(A*p)
            }
        }
    }

    spmv_csc(num_rows, num_cols, A_nnz, AT_row_idx, AT_col_ptr, AT_values, scratch1, K_p); // K_p = AT*(rho*(A*p))

    spmv_csc(num_rows, num_cols, P_nnz, P_row_idx, P_col_ptr, P_values, p, scratch1); // P*p, can reuse scratch1 to save memory

    for (int i = 0; i < num_cols; i += RESHAPE_FACTOR)
    {
#pragma HLS PIPELINE II = 1
        for (int j = 0; j < RESHAPE_FACTOR; ++j)
        {
#pragma HLS UNROLL
            const int idx = i + j;
            if (idx < num_cols)
            {
                K_p[idx] = K_p[idx] + sigma * p[idx] + scratch1[idx]; // K_p = P*p + sigma*p + AT*(rho*(A*p))
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
                const float x_old = x_local[idx];
                const float r_old = r[idx];

                const float r_new = r_old - alpha * K_p_val; // r_new = r_old - alpha * K_p

                x_local[idx] = x_old + alpha * p_val;
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
}

    // Write result back to DDR
    for (int i = 0; i < num_cols; i++) {
        #pragma HLS PIPELINE II=1
        x[i] = x_local[i];
    }
}