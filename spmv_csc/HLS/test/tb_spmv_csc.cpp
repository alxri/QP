#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <iomanip>
#include "spmv_csc.h"

// Define global dimensions and tile sizes
#define GLOBAL_ROWS 1024
#define GLOBAL_COLS 1024
#define TILE_ROWS 1024
#define TILE_COLS 1024

// Simple COO tuple for easy global matrix generation and slicing
struct CooTuple {
    int r, c;
    float v;
};

// Global SW Reference
void spmv_sw_global(const std::vector<CooTuple>& global_coo, const std::vector<float>& x, std::vector<float>& y_ref) {
    for (int i = 0; i < GLOBAL_ROWS; i++) y_ref[i] = 0.0f;
    for (const auto& t : global_coo) {
        y_ref[t.r] += t.v * x[t.c];
    }
}

int main() {
    std::cout << "Running Tiled SPMV (CSC) testbench..." << std::endl;
    std::cout << "Global Size: " << GLOBAL_ROWS << "x" << GLOBAL_COLS << std::endl;
    std::cout << "Tile Size:   " << TILE_ROWS << "x" << TILE_COLS << std::endl;

    // Density for ~10 nnz per column
    float density = 10.0f / GLOBAL_ROWS; 

    std::vector<float> x_global(GLOBAL_COLS, 0.0f);
    std::vector<CooTuple> global_coo;

    std::default_random_engine generator(123); 
    std::uniform_real_distribution<float> value_dist(1.0f, 10.0f);
    std::uniform_real_distribution<float> prob_dist(0.0f, 1.0f);

    std::cout << "Generating matrix..." << std::endl;

    // 1. Generate Global Input Vector 'x'
    for (int i = 0; i < GLOBAL_COLS; ++i) {
        x_global[i] = value_dist(generator);
    }

    // 2. Generate Global Sparse Matrix (~10 nnz/col)
    for (int c = 0; c < GLOBAL_COLS; ++c) {
        for (int r = 0; r < GLOBAL_ROWS; ++r) {
            if (prob_dist(generator) < density) {
                global_coo.push_back({r, c, value_dist(generator)});
            }
        }
    }

    std::cout << "Total Global NNZ: " << global_coo.size() << std::endl;

    // 3. Output vectors
    std::vector<float> y_hw_global(GLOBAL_ROWS, 0.0f);
    std::vector<float> y_sw_global(GLOBAL_ROWS, 0.0f);

    // Compute Global SW Reference
    std::cout << "Running Global Software Reference..." << std::endl;
    spmv_sw_global(global_coo, x_global, y_sw_global);

    // 4. Hardware Tiling Execution
    std::cout << "Running Hardware Accelerator (Tiled Execution)..." << std::endl;
    
    int num_row_tiles = GLOBAL_ROWS / TILE_ROWS;
    int num_col_tiles = GLOBAL_COLS / TILE_COLS;

    // ROW-MAJOR TILE SCHEDULING
    for (int tr = 0; tr < num_row_tiles; ++tr) {
        for (int tc = 0; tc < num_col_tiles; ++tc) {
            
            // --- A. Extract Local Tile Data ---
            std::vector<CooTuple> tile_coo;
            for (const auto& t : global_coo) {
                if (t.r >= tr * TILE_ROWS && t.r < (tr + 1) * TILE_ROWS &&
                    t.c >= tc * TILE_COLS && t.c < (tc + 1) * TILE_COLS) {
                    // Normalize indices for the local 1024x1024 tile
                    tile_coo.push_back({t.r % TILE_ROWS, t.c % TILE_COLS, t.v});
                }
            }

            // --- B. Convert Local Tile to CSC ---
            std::vector<float> t_vals;
            std::vector<int>   t_row_idx;
            std::vector<int>   t_col_ptr(TILE_COLS + 1, 0);

            int current_nnz = 0;
            for (int c = 0; c < TILE_COLS; ++c) {
                for (const auto& t : tile_coo) {
                    if (t.c == c) {
                        t_vals.push_back(t.v);
                        t_row_idx.push_back(t.r);
                        current_nnz++;
                    }
                }
                t_col_ptr[c + 1] = current_nnz;
            }
            int tile_nnz = current_nnz;

            // --- C. Extract Local X Slice ---
            std::vector<float> x_slice(TILE_COLS, 0.0f);
            for(int c = 0; c < TILE_COLS; c++) {
                x_slice[c] = x_global[tc * TILE_COLS + c];
            }

            // --- D. Pack Data for HLS ---
            std::vector<float16> A_values_packed(MAX_NNZ_WORDS);
            std::vector<int16>   A_row_idx_packed(MAX_NNZ_WORDS);
            std::vector<float16> y_packed(MAX_ROW_WORDS);

            // Init packed arrays to zero
            for (int w = 0; w < MAX_NNZ_WORDS; ++w) {
                for (int lane = 0; lane < PACK_SIZE; ++lane) {
                    A_values_packed[w][lane] = 0.0f;
                    A_row_idx_packed[w][lane] = 0;
                }
            }
            for (int w = 0; w < MAX_ROW_WORDS; ++w) {
                for (int lane = 0; lane < PACK_SIZE; ++lane) y_packed[w][lane] = 0.0f;
            }

            // Pack the NNZ data
            for (int i = 0; i < tile_nnz; ++i) {
                const int w    = i / PACK_SIZE;
                const int lane = i % PACK_SIZE;
                A_values_packed[w][lane]  = t_vals[i];
                A_row_idx_packed[w][lane] = t_row_idx[i];
            }

            // --- E. Configure Hardware Flags ---
            bool clear_y = (tc == 0);                   // Reset accumulator at the start of a row
            bool write_y = (tc == num_col_tiles - 1);   // Write back at the end of a row

            std::cout << "  -> Calling Tile (" << tr << ", " << tc << ") | NNZ: " << tile_nnz 
                      << " | clear_y: " << clear_y << " | write_y: " << write_y << std::endl;

            // --- F. Call HLS Kernel ---
            spmv_csc(TILE_ROWS, TILE_COLS, tile_nnz, 
                     A_row_idx_packed.data(), 
                     t_col_ptr.data(), 
                     A_values_packed.data(), 
                     x_slice.data(), 
                     y_packed.data(), 
                     clear_y, 
                     write_y);

            // --- G. Extract Result (If Row is Finished) ---
            if (write_y) {
                for (int i = 0; i < TILE_ROWS; ++i) {
                    const int w    = i / PACK_SIZE;
                    const int lane = i % PACK_SIZE;
                    // Map local y to the correct offset in the global y
                    y_hw_global[tr * TILE_ROWS + i] = y_packed[w][lane];
                }
            }
        }
    }

    // 5. Verify results
    std::cout << "\nResult Vector (y) [Showing sample from each block-row]:" << std::endl;
    std::cout << "Row  | SW Ref       | HW Accel" << std::endl;
    std::cout << "----------------------------------" << std::endl;
    
    // Print a few rows from different tiles to show it worked across boundaries
    int sample_indices[] = {0, 1, 1024, 1025, 2048, 3072, 4095};
    for (int i : sample_indices) {
        std::cout << std::setw(4) << i << " | " 
                  << std::setw(10) << y_sw_global[i] << " | " 
                  << std::setw(10) << y_hw_global[i] << std::endl;
    }
    std::cout << std::endl;

    bool pass = true;
    int error_count = 0;
    const float RELATIVE_TOLERANCE = 0.0005f; 

    for (int i = 0; i < GLOBAL_ROWS; i++) {
        float expected = y_sw_global[i];
        float actual = y_hw_global[i];
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
        std::cout << ">>> SUCCESS: All " << GLOBAL_ROWS << " tiled tests passed! <<<" << std::endl;
    } else {
        std::cout << ">>> FAILED with " << error_count << " mismatches! <<<" << std::endl;
    }

    return 0;
}