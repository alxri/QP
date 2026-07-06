#include <iostream>
#include <vector>
#include <cmath>
#include <random>
#include <iomanip>

// Include the reference header
#include "spmv_csc.h" 

// ---------------------------------------------------------
// Global & Tile Dimensions
// ---------------------------------------------------------
#define GLOBAL_ROWS 1024
#define GLOBAL_COLS 1024
#define TILE_ROWS 1024
#define TILE_COLS 1024

// Map reference macros to our tile sizes
#ifndef NUM_ROWS
#define NUM_ROWS TILE_ROWS
#endif

#ifndef VEC_SIZE
#define VEC_SIZE TILE_COLS
#endif

// We must define a max NNZ per tile for the reference code's static loops.
// 1024 * 10 (avg density) = ~10240. We add margin for variance.
#ifndef NNZ
#define NNZ 15000 
#endif

#ifndef II
#define II 9
#endif

typedef float DTYPE;

// Simple COO tuple
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
    std::cout << "Running Tiled SPMV (CSR Reference) testbench..." << std::endl;
    std::cout << "Global Size:   " << GLOBAL_ROWS << "x" << GLOBAL_COLS << std::endl;
    std::cout << "Tile Size:     " << TILE_ROWS << "x" << TILE_COLS << std::endl;
    std::cout << "Max Tile NNZ:  " << NNZ << " (Static padding required)" << std::endl;

    float density = 10.0f / GLOBAL_ROWS; 

    std::vector<float> x_global(GLOBAL_COLS, 0.0f);
    std::vector<CooTuple> global_coo;

    std::default_random_engine generator(123); 
    std::uniform_real_distribution<float> value_dist(1.0f, 10.0f);
    std::uniform_real_distribution<float> prob_dist(0.0f, 1.0f);

    std::cout << "Generating matrix..." << std::endl;

    for (int i = 0; i < GLOBAL_COLS; ++i) {
        x_global[i] = value_dist(generator);
    }

    for (int r = 0; r < GLOBAL_ROWS; ++r) {
        for (int c = 0; c < GLOBAL_COLS; ++c) {
            if (prob_dist(generator) < density) {
                global_coo.push_back({r, c, value_dist(generator)});
            }
        }
    }

    std::cout << "Total Global NNZ: " << global_coo.size() << std::endl;

    std::vector<float> y_hw_global(GLOBAL_ROWS, 0.0f);
    std::vector<float> y_sw_global(GLOBAL_ROWS, 0.0f);

    std::cout << "Running Global Software Reference..." << std::endl;
    spmv_sw_global(global_coo, x_global, y_sw_global);

    std::cout << "Running Hardware Accelerator (Tiled Execution)..." << std::endl;
    
    int num_row_tiles = GLOBAL_ROWS / TILE_ROWS;
    int num_col_tiles = GLOBAL_COLS / TILE_COLS;

    for (int tr = 0; tr < num_row_tiles; ++tr) {
        for (int tc = 0; tc < num_col_tiles; ++tc) {
            
            // --- A. Extract Local Tile Data ---
            std::vector<CooTuple> tile_coo;
            for (const auto& t : global_coo) {
                if (t.r >= tr * TILE_ROWS && t.r < (tr + 1) * TILE_ROWS &&
                    t.c >= tc * TILE_COLS && t.c < (tc + 1) * TILE_COLS) {
                    tile_coo.push_back({t.r % TILE_ROWS, t.c % TILE_COLS, t.v});
                }
            }

            // --- B. Convert Local Tile to CSR (Reference uses CSR) ---
            std::vector<DTYPE> t_vals;
            std::vector<int>   t_cols;
            std::vector<int>   t_row_ptr(TILE_ROWS + 1, 0);

            int current_nnz = 0;
            for (int r = 0; r < TILE_ROWS; ++r) {
                for (const auto& t : tile_coo) {
                    if (t.r == r) {
                        t_vals.push_back(t.v);
                        t_cols.push_back(t.c);
                        current_nnz++;
                    }
                }
                t_row_ptr[r + 1] = current_nnz;
            }

            if (current_nnz > NNZ) {
                std::cerr << "ERROR: Tile NNZ (" << current_nnz << ") exceeds fixed macro NNZ (" << NNZ << ")." << std::endl;
                return -1;
            }

            // --- C. Pad to Fixed NNZ Macro ---
            // The reference kernel unconditionally reads exactly `NNZ` elements. 
            // We pad the arrays with 0s and attribute the dummy elements to the last row.
            for (int i = current_nnz; i < NNZ; ++i) {
                t_vals.push_back(0.0f);
                t_cols.push_back(0);        // Safe dummy column
                t_row_ptr[TILE_ROWS]++;     // Add dummy elements to the last row
            }

            // --- D. Extract Local X Slice ---
            std::vector<DTYPE> x_slice(TILE_COLS, 0.0f);
            for(int c = 0; c < TILE_COLS; c++) {
                x_slice[c] = x_global[tc * TILE_COLS + c];
            }

            std::vector<DTYPE> y_tile_out(TILE_ROWS, 0.0f);

            std::cout << "  -> Calling Tile (" << tr << ", " << tc << ") | Real NNZ: " << current_nnz << " (Padded to " << NNZ << ")" << std::endl;

            // --- E. Call HLS Kernel ---
            spmv_csc(t_row_ptr.data(), t_cols.data(), t_vals.data(), y_tile_out.data(), x_slice.data());

            // --- F. Software Accumulation ---
            // Because the reference kernel doesn't have a partial accumulator (clear_y/write_y),
            // we must add the tile's output to the global result in software.
            for (int i = 0; i < TILE_ROWS; ++i) {
                y_hw_global[tr * TILE_ROWS + i] += y_tile_out[i];
            }
        }
    }

    // Verify results
    std::cout << "\nResult Vector (y) [Showing sample from each block-row]:" << std::endl;
    std::cout << "Row  | SW Ref       | HW Accel" << std::endl;
    std::cout << "----------------------------------" << std::endl;
    
    int sample_indices[] = {0, 1, 1024/2, 1023}; // Adjusted safe indices for 1024 size
    for (int i : sample_indices) {
        if(i < GLOBAL_ROWS) {
            std::cout << std::setw(4) << i << " | " 
                      << std::setw(10) << y_sw_global[i] << " | " 
                      << std::setw(10) << y_hw_global[i] << std::endl;
        }
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