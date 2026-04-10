#include <iostream>
#include <vector>
#include <cmath>
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
    std::cout << "Running SPMV testbench..." << std::endl;

    int num_rows = 10;
    int num_cols = 10;

    // Define a simple sparse matrix in CSR format
    // Define a 10x10 sparse matrix:
    // [ 1.0  0.0  0.0  0.0  0.0  2.0  0.0  0.0  0.0  0.0 ]
    // [ 0.0  3.0  0.0  0.0  0.0  0.0  0.0  4.0  0.0  0.0 ]
    // [ 0.0  0.0  5.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0 ]
    // [ 0.0  0.0  0.0  6.0  0.0  0.0  0.0  0.0  7.0  0.0 ]
    // [ 0.0  8.0  0.0  0.0  9.0  0.0  0.0  0.0  0.0  0.0 ]
    // [ 0.0  0.0  0.0  0.0  0.0  1.0  0.0  0.0  0.0  2.0 ]
    // [ 3.0  0.0  0.0  0.0  0.0  0.0  4.0  0.0  0.0  0.0 ]
    // [ 0.0  0.0  5.0  0.0  0.0  0.0  0.0  6.0  0.0  0.0 ]
    // [ 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  7.0  8.0 ]
    // [ 9.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  1.0 ]

    // CSR representation of the matrix above (19 non-zero elements)
    std::vector<float> A_values    = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 1.0};
    std::vector<int>   A_col_index = {0, 5, 1, 7, 2, 3, 8, 1, 4, 5, 9, 0, 6, 2, 7, 8, 9, 0, 9};
    
    // A_row_index always has size (num_rows + 1). 
    // It indicates the starting index in A_values/A_col_index for each row.
    std::vector<int>   A_row_index = {0, 2, 4, 5, 7, 9, 11, 13, 15, 17, 19};
    
    // Input vector 'x' (must match the number of columns, which is 10)
    std::vector<float> x = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0};
    
    // Output vectors (must match the number of rows, which is 10)
    std::vector<float> y_hw(num_rows, 0.0f);  
    std::vector<float> y_sw(num_rows, 0.0f);

    // Call the hardware-accelerated SPMV function
    spmv_csr(num_rows, num_cols, A_row_index.data(), A_col_index.data(), A_values.data(), x.data(), y_hw.data());

    // Call the software reference implementation
    spmv_csr_sw(num_rows, A_row_index.data(), A_col_index.data(), A_values.data(), x.data(), y_sw.data());


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