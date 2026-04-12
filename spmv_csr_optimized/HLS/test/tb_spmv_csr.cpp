#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <iomanip>
#include "spmv_csr.h"

// Software reference implementation of SPMV for verification
void spmv_csr_sw(int num_rows, const int *A_row_index, const int *A_col_index, 
                 const float *A_values, const float *x, float *y_ref) 
{
    for (int i = 0; i < num_rows; i++) {
        float sum = 0.0f;
        int row_start = A_row_index[i];
        int row_end = A_row_index[i + 1];

        for (int j = row_start; j < row_end; j++) {
            sum += A_values[j] * x[A_col_index[j]];
        }
        y_ref[i] = sum;
    }
}

int main() {
    std::cout << "Running Optimized SPMV testbench..." << std::endl;

    // Set matrix dimensions and density
    int num_rows = 1024;
    int num_cols = 1024;
    float density = 0.10f; // 10%

    std::vector<float> A_values;
    std::vector<int>   A_col_index;
    std::vector<int>   A_row_index(num_rows + 1, 0);
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

    // Generate CSR Matrix
    int current_nnz = 0;
    for (int i = 0; i < num_rows; ++i) {
        for (int j = 0; j < num_cols; ++j) {
            // 10% chance to create a non-zero element
            if (prob_dist(generator) < density) {
                A_values.push_back(value_dist(generator));
                A_col_index.push_back(j);
                current_nnz++;
            }
        }
        A_row_index[i + 1] = current_nnz;
    }

    int original_nnz = A_values.size();
    std::cout << "Generation complete. Total NNZ: " << original_nnz << std::endl;

    // Output vectors
    std::vector<float> y_hw(num_rows, 0.0f);  
    std::vector<float> y_sw(num_rows, 0.0f);

    // =========================================================
    // OPTIMIZATION FIX: Pad the vectors to multiples of PACK_SIZE
    // =========================================================
    int padded_nnz  = ((original_nnz + PACK_SIZE - 1) / PACK_SIZE) * PACK_SIZE;
    int padded_cols = ((num_cols + PACK_SIZE - 1) / PACK_SIZE) * PACK_SIZE;

    // Resize vectors (pads the end with 0s automatically)
    A_values.resize(padded_nnz, 0.0f);
    A_col_index.resize(padded_nnz, 0);
    x.resize(padded_cols, 0.0f);

    std::cout << "Running Software Reference..." << std::endl;
    // Call the software reference implementation BEFORE the HW call
    spmv_csr_sw(num_rows, A_row_index.data(), A_col_index.data(), A_values.data(), x.data(), y_sw.data());

    std::cout << "Running Hardware Accelerator..." << std::endl;
    // =========================================================
    // OPTIMIZATION FIX: Cast the pointers to the new 512-bit types
    // Note: We pass the ORIGINAL nnz, not the padded nnz!
    // =========================================================
    spmv_csr(num_rows, num_cols, original_nnz, 
             A_row_index.data(), 
             (const int16 *)A_col_index.data(), 
             (const float16 *)A_values.data(), 
             (const float16 *)x.data(), 
             y_hw.data());

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