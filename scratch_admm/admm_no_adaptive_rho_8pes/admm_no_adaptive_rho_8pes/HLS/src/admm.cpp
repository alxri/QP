#include "admm.h"

#define PCG_TOL_MIN_SQ 1E-14
#define PCG_TOLERANCE_FRACTION 0.15f
#define NUM_ITERATIONS_CHECK_TERMINATION 10
#define DEFAULT_EPS_ABS 1E-3f
#define DEFAULT_EPS_REL 1E-3f

#define UNROLL_FACTOR 8


inline float clamp(float val, float lower, float upper)
{
    return (val < lower) ? lower : (val > upper) ? upper : val;
}

// HLS Pseudo-code for the Preconditioner Update Module
// TODO: CREATE A SEPARATE STREAM DATAFLOW FOR THIS TO READ A VALUES AND COMPUTE M_inv (read 16 elements from A)
void update_preconditioner(
    const float *P_diag, const float16 *A_values, const int16 *A_row_idx, const int *A_col_ptr, 
    float *rho, float sigma, float *M_inv, int num_cols) 
{
    // Local caches for the 512-bit wide AXI words
    float16 current_A_vals;
    int16 current_A_rows;
    int current_word_idx = -1; // Tracks which 16-element chunk is currently loaded

    for (int i = 0; i < num_cols; i++) {
        float A_col_sum = 0.0f;
        
        int start = A_col_ptr[i];
        int end = A_col_ptr[i+1];
        
        for (int p = start; p < end; p++) {
// Tell HLS to pipeline this, and ignore false floating-point accumulation dependencies
#pragma HLS PIPELINE II=1
#pragma HLS DEPENDENCE variable=A_col_sum type=inter direction=RAW false

            // Fast bitwise math: / 16 is >> 4, % 16 is & 15
            int word_idx = p >> 4;  
            int lane_idx = p & 15;  

            // Only trigger a memory read when we cross a 16-element boundary
            if (word_idx != current_word_idx) {
                current_A_vals = A_values[word_idx]; // AXI Burst inferred automatically!
                current_A_rows = A_row_idx[word_idx];
                current_word_idx = word_idx;
            }
            
            // Extract from the local cache, NOT directly from the AXI pointer
            int row_j = current_A_rows[lane_idx];
            float val = current_A_vals[lane_idx];
            
            // Multiply and accumulate
            A_col_sum += rho[row_j] * (val * val); 
        }
        
        // P_diag is read from DDR sequentially here, which is highly efficient
        M_inv[i] = 1.0f / (P_diag[i] + sigma + A_col_sum);
    }
}

void update_eps_sq(float b_norm,
                   float r_prim,
                   float r_dual,
                   float &eps_sq,
                   float &eps_sq_old,
                   int num_iterations,
                   int num_pcg_iterations,
                   int pcg_max_iterations)
{
    // eps_sq is a *relative* tolerance squared used by PCG's stop test:
    //   ||r||_2^2 <= eps_sq * ||b||_2^2
    // Start loose, then tighten as ADMM residuals decrease.

    eps_sq_old = eps_sq;

    float frac = PCG_TOLERANCE_FRACTION;
    if (num_iterations > 0 && num_pcg_iterations >= pcg_max_iterations)
    {
        // If PCG hit the iteration cap previously, tighten the target residual.
        frac *= 0.5f;
    }

    float new_eps_sq;
    if (num_iterations == 0)
    {
        new_eps_sq = frac * frac;
    }
    else
    {
        // Normalize the geometric-mean residual against the magnitude of b to get a dimensionless ratio.
        const float denom = (b_norm > 0.0f) ? (b_norm * b_norm) : 1.0f;
        new_eps_sq = (frac * frac) * (r_prim * r_dual) / denom;
    }

    if (new_eps_sq < PCG_TOL_MIN_SQ)
    {
        new_eps_sq = PCG_TOL_MIN_SQ;
    }
    if (num_iterations > 0 && new_eps_sq > eps_sq_old)
    {
        // Prevent eps_sq from increasing after the first iteration.
        new_eps_sq = eps_sq_old;
    }

    eps_sq = new_eps_sq;
}

void update_b(int num_rows, int num_cols, float sigma, float *x, float *q, const float16 *AT_values, const int16 *AT_row_idx, const int *AT_col_ptr, int A_nnz, float *rho, float *y, float *z, float *b, float *scratch_in, float *scratch_out, float *b_norm)
{
#pragma HLS INLINE
    *b_norm = 0.0f;

    for (int i = 0; i < num_rows; i++) {
#pragma HLS PIPELINE II=1
        scratch_in[i] = rho[i] * z[i] - y[i]; // AT * (rho * z - y)
    }

    spmv_csc(num_cols, num_rows, A_nnz, AT_row_idx, AT_col_ptr, AT_values, scratch_in, scratch_out); // scratch_out = AT * (rho * z - y)

    for (int i = 0; i < num_cols; i++) {
#pragma HLS PIPELINE II=1
        b[i] = sigma * x[i] - q[i] + scratch_out[i]; // b = sigma*x - q + AT*(rho*z - y)

        float abs_b = hls::fabs(b[i]);
        if (abs_b > *b_norm) {
            *b_norm = abs_b; // Also calculate norm of b for eps_sq calculation
        }
    }
}

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
          float *x_out,
          float *y_out,
          int *admm_num_iterations_out,
          int *pcg_num_iterations_out,
          float *r_prim_out,
          float *r_dual_out,
          int *status_out)
{
/* From CPU (sw) receive
*   - Pointers of Matrix P in CSC format (P_col_ptr, P_row_idx, P_values) + nnz - read from DDR 
*   - Diagonal of Matrix P (P_diag) - read from DDR
*   - Pointers of Matrix A in CSC format (A_col_ptr, A_row_idx, A_values) + nnz - read from DDR
*   - Pointers of Transpose of A in CSC format (A_col_ptr_T, A_row_idx_T, A_values_T) - read from DDR
*
*   - Vector l - copy to BRAM ?
*   - Vector u - copy to BRAM ?
*
*   - Vector q - copy to BRAM
*   - Vector rho, initialization in CPU - copy to BRAM
*   - Scalar sigma - copy to register
*   - Scalar alpha - copy to register
*
*   - num_rows, num_cols, P_nnz, A_nnz
*
*   - pcg_max_iterations, admm_max_iterations
*
* Computed in ADMM to feed into PCG:
*   - Diagonal preconditioner M_inv (as a vector)
*   - Vector b, computed in ADMM
*   - Vector rho updates every UPDATE_RHO iterations
*   - Scalar epsilon_sq
*
*
* Write result back to DDR:
*   - Vector x (primal solution to the QP)
*   - Vector y (dual solution to the QP)
*   - admm_num_iterations_out: number of ADMM iterations
*   - pcg_num_iterations_out: accumulated number of PCG iterations over all ADMM iterations
*   - Status flag: how solver terminated (converged, max iterations reached)
*   - Final residuals: primal and dual residual norms to verify quality of solution
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
#pragma HLS INTERFACE m_axi port = P_diag offset = slave bundle = gmem2 depth = MAX_COLS

#pragma HLS INTERFACE m_axi port = q_in offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = l_in offset = slave bundle = gmem3 depth = MAX_ROWS
#pragma HLS INTERFACE m_axi port = u_in offset = slave bundle = gmem3 depth = MAX_ROWS

#pragma HLS INTERFACE m_axi port = rho_in offset = slave bundle = gmem3 depth = MAX_ROWS

#pragma HLS INTERFACE m_axi port = x_out offset = slave bundle = gmem3 depth = MAX_COLS
#pragma HLS INTERFACE m_axi port = y_out offset = slave bundle = gmem3 depth = MAX_ROWS

// #pragma HLS INTERFACE m_axi port = admm_num_iterations_out offset = slave bundle = gmem3 depth = 1
// #pragma HLS INTERFACE m_axi port = pcg_num_iterations_out offset = slave bundle = gmem3 depth = 1
// #pragma HLS INTERFACE m_axi port = status_out offset = slave bundle = gmem3 depth = 1
// #pragma HLS INTERFACE m_axi port = r_prim_out offset = slave bundle = gmem3 depth = 1
// #pragma HLS INTERFACE m_axi port = r_dual_out offset = slave bundle = gmem3 depth = 1

#pragma HLS INTERFACE s_axilite port = admm_num_iterations_out bundle = control
#pragma HLS INTERFACE s_axilite port = pcg_num_iterations_out bundle = control
#pragma HLS INTERFACE s_axilite port = status_out bundle = control
#pragma HLS INTERFACE s_axilite port = r_prim_out bundle = control
#pragma HLS INTERFACE s_axilite port = r_dual_out bundle = control

#pragma HLS INTERFACE s_axilite port = num_rows bundle = control
#pragma HLS INTERFACE s_axilite port = num_cols bundle = control
#pragma HLS INTERFACE s_axilite port = A_nnz bundle = control
#pragma HLS INTERFACE s_axilite port = P_nnz bundle = control
#pragma HLS INTERFACE s_axilite port = sigma bundle = control
#pragma HLS INTERFACE s_axilite port = alpha bundle = control
#pragma HLS INTERFACE s_axilite port = pcg_max_iterations bundle = control
#pragma HLS INTERFACE s_axilite port = admm_max_iterations bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

// // Only one SpMV engine
#pragma HLS ALLOCATION function instances=spmv_csc limit=1

// Which arrays live in ADMM vs in PCG??

// Array reshape ?

// DATAFLOW??

    float M_inv[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=M_inv type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=M_inv type=RAM_T2P impl=URAM

    float b[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=b type=cyclic factor=UNROLL_FACTOR dim=1 //Necessary for K_p in PCG
#pragma HLS BIND_STORAGE variable=b type=RAM_T2P impl=URAM

    float x[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=x type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=x type=RAM_T2P impl=URAM

    float x_tilde[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=x_tilde type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=x_tilde type=RAM_T2P impl=URAM

    float y[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=y type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=y type=RAM_T2P impl=URAM

    float z[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=z type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=z type=RAM_T2P impl=URAM

    float z_tilde[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=z_tilde type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=z_tilde type=RAM_T2P impl=URAM

    float rho[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=rho type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=rho type=RAM_T2P impl=URAM

    float tmp1[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=tmp1 type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=tmp1 type=RAM_T2P impl=URAM

    float tmp2[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=tmp2 type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=tmp2 type=RAM_T2P impl=URAM

    float rho_inv[MAX_SIZE];
#pragma HLS ARRAY_RESHAPE variable=rho_inv type=cyclic factor=UNROLL_FACTOR dim=1
#pragma HLS BIND_STORAGE variable=rho_inv type=RAM_T2P impl=URAM


    float l[MAX_SIZE];
    float u[MAX_SIZE];
    float q[MAX_SIZE];




// #pragma HLS BIND_STORAGE variable=x_tilde type=RAM_T2P impl=URAM
// #pragma HLS BIND_STORAGE variable=x type=RAM_T2P impl=URAM
// #pragma HLS BIND_STORAGE variable=y type=RAM_T2P impl=URAM




    float b_norm = 0.0f;

    float eps_sq = 0.0f;
    float eps_sq_old = 0.0f;

    float r_prim = 0.0f;
    float r_dual = 0.0f;

    float eps_prim = 0.0f;
    float eps_dual = 0.0f;

    float eps_abs = DEFAULT_EPS_ABS;
    float eps_rel = DEFAULT_EPS_REL;

    // float alpha;
    // float sigma;

    int num_iterations = 0;
    int num_pcg_iterations = 0;
    int total_pcg_iterations = 0;

    float norm_q = 0.0f;

    for (int i = 0; i < num_cols; i++)
    {
#pragma HLS PIPELINE II = 1
        x[i] = 0.0f; // initial x

        float q_val = q_in[i];
        q[i] = q_val; // copy q from DDR to BRAM

        float abs_q = hls::fabs(q_val); // inf_norm of q
        norm_q = hls::fmax(norm_q, abs_q);
    }

    for (int i = 0; i < num_rows; i++)
    {
#pragma HLS PIPELINE II = 1
        y[i] = 0.0f;
        z[i] = 0.0f;
        rho[i] = rho_in[i];
        rho_inv[i] = 1.0f / rho[i];
        l[i] = l_in[i];
        u[i] = u_in[i];

    }

    update_preconditioner(P_diag, A_values, A_row_idx, A_col_ptr, rho, sigma, M_inv, num_cols); // Compute diagonal preconditioner M_inv

    float one_minus_alpha = 1.0f - alpha;


        // Scratch arrays
        // x_tilde and z can share memory since they are not used at the same time

    do
    {
        update_b(num_rows, num_cols, sigma, x, q, AT_values, AT_row_idx, AT_col_ptr, A_nnz, rho, y, z, b, tmp1, tmp2, &b_norm); // Compute vector b for PCG and its norm for eps_sq calculation
        
        update_eps_sq(b_norm, r_prim, r_dual, eps_sq, eps_sq_old, num_iterations, num_pcg_iterations, pcg_max_iterations);

        pcg(num_rows, num_cols, A_row_idx, A_col_ptr, A_values, A_nnz, AT_row_idx, AT_col_ptr, AT_values, P_row_idx, P_col_ptr, P_values, P_nnz, M_inv, rho, sigma, eps_sq, x_tilde, b, tmp1, tmp2, &num_pcg_iterations, pcg_max_iterations);

        total_pcg_iterations += num_pcg_iterations;

        spmv_csc(num_rows, num_cols, A_nnz, A_row_idx, A_col_ptr, A_values, x_tilde, tmp1); // z_tilde = A*x_tilde
        
        
        for (int i = 0; i < num_cols; i++)
        {
#pragma HLS PIPELINE II = 1
            x[i] = alpha * x_tilde[i] + one_minus_alpha * x[i]; // x = alpha * x_tilde + (1 - alpha) * x 
        }

        float norm_z = 0.0f;
        for (int i = 0; i < num_rows; i++)
        {
#pragma HLS PIPELINE II = 1
            float z_prev = z[i];
            float v = alpha * tmp1[i] + one_minus_alpha * z_prev; // v = alpha * z_tilde + (1 - alpha) * z_prev

            float new_z = clamp(v + y[i] * rho_inv[i], l[i], u[i]);
            z[i] = new_z; // z = clamp(v, l, u)
            y[i] = y[i] + rho[i] * (v - new_z); // y = y + rho*(v - z)

            float z_abs = hls::fabs(new_z);
            norm_z = hls::fmax(norm_z, z_abs);
        }


        // r_prim, note: inf_norm replaced inside loop to reduce an extra loop
        spmv_csc(num_rows, num_cols, A_nnz, A_row_idx, A_col_ptr, A_values, x, tmp1); // tmp1 = A*x
        float Ax_norm = 0.0f; 
        float r_prim_calc = 0.0f; 

        for (int i = 0; i < num_rows; i++)
        {
#pragma HLS PIPELINE II = 1
            
            float ax_val = tmp1[i];
            
            float ax_abs = hls::fabs(ax_val);
            Ax_norm = hls::fmax(Ax_norm, ax_abs);

            float r_abs = hls::fabs(ax_val - z[i]);
            r_prim_calc = hls::fmax(r_prim_calc, r_abs);
        }
        r_prim = r_prim_calc;

        // r_dual
        spmv_csc(num_cols, num_rows, A_nnz, AT_row_idx, AT_col_ptr, AT_values, y, tmp1); // tmp1 = AT*y
        spmv_csc(num_cols, num_cols, P_nnz, P_row_idx, P_col_ptr, P_values, x, tmp2); // tmp2 = P*x
        float ATy_norm_calc = 0.0f;
        float Px_norm_calc = 0.0f;
        float r_dual_calc = 0.0f;
        for (int i = 0; i < num_cols; i++)
        {
#pragma HLS PIPELINE II = 1
            float aty_val = tmp1[i];
            float px_val = tmp2[i];

            float aty_abs = hls::fabs(aty_val);
            ATy_norm_calc = hls::fmax(ATy_norm_calc, aty_abs);
            
            float px_abs = hls::fabs(px_val);
            Px_norm_calc = hls::fmax(Px_norm_calc, px_abs);

            // Inline r_dual calculation (P*x + q + AT*y)
            float rd_val = px_val + q[i] + aty_val;
            float rd_abs = hls::fabs(rd_val);
            r_dual_calc = hls::fmax(r_dual_calc, rd_abs);
        }
        r_dual = r_dual_calc;
        float ATy_norm = ATy_norm_calc;
        float Px_norm = Px_norm_calc;


        // Check for convergence every NUM_ITERATIONS_CHECK_TERMINATION iterations
        if (num_iterations > 0 && num_iterations % NUM_ITERATIONS_CHECK_TERMINATION == 0) {
            float max_prim = hls::fmax(Ax_norm, norm_z);
            float max_dual = hls::fmax(Px_norm, hls::fmax(norm_q, ATy_norm));

            eps_prim = eps_abs + eps_rel*max_prim;
            eps_dual = eps_abs + eps_rel*max_dual;

            if (r_prim <= eps_prim && r_dual <= eps_dual) {
                break; // Converged
            }
        }

        num_iterations++;

    } while (num_iterations < admm_max_iterations);

    *admm_num_iterations_out = num_iterations;
    *pcg_num_iterations_out = total_pcg_iterations;
    *r_prim_out = r_prim;
    *r_dual_out = r_dual;
    *status_out = (num_iterations == admm_max_iterations) ? 0 : 1; // 0 if max iterations reached, 1 if converged

    // Write final solution back to DDR
    for (int i = 0; i < num_cols; i++)
    {
#pragma HLS PIPELINE II = 1
        x_out[i] = x[i];
    }

    for (int i = 0; i < num_rows; i++)
    {
#pragma HLS PIPELINE II = 1
        y_out[i] = y[i];
    }
}