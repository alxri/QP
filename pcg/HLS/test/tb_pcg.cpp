#include <cmath>
#include <iomanip>
#include <iostream>
#include <random>
#include <vector>

#include "pcg.h"

static void spmv_sw_csc(int num_rows,
                        int num_cols,
                        const std::vector<int> &col_ptr,
                        const std::vector<int> &row_idx,
                        const std::vector<float> &values,
                        const std::vector<float> &x,
                        std::vector<float> &y)
{
    y.assign(num_rows, 0.0f);
    for (int c = 0; c < num_cols; ++c)
    {
        const float xc = x[c];
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx)
        {
            y[row_idx[idx]] += values[idx] * xc;
        }
    }
}

static void transpose_csc(int num_rows,
                          int num_cols,
                          const std::vector<int> &col_ptr,
                          const std::vector<int> &row_idx,
                          const std::vector<float> &values,
                          std::vector<int> &col_ptr_t,
                          std::vector<int> &row_idx_t,
                          std::vector<float> &values_t)
{
    // A is (num_rows x num_cols) in CSC; build AT = A^T which is (num_cols x num_rows) in CSC.
    // AT has (num_rows) columns.
    col_ptr_t.assign(num_rows + 1, 0);

    std::vector<int> nnz_per_at_col(num_rows, 0);
    for (int idx = 0; idx < (int)row_idx.size(); ++idx)
    {
        nnz_per_at_col[row_idx[idx]]++;
    }

    for (int c = 0; c < num_rows; ++c)
    {
        col_ptr_t[c + 1] = col_ptr_t[c] + nnz_per_at_col[c];
    }

    const int nnz = (int)row_idx.size();
    row_idx_t.assign(nnz, 0);
    values_t.assign(nnz, 0.0f);

    std::vector<int> next(col_ptr_t.begin(), col_ptr_t.begin() + num_rows);

    for (int c = 0; c < num_cols; ++c)
    {
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx)
        {
            const int r = row_idx[idx];
            const int dst = next[r]++;
            row_idx_t[dst] = c;
            values_t[dst] = values[idx];
        }
    }
}

static bool pack_csc_nnz_to_words(const std::vector<int> &row_idx,
                                 const std::vector<float> &values,
                                 std::vector<int16> &row_words,
                                 std::vector<float16> &val_words)
{
    if ((int)row_idx.size() != (int)values.size())
    {
        std::cout << "ERROR: pack: row/val size mismatch." << std::endl;
        return false;
    }
    const int nnz = (int)row_idx.size();
    if (nnz > MAX_NNZ_WORDS * PACK_SIZE)
    {
        std::cout << "ERROR: pack: nnz exceeds MAX_NNZ." << std::endl;
        return false;
    }

    // Clear full interface depth (cosim wrappers may read full depth).
    for (int w = 0; w < MAX_NNZ_WORDS; ++w)
    {
        for (int lane = 0; lane < PACK_SIZE; ++lane)
        {
            row_words[w][lane] = 0;
            val_words[w][lane] = 0.0f;
        }
    }

    for (int idx = 0; idx < nnz; ++idx)
    {
        const int w = idx / PACK_SIZE;
        const int lane = idx % PACK_SIZE;
        row_words[w][lane] = row_idx[idx];
        val_words[w][lane] = values[idx];
    }
    return true;
}

static std::vector<float> apply_K(int num_rows,
                                  int num_cols,
                                  const std::vector<int> &A_col_ptr,
                                  const std::vector<int> &A_row_idx,
                                  const std::vector<float> &A_values,
                                  const std::vector<int> &AT_col_ptr,
                                  const std::vector<int> &AT_row_idx,
                                  const std::vector<float> &AT_values,
                                  const std::vector<int> &P_col_ptr,
                                  const std::vector<int> &P_row_idx,
                                  const std::vector<float> &P_values,
                                  const std::vector<float> &rho,
                                  float sigma,
                                  const std::vector<float> &x)
{
    std::vector<float> tmp0(num_rows, 0.0f);
    std::vector<float> tmp1(num_rows, 0.0f);
    std::vector<float> tmp2(num_cols, 0.0f);
    std::vector<float> px(num_cols, 0.0f);

    spmv_sw_csc(num_rows, num_cols, A_col_ptr, A_row_idx, A_values, x, tmp0); // tmp0 = A*x
    for (int i = 0; i < num_rows; ++i)
    {
        tmp1[i] = rho[i] * tmp0[i]; // tmp1 = rho*(A*x)
    }
    spmv_sw_csc(num_cols, num_rows, AT_col_ptr, AT_row_idx, AT_values, tmp1, tmp2); // tmp2 = AT*tmp1
    spmv_sw_csc(num_cols, num_cols, P_col_ptr, P_row_idx, P_values, x, px);         // px = P*x

    std::vector<float> y(num_cols, 0.0f);
    for (int i = 0; i < num_cols; ++i)
    {
        y[i] = tmp2[i] + px[i] + sigma * x[i];
    }
    return y;
}

int main()
{
    const int num_rows = 1024;
    const int num_cols = 1024;

    std::cout << "Running PCG accelerator testbench (QP canonical form)..." << std::endl;
    std::cout << "Matrix sizes: A(" << num_rows << "x" << num_cols << "), P(" << num_cols << "x" << num_cols << ")" << std::endl;
    std::cout << "Target sparsity: ~1 nnz/column" << std::endl;

    // 3) Choose parameters so PCG converges on SPD K = P + sigma*I + AT*rho*A
    const float sigma = 1e-1f;
    const float epsilon_sq = 1e-8f;

    std::vector<float> rho(num_rows, 1.0f);
    std::cout << "sigma=" << sigma << ", epsilon_sq=" << epsilon_sq << ", rho=1.0" << std::endl;

    // RNG for reproducible inputs
    std::mt19937 rng(123);
    std::uniform_int_distribution<int> row_dist(0, num_rows - 1);
    std::uniform_real_distribution<float> a_dist(-1.0f, 1.0f);
    std::uniform_real_distribution<float> p_diag_dist(1.0f, 2.0f);
    std::uniform_real_distribution<float> q_dist(-1.0f, 1.0f);

    // 1) Declare A and P in CSC (1024x1024, ~1 nnz per column)
    const int A_nnz = num_cols; // exactly 1 nnz/column
    std::vector<int> A_col_ptr(num_cols + 1, 0);
    std::vector<int> A_row_idx(A_nnz, 0);
    std::vector<float> A_values(A_nnz, 0.0f);
    for (int c = 0; c < num_cols; ++c)
    {
        A_col_ptr[c] = c;
        A_row_idx[c] = row_dist(rng);
        float v = a_dist(rng);
        if (std::fabs(v) < 1e-3f)
            v = 1e-3f;
        A_values[c] = v;
    }
    A_col_ptr[num_cols] = A_nnz;

    const int P_nnz = num_cols; // diagonal => 1 nnz/column
    std::vector<int> P_col_ptr(num_cols + 1, 0);
    std::vector<int> P_row_idx(P_nnz, 0);
    std::vector<float> P_values(P_nnz, 0.0f);
    std::vector<float> P_diag(num_cols, 0.0f);
    for (int c = 0; c < num_cols; ++c)
    {
        P_col_ptr[c] = c;
        P_row_idx[c] = c;
        const float d = p_diag_dist(rng);
        P_values[c] = d;
        P_diag[c] = d;
    }
    P_col_ptr[num_cols] = P_nnz;

    std::cout << "A_nnz=" << A_nnz << ", P_nnz=" << P_nnz << std::endl;

    // 2) Obtain AT from A in CSC
    std::vector<int> AT_col_ptr;
    std::vector<int> AT_row_idx;
    std::vector<float> AT_values;
    transpose_csc(num_rows, num_cols, A_col_ptr, A_row_idx, A_values, AT_col_ptr, AT_row_idx, AT_values);
    std::cout << "AT_nnz=" << (int)AT_row_idx.size() << std::endl;

    // 5) Choose q and set b = q
    std::vector<float> b(num_cols, 0.0f);
    for (int i = 0; i < num_cols; ++i)
    {
        b[i] = q_dist(rng);
    }

    // 4) Compute M_inv from diag(K)
    // diag(K)_i = P_ii + sigma + sum_j rho_j * (A_{j,i})^2
    std::vector<float> M_inv(num_cols, 0.0f);
    for (int c = 0; c < num_cols; ++c)
    {
        float diagK = P_diag[c] + sigma;
        for (int idx = A_col_ptr[c]; idx < A_col_ptr[c + 1]; ++idx)
        {
            const int r = A_row_idx[idx];
            const float v = A_values[idx];
            diagK += rho[r] * v * v;
        }
        if (diagK <= 0.0f)
        {
            std::cout << "ERROR: non-positive diag(K) at i=" << c << ": " << diagK << std::endl;
            return 1;
        }
        M_inv[c] = 1.0f / diagK;
    }

    // Pack CSC NNZ arrays to 512b words (int16/float16)
    std::vector<int16> A_row_words(MAX_NNZ_WORDS);
    std::vector<float16> A_val_words(MAX_NNZ_WORDS);
    std::vector<int16> AT_row_words(MAX_NNZ_WORDS);
    std::vector<float16> AT_val_words(MAX_NNZ_WORDS);
    std::vector<int16> P_row_words(MAX_NNZ_WORDS);
    std::vector<float16> P_val_words(MAX_NNZ_WORDS);

    if (!pack_csc_nnz_to_words(A_row_idx, A_values, A_row_words, A_val_words))
        return 1;
    if (!pack_csc_nnz_to_words(AT_row_idx, AT_values, AT_row_words, AT_val_words))
        return 1;
    if (!pack_csc_nnz_to_words(P_row_idx, P_values, P_row_words, P_val_words))
        return 1;

    // Run accelerator
    std::vector<float> x_hw(num_cols, 0.0f);
    pcg(num_rows,
        num_cols,
        A_row_words.data(),
        A_col_ptr.data(),
        A_val_words.data(),
        A_nnz,
        AT_row_words.data(),
        AT_col_ptr.data(),
        AT_val_words.data(),
        P_row_words.data(),
        P_col_ptr.data(),
        P_val_words.data(),
        P_nnz,
        M_inv.data(),
        b.data(),
        rho.data(),
        sigma,
        epsilon_sq,
        x_hw.data());

    // Verify: relative residual ||Kx - b|| / ||b||
    const std::vector<float> Kx = apply_K(num_rows,
                                          num_cols,
                                          A_col_ptr,
                                          A_row_idx,
                                          A_values,
                                          AT_col_ptr,
                                          AT_row_idx,
                                          AT_values,
                                          P_col_ptr,
                                          P_row_idx,
                                          P_values,
                                          rho,
                                          sigma,
                                          x_hw);

    double norm_b2 = 0.0;
    double norm_r2 = 0.0;
    for (int i = 0; i < num_cols; ++i)
    {
        const double bi = (double)b[i];
        const double ri = (double)Kx[i] - (double)b[i];
        norm_b2 += bi * bi;
        norm_r2 += ri * ri;
    }
    const double rel_res = std::sqrt(norm_r2 / (norm_b2 + 1e-30));

    std::cout << std::scientific << std::setprecision(3);
    std::cout << "||b||^2=" << norm_b2 << ", ||Kx-b||^2=" << norm_r2 << ", rel_res=" << rel_res << std::endl;

    const double target = std::sqrt((double)epsilon_sq);
    const double slack = 5.0; // allow some slack vs the ideal stop threshold
    if (rel_res <= slack * target)
    {
        std::cout << ">>> SUCCESS: PCG residual meets tolerance. <<<" << std::endl;
        return 0;
    }

    std::cout << ">>> FAILED: residual too large (target~" << target << "). <<<" << std::endl;
    return 1;
}