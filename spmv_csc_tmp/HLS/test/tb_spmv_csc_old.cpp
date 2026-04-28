#include <iostream>
#include <vector>
#include <cmath>
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
    std::cout << "Running Optimized SPMV (CSC) testbench..." << std::endl;

    int num_rows = 10;
    int num_cols = 10;
    int original_nnz = 19;

    // CSC representation of the matrix (Traversed Top-to-Bottom, Left-to-Right)
    std::vector<float> A_values  = {11.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 1.0};
    std::vector<int>   A_row_idx = {0,   6,   9,   1,   4,   2,   7,   3,   4,   0,   5,   6,   1,   7,   3,   8,   5,   8,   9  };
    std::vector<int>   A_col_ptr = {0, 3, 5, 7, 8, 9, 11, 12, 14, 16, 19};
    
    // Input vector 'x'
    std::vector<float> x = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0};
    
    // Output vectors
    std::vector<float> y_hw(num_rows, 0.0f);  
    std::vector<float> y_sw(num_rows, 0.0f);

    // =========================================================
    // NOTE: Unlike the optimized CSR, your current CSC hardware 
    // uses standard 32-bit floats and ints. No PACK_SIZE padding 
    // or float16 casting is required for this version.
    // =========================================================

    // Call the software reference implementation BEFORE the HW call
    spmv_csc_sw(num_rows, num_cols, A_row_idx.data(), A_col_ptr.data(), A_values.data(), x.data(), y_sw.data());

    // Call the hardware-accelerated SPMV function
    spmv_csc(num_rows, num_cols, original_nnz, 
             A_row_idx.data(), 
             A_col_ptr.data(), 
             A_values.data(), 
             x.data(), 
             y_hw.data());

    // Print Results
    std::cout << "\nResult Vector (y):" << std::endl;
    std::cout << "Row | SW Ref  | HW Accel" << std::endl;
    std::cout << "------------------------" << std::endl;
    for (int i = 0; i < num_rows; i++) {
        std::cout << " " << i << "  | " << y_sw[i] << "    | " << y_hw[i] << std::endl;
    }
    std::cout << std::endl;

    // Verify results
    bool pass = true;
    for (int i = 0; i < num_rows; i++) {
        if (std::fabs(y_hw[i] - y_sw[i]) > 1e-5) {
            std::cout << "Mismatch at row " << i << ": HW = " << y_hw[i] << ", SW = " << y_sw[i] << std::endl;
            pass = false;
        }
    }

    if (pass) {
        std::cout << "All tests passed!" << std::endl;
    } else {
        std::cout << "Some tests failed!" << std::endl;
    }

    return 0;
}