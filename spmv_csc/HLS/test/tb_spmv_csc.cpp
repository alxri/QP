#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <iomanip>
#include "spmv_csc.h"

// Software reference implementation of SPMV for verification (CSC format)
void spmv_csc_sw(int num_rows, int num_cols, const int *A_row_idx, const int *A_col_ptr, 
                 const float *A_values, const float *x, float *y_ref) 
{
    // Initialize output vector to 0
    for (int i = 0; i < num_rows; i++) {
        y_ref[i] = 0.0f;
    }

    // CSC SpMV computation
    for (int i = 0; i < num_cols; i++) {
        int col_start = A_col_ptr[i];
        int col_end = A_col_ptr[i + 1];
        float x_i = x[i];

        for (int k = col_start; k < col_end; k++) {
            y_ref[A_row_idx[k]] += A_values[k] * x_i;
        }
    }
}

int main() {
    std::cout << "Running Regular SPMV (CSC) testbench..." << std::endl;

    // Set matrix dimensions and density
    int num_rows = 1024;
    int num_cols = 1024;
    float density = 0.0001f; // 10%

    std::vector<float> A_values;
    std::vector<int>   A_row_idx;
    // NOTE: Vitis HLS cosim copies pointer arguments based on the interface `depth`,
    // not runtime sizes. Allocate buffers to the max depths used in the kernel.
    std::vector<int>   A_col_ptr(MAX_COL_PTR, 0); // CSC uses num_cols + 1 (<= MAX_COL_PTR)
    std::vector<float> x(num_cols, 0.0f);

    // Setup Random Number Generation
    std::default_random_engine generator(123); // Fixed seed for reproducible results
    std::uniform_real_distribution<float> value_dist(1.0f, 10.0f);
    std::uniform_real_distribution<float> prob_dist(0.0f, 1.0f);

    std::cout << "Generating " << num_rows << "x" << num_cols << " matrix with " << (density * 100) << "% density..." << std::endl;

    // Generate Input Vector 'x'
    for (int i = 0; i < num_cols; ++i) {
        x[i] = value_dist(generator);
    }

    // Generate CSC Matrix
    // CRITICAL DIFFERENCE: We iterate columns first, then rows, to build CSC naturally.
    int current_nnz = 0;
    for (int j = 0; j < num_cols; ++j) {
        for (int i = 0; i < num_rows; ++i) {
            // 10% chance to create a non-zero element
            if (prob_dist(generator) < density) {
                A_values.push_back(value_dist(generator));
                A_row_idx.push_back(i); // Store the row index
                current_nnz++;
            }
        }
        A_col_ptr[j + 1] = current_nnz;
    }

    int original_nnz = A_values.size();
    std::cout << "Generation complete. Total NNZ: " << original_nnz << std::endl;

    // Output vectors
    std::vector<float> y_hw(num_rows, 0.0f);
    std::vector<float> y_sw(num_rows, 0.0f);

    if (num_rows > MAX_ROWS || num_cols > MAX_COLS || original_nnz > MAX_NNZ) {
        std::cerr << "ERROR: problem size exceeds kernel limits. "
                  << "num_rows=" << num_rows << " (MAX_ROWS=" << MAX_ROWS << "), "
                  << "num_cols=" << num_cols << " (MAX_COLS=" << MAX_COLS << "), "
                  << "nnz=" << original_nnz << " (MAX_NNZ=" << MAX_NNZ << ")" << std::endl;
        return 1;
    }

    // Pack scalar arrays into 512-bit (16x32b) words for the HLS kernel
    const int nnz_words = CEIL_DIV(original_nnz, PACK_SIZE);
    const int x_words   = CEIL_DIV(num_cols, PACK_SIZE);
    const int y_words   = CEIL_DIV(num_rows, PACK_SIZE);

    std::vector<float16> A_values_packed(MAX_NNZ_WORDS);
    std::vector<int16>   A_row_idx_packed(MAX_NNZ_WORDS);
    std::vector<float16> x_packed(MAX_COL_WORDS);
    std::vector<float16> y_packed(MAX_ROW_WORDS);

    // Initialize packed containers (including padded lanes)
    for (int w = 0; w < MAX_NNZ_WORDS; ++w) {
        for (int lane = 0; lane < PACK_SIZE; ++lane) {
            A_values_packed[w][lane] = 0.0f;
            A_row_idx_packed[w][lane] = 0;
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
    }
    for (int i = 0; i < num_cols; ++i) {
        const int w    = i / PACK_SIZE;
        const int lane = i % PACK_SIZE;
        x_packed[w][lane] = x[i];
    }

    // =========================================================
    // Packed I/O: the HLS kernel uses 512-bit ports (16x32b lanes).
    // The software reference uses the scalar arrays.
    // =========================================================

    std::cout << "Running Software Reference..." << std::endl;
    // Call the software reference implementation BEFORE the HW call
    spmv_csc_sw(num_rows, num_cols, A_row_idx.data(), A_col_ptr.data(), A_values.data(), x.data(), y_sw.data());

    std::cout << "Running Hardware Accelerator..." << std::endl;
    // Call the hardware accelerator
    spmv_csc(num_rows, num_cols, original_nnz, 
             A_row_idx_packed.data(), 
             A_col_ptr.data(), 
             A_values_packed.data(), 
             x_packed.data(), 
             y_packed.data());

    // Unpack HW result
    for (int i = 0; i < num_rows; ++i) {
        const int w    = i / PACK_SIZE;
        const int lane = i % PACK_SIZE;
        y_hw[i] = y_packed[w][lane];
    }

    // Print Results (Only the first 10 to avoid console spam)
    std::cout << "\nResult Vector (y) [Showing first 10 rows]:" << std::endl;
    std::cout << "Row | SW Ref       | HW Accel" << std::endl;
    std::cout << "----------------------------------" << std::endl;
    for (int i = 0; i < std::min(10, num_rows); i++) {
        std::cout << std::setw(3) << i << " | " 
                  << std::setw(10) << y_sw[i] << " | " 
                  << std::setw(10) << y_hw[i] << std::endl;
    }
    std::cout << "...\n" << std::endl;

    // Verify results using Relative Error
    bool pass = true;
    int error_count = 0;
    
    // We allow a 0.05% margin of error (relative to the size of the number)
    const float RELATIVE_TOLERANCE = 0.0005f; 

    for (int i = 0; i < num_rows; i++) {
        float expected = y_sw[i];
        float actual = y_hw[i];
        float diff = std::fabs(actual - expected);
        
        // Calculate relative error (avoiding division by zero)
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