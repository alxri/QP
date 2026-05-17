#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <random>
#include <iomanip>

// Include your HLS design header
#include "admm.h"

// OSQP Constants
#define OSQP_RHO 0.1f
#define OSQP_RHO_EQ_OVER_RHO_INEQ 1000.0f
#define OSQP_RHO_TOL 1e-4f
#define OSQP_INFTY 1e20f
#define OSQP_MIN_SCALING 1e-4f
#define OSQP_RHO_MAX 1e6f
#define OSQP_RHO_MIN 1e-6f

// Helper to transpose A into A^T in CSC format
static void transpose_csc(int num_rows, int num_cols,
                          const std::vector<int> &col_ptr, const std::vector<int> &row_idx, const std::vector<float> &values,
                          std::vector<int> &col_ptr_t, std::vector<int> &row_idx_t, std::vector<float> &values_t)
{
    col_ptr_t.assign(num_rows + 1, 0);
    std::vector<int> nnz_per_at_col(num_rows, 0);
    for (int idx = 0; idx < (int)row_idx.size(); ++idx) nnz_per_at_col[row_idx[idx]]++;
    for (int c = 0; c < num_rows; ++c) col_ptr_t[c + 1] = col_ptr_t[c] + nnz_per_at_col[c];
    
    const int nnz = (int)row_idx.size();
    row_idx_t.assign(nnz, 0);
    values_t.assign(nnz, 0.0f);
    std::vector<int> next(col_ptr_t.begin(), col_ptr_t.begin() + num_rows);

    for (int c = 0; c < num_cols; ++c) {
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx) {
            const int r = row_idx[idx];
            const int dst = next[r]++;
            row_idx_t[dst] = c;
            values_t[dst] = values[idx];
        }
    }
}

// Helper to safely pack flat CSC data into hls::vector
static bool pack_csc_nnz_to_words(const std::vector<int> &row_idx, const std::vector<float> &values,
                                  std::vector<int16> &row_words, std::vector<float16> &val_words)
{
    if (row_idx.size() != values.size()) return false;
    const int nnz = (int)row_idx.size();

    for (int w = 0; w < MAX_NNZ_WORDS; ++w) {
        for (int lane = 0; lane < PACK_SIZE; ++lane) {
            row_words[w][lane] = 0;
            val_words[w][lane] = 0.0f;
        }
    }
    for (int idx = 0; idx < nnz; ++idx) {
        const int w = idx / PACK_SIZE;
        const int lane = idx % PACK_SIZE;
        row_words[w][lane] = row_idx[idx];
        val_words[w][lane] = values[idx];
    }
    return true;
}

int main() {
    // 15x15 PROBLEM FOR LIGHTNING FAST CO-SIMULATION
    const int num_rows = 15;
    const int num_cols = 15;

    std::cout << "--- Starting ADMM Vitis HLS Testbench (" << num_rows << "x" << num_cols << " Reverse-Engineered) ---" << std::endl;

    std::mt19937 rng(123);
    std::uniform_real_distribution<float> x_dist(-2.0f, 2.0f);
    std::uniform_real_distribution<float> p_dist(1.0f, 3.0f);
    std::uniform_real_distribution<float> a_dist(-1.0f, 1.0f);
    std::uniform_int_distribution<int> row_dist(0, num_rows - 1);
    std::uniform_int_distribution<int> constraint_type_dist(0, 2);
    std::uniform_real_distribution<float> slack_dist(0.5f, 5.0f);

    // -------------------------------------------------------------------------
    // 1. Generate Ground Truth x* and Matrix P
    // -------------------------------------------------------------------------
    std::vector<float> x_true(num_cols, 0.0f);
    std::vector<float> q(std::max(num_cols, (int)MAX_COLS), 0.0f);
    
    int P_nnz = num_cols;
    std::vector<float> P_values(P_nnz, 0.0f); 
    std::vector<int> P_row_idx(P_nnz, 0);
    std::vector<int> P_col_ptr(num_cols + 1, 0);
    std::vector<float> P_diag(std::max(num_cols, (int)MAX_COLS), 0.0f); 

    for (int c = 0; c < num_cols; ++c) {
        x_true[c] = x_dist(rng); 
        
        P_col_ptr[c] = c;
        P_row_idx[c] = c;
        float d = p_dist(rng);
        P_values[c] = d;
        P_diag[c] = d;

        q[c] = -d * x_true[c]; 
    }
    P_col_ptr[num_cols] = P_nnz;
    P_col_ptr.resize(MAX_COL_PTR, 0); 

    // -------------------------------------------------------------------------
    // 2. Generate Random Matrix A (~1 nnz/col) and compute z* = A * x*
    // -------------------------------------------------------------------------
    int A_nnz = num_cols;
    std::vector<float> A_values(A_nnz, 0.0f);
    std::vector<int> A_row_idx(A_nnz, 0);
    std::vector<int> A_col_ptr(num_cols + 1, 0);
    std::vector<float> z_true(num_rows, 0.0f);
    
    for (int c = 0; c < num_cols; ++c) {
        A_col_ptr[c] = c;
        A_row_idx[c] = row_dist(rng);
        float v = a_dist(rng);
        if (std::fabs(v) < 1e-3f) v = 1e-3f;
        A_values[c] = v;

        z_true[A_row_idx[c]] += v * x_true[c];
    }
    A_col_ptr[num_cols] = A_nnz;
    A_col_ptr.resize(MAX_COL_PTR, 0); 

    std::vector<float> AT_values;
    std::vector<int> AT_row_idx;
    std::vector<int> AT_col_ptr;
    transpose_csc(num_rows, num_cols, A_col_ptr, A_row_idx, A_values, AT_col_ptr, AT_row_idx, AT_values);
    AT_col_ptr.resize(MAX_COL_PTR, 0); 

    // Pack sparse arrays
    std::vector<int16> P_row_words(MAX_NNZ_WORDS);
    std::vector<float16> P_val_words(MAX_NNZ_WORDS);
    std::vector<int16> A_row_words(MAX_NNZ_WORDS);
    std::vector<float16> A_val_words(MAX_NNZ_WORDS);
    std::vector<int16> AT_row_words(MAX_NNZ_WORDS);
    std::vector<float16> AT_val_words(MAX_NNZ_WORDS);

    pack_csc_nnz_to_words(P_row_idx, P_values, P_row_words, P_val_words);
    pack_csc_nnz_to_words(A_row_idx, A_values, A_row_words, A_val_words);
    pack_csc_nnz_to_words(AT_row_idx, AT_values, AT_row_words, AT_val_words);

    // -------------------------------------------------------------------------
    // 3. Assign Bounds based on z*
    // -------------------------------------------------------------------------
    std::vector<float> l(std::max(num_rows, (int)MAX_ROWS), 0.0f);
    std::vector<float> u(std::max(num_rows, (int)MAX_ROWS), 0.0f);
    std::vector<float> rho(std::max(num_rows, (int)MAX_ROWS), 0.0f);

    for (int i = 0; i < num_rows; i++) {
        int type = constraint_type_dist(rng);
        float slack1 = slack_dist(rng);
        float slack2 = slack_dist(rng);

        if (type == 0) { 
            l[i] = z_true[i];
            u[i] = z_true[i];
            rho[i] = OSQP_RHO * OSQP_RHO_EQ_OVER_RHO_INEQ;
        } 
        else if (type == 1) { 
            l[i] = z_true[i] - slack1;
            u[i] = z_true[i] + slack2;
            rho[i] = OSQP_RHO;
        } 
        else { 
            l[i] = -OSQP_INFTY;
            u[i] = OSQP_INFTY;
            rho[i] = OSQP_RHO_MIN;
        }
        rho[i] = std::max(OSQP_RHO_MIN, std::min(OSQP_RHO_MAX, rho[i]));
    }

    // -------------------------------------------------------------------------
    // 4. Execution parameters
    // -------------------------------------------------------------------------
    float alpha = 1.6f;
    float sigma = 1e-6f;
    float eps_abs = 1e-4f;
    float eps_rel = 1e-4f;
    float pcg_tol_frac = 0.1f;
    int admm_max_iterations = 2000;
    int pcg_max_iterations = 500;
    bool adaptive_rho = false;

    std::vector<float> x_out(std::max(num_cols, (int)MAX_COLS), 0.0f);
    std::vector<float> y_out(std::max(num_rows, (int)MAX_ROWS), 0.0f);
    int admm_num_iterations_out = 0;
    int pcg_num_iterations_out = 0;
    float r_prim_out = 0.0f, r_dual_out = 0.0f;
    int status_out = 0;

    std::cout << "Running ADMM core..." << std::endl;
    
    admm(
        num_rows, num_cols,
        A_row_words.data(), A_col_ptr.data(), A_val_words.data(), A_nnz,
        AT_row_words.data(), AT_col_ptr.data(), AT_val_words.data(),
        P_row_words.data(), P_col_ptr.data(), P_val_words.data(), P_nnz, P_diag.data(),
        l.data(), u.data(), q.data(),
        sigma, alpha, rho.data(),
        admm_max_iterations, pcg_max_iterations, adaptive_rho,
        eps_abs, eps_rel, pcg_tol_frac,
        x_out.data(), y_out.data(),
        &admm_num_iterations_out, &pcg_num_iterations_out,
        &r_prim_out, &r_dual_out, &status_out
    );

    // -------------------------------------------------------------------------
    // 5. Verify Results against Ground Truth
    // -------------------------------------------------------------------------
    std::cout << "--- Simulation Results ---" << std::endl;
    std::cout << "Status: " << (status_out == 1 ? "Converged" : "Max Iterations Reached") << std::endl;
    std::cout << "ADMM Iterations: " << admm_num_iterations_out << std::endl;
    std::cout << "Total PCG Iterations: " << pcg_num_iterations_out << std::endl;

    std::cout << std::scientific << std::setprecision(5);
    std::cout << "Primal Residual: " << r_prim_out << std::endl;
    std::cout << "Dual Residual: " << r_dual_out << std::endl;
    
    float mae = 0.0f;
    for (int i = 0; i < num_cols; i++) {
        mae += std::fabs(x_out[i] - x_true[i]);
    }
    mae /= num_cols;
    
    std::cout << "\nMean Absolute Error from x_true: " << mae << std::endl;
    std::cout << "--- Full x_out vs Expected ---" << std::endl;
    for (int i = 0; i < num_cols; i++) {
        std::cout << "x[" << std::setw(2) << i << "]: " 
                  << std::setw(13) << x_out[i] 
                  << " | Expected: " << std::setw(13) << x_true[i] << std::endl;
    }

    if (status_out == 1 && mae < 1e-2f) {
        std::cout << "\n>>> SUCCESS: Problem converged perfectly to the ground truth! <<<" << std::endl;
        return 0; 
    } else {
        std::cout << "\n>>> FAILED: Did not converge to the expected target. <<<" << std::endl;
        return 1; 
    }
}