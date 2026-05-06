#include <cmath>
#include <iomanip>
#include <iostream>
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

static std::vector<float> csc_to_dense(int num_rows,
                                       int num_cols,
                                       const std::vector<int> &col_ptr,
                                       const std::vector<int> &row_idx,
                                       const std::vector<float> &values)
{
    std::vector<float> dense(num_rows * num_cols, 0.0f);
    for (int c = 0; c < num_cols; ++c)
    {
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx)
        {
            const int r = row_idx[idx];
            dense[r * num_cols + c] += values[idx];
        }
    }
    return dense;
}

static void print_vec(const char *name, const std::vector<float> &v)
{
    std::cout << name << " = [";
    for (int i = 0; i < (int)v.size(); ++i)
    {
        std::cout << v[i];
        if (i + 1 != (int)v.size())
            std::cout << ", ";
    }
    std::cout << "]" << std::endl;
}

static void print_dense_mat(const char *name, int num_rows, int num_cols, const std::vector<float> &dense)
{
    std::cout << name << " =" << std::endl;
    for (int r = 0; r < num_rows; ++r)
    {
        std::cout << "  [";
        for (int c = 0; c < num_cols; ++c)
        {
            std::cout << dense[r * num_cols + c];
            if (c + 1 != num_cols)
                std::cout << ", ";
        }
        std::cout << "]" << std::endl;
    }
}

static void print_csc(const char *name,
                      const std::vector<int> &col_ptr,
                      const std::vector<int> &row_idx,
                      const std::vector<float> &values)
{
    std::cout << name << " (CSC): col_ptr=[";
    for (int i = 0; i < (int)col_ptr.size(); ++i)
    {
        std::cout << col_ptr[i] << (i + 1 == (int)col_ptr.size() ? "]" : ", ");
    }
    std::cout << ", row_idx=[";
    for (int i = 0; i < (int)row_idx.size(); ++i)
    {
        std::cout << row_idx[i] << (i + 1 == (int)row_idx.size() ? "]" : ", ");
    }
    std::cout << ", values=[";
    for (int i = 0; i < (int)values.size(); ++i)
    {
        std::cout << values[i] << (i + 1 == (int)values.size() ? "]" : ", ");
    }
    std::cout << std::endl;
}

int main()
{
    const int num_rows = 3;
    const int num_cols = 3;

    std::cout << "Running PCG accelerator testbench (3x3, QP canonical form)..." << std::endl;
    std::cout << "Matrix sizes: A(" << num_rows << "x" << num_cols << "), P(" << num_cols << "x" << num_cols << ")" << std::endl;

    // Choose parameters so PCG converges on SPD K = P + sigma*I + AT*rho*A
    const float sigma = 1e-1f;
    const float epsilon_sq = 1e-8f;

    std::vector<float> rho(num_rows, 1.0f);

    // Build a simple deterministic 3x3 case:
    // A = I (CSC with 1 nnz/col), P = diag(2,3,4), rho = 1.
    const int A_nnz = num_cols;
    std::vector<int> A_col_ptr(num_cols + 1, 0);
    std::vector<int> A_row_idx(A_nnz, 0);
    std::vector<float> A_values(A_nnz, 1.0f);
    for (int c = 0; c < num_cols; ++c)
    {
        A_col_ptr[c] = c;
        A_row_idx[c] = c;
        A_values[c] = 1.0f;
    }
    A_col_ptr[num_cols] = A_nnz;

    const int P_nnz = num_cols;
    std::vector<int> P_col_ptr(num_cols + 1, 0);
    std::vector<int> P_row_idx(P_nnz, 0);
    std::vector<float> P_values(P_nnz, 0.0f);
    std::vector<float> P_diag(num_cols, 0.0f);
    {
        const float diag_vals[num_cols] = {2.0f, 3.0f, 4.0f};
        for (int c = 0; c < num_cols; ++c)
        {
            P_col_ptr[c] = c;
            P_row_idx[c] = c;
            P_values[c] = diag_vals[c];
            P_diag[c] = diag_vals[c];
        }
        P_col_ptr[num_cols] = P_nnz;
    }

    // Obtain AT from A in CSC
    std::vector<int> AT_col_ptr;
    std::vector<int> AT_row_idx;
    std::vector<float> AT_values;
    transpose_csc(num_rows, num_cols, A_col_ptr, A_row_idx, A_values, AT_col_ptr, AT_row_idx, AT_values);

    // Choose b
    std::vector<float> b(num_cols, 0.0f);
    b[0] = 1.0f;
    b[1] = 2.0f;
    b[2] = 3.0f;

    // Compute M_inv from diag(K)
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

    // Print full system so it can be checked by hand.
    std::cout << std::fixed << std::setprecision(6);
    std::cout << "sigma = " << sigma << std::endl;
    std::cout << "epsilon_sq = " << epsilon_sq << std::endl;
    print_vec("rho", rho);
    print_vec("b", b);
    print_vec("M_inv", M_inv);
    print_csc("A", A_col_ptr, A_row_idx, A_values);
    print_csc("AT", AT_col_ptr, AT_row_idx, AT_values);
    print_csc("P", P_col_ptr, P_row_idx, P_values);

    const std::vector<float> A_dense = csc_to_dense(num_rows, num_cols, A_col_ptr, A_row_idx, A_values);
    const std::vector<float> AT_dense = csc_to_dense(num_cols, num_rows, AT_col_ptr, AT_row_idx, AT_values);
    const std::vector<float> P_dense = csc_to_dense(num_cols, num_cols, P_col_ptr, P_row_idx, P_values);

    print_dense_mat("A", num_rows, num_cols, A_dense);
    print_dense_mat("AT", num_cols, num_rows, AT_dense);
    print_dense_mat("P", num_cols, num_cols, P_dense);

    // Assemble dense K = P + sigma*I + AT*diag(rho)*A
    std::vector<float> RhoA(num_rows * num_cols, 0.0f);
    for (int r = 0; r < num_rows; ++r)
    {
        for (int c = 0; c < num_cols; ++c)
        {
            RhoA[r * num_cols + c] = rho[r] * A_dense[r * num_cols + c];
        }
    }

    std::vector<float> AT_RhoA(num_cols * num_cols, 0.0f);
    for (int i = 0; i < num_cols; ++i)
    {
        for (int j = 0; j < num_cols; ++j)
        {
            float acc = 0.0f;
            for (int k = 0; k < num_rows; ++k)
            {
                acc += AT_dense[i * num_rows + k] * RhoA[k * num_cols + j];
            }
            AT_RhoA[i * num_cols + j] = acc;
        }
    }

    std::vector<float> K_dense(num_cols * num_cols, 0.0f);
    for (int r = 0; r < num_cols; ++r)
    {
        for (int c = 0; c < num_cols; ++c)
        {
            float v = P_dense[r * num_cols + c] + AT_RhoA[r * num_cols + c];
            if (r == c)
                v += sigma;
            K_dense[r * num_cols + c] = v;
        }
    }
    print_dense_mat("K = P + sigma*I + AT*diag(rho)*A", num_cols, num_cols, K_dense);

    // Kernel interface arrays are sized to MAX_* depths; allocate full depth to be safe for cosim wrappers.
    std::vector<int> A_col_ptr_full(MAX_COL_PTR, 0);
    std::vector<int> AT_col_ptr_full(MAX_COL_PTR, 0);
    std::vector<int> P_col_ptr_full(MAX_COL_PTR, 0);
    for (int i = 0; i < num_cols + 1; ++i)
    {
        A_col_ptr_full[i] = A_col_ptr[i];
        P_col_ptr_full[i] = P_col_ptr[i];
    }
    for (int i = 0; i < num_rows + 1; ++i)
    {
        AT_col_ptr_full[i] = AT_col_ptr[i];
    }

    std::vector<float> b_full(MAX_COLS, 0.0f);
    std::vector<float> rho_full(MAX_COLS, 0.0f);
    std::vector<float> M_inv_full(MAX_COLS, 0.0f);
    for (int i = 0; i < num_cols; ++i)
    {
        b_full[i] = b[i];
        M_inv_full[i] = M_inv[i];
    }
    for (int i = 0; i < num_rows; ++i)
    {
        rho_full[i] = rho[i];
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
    std::vector<float> x_hw_full(MAX_COLS, 0.0f);
    pcg(num_rows,
        num_cols,
        A_row_words.data(),
        A_col_ptr_full.data(),
        A_val_words.data(),
        A_nnz,
        AT_row_words.data(),
        AT_col_ptr_full.data(),
        AT_val_words.data(),
        P_row_words.data(),
        P_col_ptr_full.data(),
        P_val_words.data(),
        P_nnz,
        M_inv_full.data(),
        b_full.data(),
        rho_full.data(),
        sigma,
        epsilon_sq,
        x_hw_full.data());

    std::cout << "x_hw = [" << x_hw_full[0] << ", " << x_hw_full[1] << ", " << x_hw_full[2] << "]" << std::endl;

    // Verify: relative residual ||Kx - b|| / ||b||
    std::vector<float> x_hw(num_cols, 0.0f);
    for (int i = 0; i < num_cols; ++i)
        x_hw[i] = x_hw_full[i];

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
    const double slack = 5.0;
    if (rel_res <= slack * target)
    {
        std::cout << ">>> SUCCESS: PCG residual meets tolerance. <<<" << std::endl;
        return 0;
    }

    std::cout << ">>> FAILED: residual too large (target~" << target << "). <<<" << std::endl;
    return 1;
}
