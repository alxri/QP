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
    std::cout << "Running Regular SPMV (CSC) Baseline testbench..." << std::endl;

    // Set matrix dimensions and density
    int num_rows = 1024;
    int num_cols = 1024;
    float density = 10.0f / num_cols; // ~10 non-zeros per column


    std::vector<float> A_values;
    std::vector<int>   A_row_idx;
    std::vector<int>   A_col_ptr(num_cols + 1, 0); 
    std::vector<float> x(num_cols, 0.0f);

    // Setup Random Number Generation
    std::default_random_engine generator(123); 
    std::uniform_real_distribution<float> value_dist(1.0f, 10.0f);
    std::uniform_real_distribution<float> prob_dist(0.0f, 1.0f);

    std::cout << "Generating " << num_rows << "x" << num_cols << " matrix with " << (density * 100) << "% density..." << std::endl;

    // Generate Input Vector 'x'
    for (int i = 0; i < num_cols; ++i) {
        x[i] = value_dist(generator);
    }

    // Generate CSC Matrix
    int current_nnz = 0;
    for (int j = 0; j < num_cols; ++j) {
        for (int i = 0; i < num_rows; ++i) {
            if (prob_dist(generator) < density) {
                A_values.push_back(value_dist(generator));
                A_row_idx.push_back(i);
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

    // =========================================================
    // CO-SIMULATION FIX: Pad all vectors to match the pragma depths
    // This prevents the wrapper from reading unallocated memory.
    // =========================================================
    A_values.resize(MAX_NNZ, 0.0f);
    A_row_idx.resize(MAX_NNZ, 0);
    A_col_ptr.resize(MAX_COL_PTR, 0);
    x.resize(MAX_COLS, 0.0f);
    y_hw.resize(MAX_ROWS, 0.0f);

    std::cout << "Running Software Reference..." << std::endl;
    // Call the software reference implementation
    spmv_csc_sw(num_rows, num_cols, A_row_idx.data(), A_col_ptr.data(), A_values.data(), x.data(), y_sw.data());

    std::cout << "Running Hardware Accelerator..." << std::endl;
    // Call the hardware accelerator (no packing needed)
    spmv_csc(num_rows, num_cols, original_nnz, 
             A_row_idx.data(), 
             A_col_ptr.data(), 
             A_values.data(), 
             x.data(), 
             y_hw.data(),
             true,   // clear_y: true because this is a single execution
             true);  // write_y: true to flush y_internal to the output buffer

    // Print Results
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
    const float RELATIVE_TOLERANCE = 0.0005f; 

    for (int i = 0; i < num_rows; i++) {
        float expected = y_sw[i];
        float actual = y_hw[i];
        float diff = std::fabs(actual - expected);
        
        float rel_error = diff / (std::fabs(expected) + 1e-8f);

        if (rel_error > RELATIVE_TOLERANCE && diff > 1e-5f) {
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