#include <iostream>
#include <vector>
#include <cmath>
#include <fstream>
#include <sstream>
#include <string>
#include <iomanip>
#include <random>   // <--- ADD THIS HEADER
#include "spmv_csc.h"

void load_rows(std::vector<int>& rowPtr) {
    std::ifstream file("./rows.dat");
    int val;
    // Skip the tag if present, or just read integers
    std::string word;
    while (file >> word) {
        if (word[0] == '[') {
            file >> word; // skip the number and the ']'
            continue;
        }
        try {
            rowPtr.push_back(std::stoi(word));
        } catch (...) {}
    }
    file.close();
}

void load_cols(std::vector<int>& colIndex) {
    std::ifstream file("./cols.dat");
    int val;
    std::string word;
    while (file >> word) {
        if (word[0] == '[') {
            file >> word;
            continue;
        }
        try {
            colIndex.push_back(std::stoi(word));
        } catch (...) {}
    }
    file.close();
}

void load_data(std::vector<float>& values) {
    std::ifstream file("./data.dat");
    std::string word;
    while (file >> word) {
        if (word[0] == '[') {
            file >> word;
            continue;
        }
        try {
            values.push_back(std::stof(word));
        } catch (...) {}
    }
    file.close();
}

void spmv_csc_sw(int num_rows, int num_cols, const int *A_row_idx, const int *A_col_ptr, 
                 const float *A_values, const float *x, float *y_ref) 
{
    for (int i = 0; i < num_rows; i++) y_ref[i] = 0.0f;
    for (int j = 0; j < num_cols; j++) {
        for (int k = A_col_ptr[j]; k < A_col_ptr[j + 1]; k++) {
            y_ref[A_row_idx[k]] += A_values[k] * x[j];
        }
    }
}

int main() {
    std::vector<int> raw_row_ptr;   
    std::vector<int> raw_col_idx;   
    std::vector<float> raw_values;  

    load_rows(raw_row_ptr);
    load_cols(raw_col_idx);
    load_data(raw_values);

    if (raw_row_ptr.empty() || raw_values.empty()) {
        std::cerr << "Error: Could not load data files!" << std::endl;
        return 1;
    }

    int num_rows = raw_row_ptr.size() - 1;
    int num_cols = num_rows; 
    int nnz = raw_values.size();

    std::cout << "Matrix: " << num_rows << "x" << num_cols << ", NNZ: " << nnz << std::endl;

    std::vector<float> x(num_cols);
    std::vector<float> y_sw(num_rows, 0.0f);
    std::vector<float> y_hw(num_rows, 0.0f);

    // FIXED RANDOM GENERATION
    std::default_random_engine gen(42); 
    std::uniform_real_distribution<float> dist(1.0, 10.0);
    for (int i = 0; i < num_cols; ++i) x[i] = (float)((int)dist(gen));

    // Packing
    std::vector<float16> A_values_packed(MAX_NNZ_WORDS);
    std::vector<int16>   A_row_idx_packed(MAX_NNZ_WORDS);
    std::vector<float16> x_packed(MAX_COL_WORDS);
    std::vector<float16> y_packed(MAX_ROW_WORDS);

    for (int i = 0; i < nnz; ++i) {
        A_values_packed[i / PACK_SIZE][i % PACK_SIZE] = raw_values[i];
        A_row_idx_packed[i / PACK_SIZE][i % PACK_SIZE] = raw_col_idx[i];
    }
    for (int i = 0; i < num_cols; ++i) {
        x_packed[i / PACK_SIZE][i % PACK_SIZE] = x[i];
    }

    spmv_csc_sw(num_rows, num_cols, raw_col_idx.data(), raw_row_ptr.data(), raw_values.data(), x.data(), y_sw.data());

    spmv_csc(num_rows, num_cols, nnz, 
             A_row_idx_packed.data(), 
             raw_row_ptr.data(), 
             A_values_packed.data(), 
             x_packed.data(), 
             y_packed.data());

    for (int i = 0; i < num_rows; ++i) {
        y_hw[i] = y_packed[i / PACK_SIZE][i % PACK_SIZE];
    }

    int errors = 0;
    for (int i = 0; i < num_rows; i++) {
        if (std::abs(y_sw[i] - y_hw[i]) > 0.1f) {
            if (errors < 5) std::cout << "Row " << i << " Mismatch: SW=" << y_sw[i] << " HW=" << y_hw[i] << std::endl;
            errors++;
        }
    }

    if (errors == 0) std::cout << "PASSED!" << std::endl;
    else std::cout << "FAILED with " << errors << " errors." << std::endl;

    return (errors > 0);
}