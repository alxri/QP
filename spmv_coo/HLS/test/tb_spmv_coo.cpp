#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <iomanip>
#include "spmv_coo.h"

static void spmv_coo_sw(int num_rows,
                        int num_cols,
                        int nnz,
                        const int *A_row_idx,
                        const int *A_col_idx,
                        const float *A_values,
                        const float *x,
                        float *y_ref)
{
    for (int i = 0; i < num_rows; i++) {
        y_ref[i] = 0.0f;
    }

    for (int k = 0; k < nnz; ++k) {
        const int r = A_row_idx[k];
        const int c = A_col_idx[k];
        if ((unsigned)r < (unsigned)num_rows && (unsigned)c < (unsigned)num_cols) {
            y_ref[r] += A_values[k] * x[c];
        }
    }
}

int main() {
    std::cout << "Running Regular SPMV (COO) testbench..." << std::endl;

    int num_rows = 1024;
    int num_cols = 1024;
    float density = 0.001f;

    std::vector<float> A_values;
    std::vector<int>   A_row_idx;
    std::vector<int>   A_col_idx;
    std::vector<float> x_scalar(num_cols, 0.0f);

    std::default_random_engine generator(123);
    std::uniform_real_distribution<float> value_dist(1.0f, 10.0f);
    std::uniform_real_distribution<float> prob_dist(0.0f, 1.0f);

    std::cout << "Generating " << num_rows << "x" << num_cols << " matrix with " << (density * 100) << "% density..." << std::endl;

    for (int i = 0; i < num_cols; ++i) {
        x_scalar[i] = value_dist(generator);
    }

    int current_nnz = 0;
    for (int j = 0; j < num_cols; ++j) {
        for (int i = 0; i < num_rows; ++i) {
            if (prob_dist(generator) < density) {
                A_values.push_back(value_dist(generator));
                A_row_idx.push_back(i);
                A_col_idx.push_back(j);
                current_nnz++;
            }
        }
    }

    int original_nnz = A_values.size();
    std::cout << "Generation complete. Total NNZ: " << original_nnz << std::endl;

    std::vector<float> y_hw(num_rows, 0.0f);
    std::vector<float> y_sw(num_rows, 0.0f);

    if (num_rows > MAX_ROWS || num_cols > MAX_COLS || original_nnz > MAX_NNZ) {
        std::cerr << "ERROR: problem size exceeds kernel limits. "
                  << "num_rows=" << num_rows << " (MAX_ROWS=" << MAX_ROWS << "), "
                  << "num_cols=" << num_cols << " (MAX_COLS=" << MAX_COLS << "), "
                  << "nnz=" << original_nnz << " (MAX_NNZ=" << MAX_NNZ << ")" << std::endl;
        return 1;
    }

    const int nnz_words = CEIL_DIV(original_nnz, PACK_SIZE);
    const int y_words   = CEIL_DIV(num_rows, PACK_SIZE);
    const int x_words   = CEIL_DIV(num_cols, PACK_SIZE);

    std::vector<float16> A_values_packed(MAX_NNZ_WORDS);
    std::vector<int16>   A_row_idx_packed(MAX_NNZ_WORDS);
    std::vector<int16>   A_col_idx_packed(MAX_NNZ_WORDS);
    std::vector<float16> x_packed(MAX_COL_WORDS);
    std::vector<float16> y_packed(MAX_ROW_WORDS);

    for (int w = 0; w < MAX_NNZ_WORDS; ++w) {
        for (int lane = 0; lane < PACK_SIZE; ++lane) {
            A_values_packed[w][lane] = 0.0f;
            A_row_idx_packed[w][lane] = 0;
            A_col_idx_packed[w][lane] = 0;
        }
    }
    for (int w = 0; w < MAX_COL_WORDS; ++w) {
        for (int lane = 0; lane < PACK_SIZE; ++lane) {
            x_packed[w][lane] = 0.0f;
        }
    }
    for (int w = 0; w < MAX_ROW_WORDS; ++w) {
        for (int lane = 0; lane < PACK_SIZE; ++lane) {
            y_packed[w][lane] = 0.0f;
        }
    }

    for (int i = 0; i < original_nnz; ++i) {
        const int w    = i / PACK_SIZE;
        const int lane = i % PACK_SIZE;
        A_values_packed[w][lane]  = A_values[i];
        A_row_idx_packed[w][lane] = A_row_idx[i];
        A_col_idx_packed[w][lane] = A_col_idx[i];
    }

    for (int i = 0; i < num_cols; ++i) {
        const int w    = i / PACK_SIZE;
        const int lane = i % PACK_SIZE;
        x_packed[w][lane] = x_scalar[i];
    }

    std::cout << "Running Software Reference..." << std::endl;
    spmv_coo_sw(num_rows, num_cols, original_nnz, A_row_idx.data(), A_col_idx.data(), A_values.data(), x_scalar.data(), y_sw.data());

    std::cout << "Running Hardware Accelerator..." << std::endl;
    spmv_coo(num_rows, num_cols, original_nnz,
             A_row_idx_packed.data(),
             A_col_idx_packed.data(),
             A_values_packed.data(),
             x_packed.data(),
             y_packed.data());

    for (int i = 0; i < num_rows; ++i) {
        const int w    = i / PACK_SIZE;
        const int lane = i % PACK_SIZE;
        y_hw[i] = y_packed[w][lane];
    }

    std::cout << "\nResult Vector (y) [Showing first 10 rows]:" << std::endl;
    std::cout << "Row | SW Ref       | HW Accel" << std::endl;
    std::cout << "----------------------------------" << std::endl;
    for (int i = 0; i < std::min(10, num_rows); i++) {
        std::cout << std::setw(3) << i << " | " 
                  << std::setw(10) << y_sw[i] << " | " 
                  << std::setw(10) << y_hw[i] << std::endl;
    }
    std::cout << "...\n" << std::endl;

    bool pass = true;
    int error_count = 0;
    const float RELATIVE_TOLERANCE = 0.0005f; 

    for (int i = 0; i < num_rows; i++) {
        float expected = y_sw[i];
        float actual = y_hw[i];
        float diff = std::fabs(actual - expected);
        
        float rel_error = diff / (std::fabs(expected) + 1e-8f);

        if (rel_error > RELATIVE_TOLERANCE) {
            if (error_count < 10) { 
                std::cout << "Mismatch at row " << i 
                          << ": HW = " << actual 
                          << ", SW = " << expected 
                          << " (Diff = " << diff << ")" << std::endl;
            }
            pass = false;
            error_count++;
        }
    }

    if (pass) {
        std::cout << "All " << num_rows << " tests passed!" << std::endl;
    } else {
        std::cout << "Failed with " << error_count << " mismatches!" << std::endl;
    }

    return 0;
}