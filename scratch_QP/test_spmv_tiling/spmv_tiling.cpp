#include <vector>
#include <iostream>
#include <algorithm>
#include <random>
#include <iomanip>

const int TILE_SIZE = 1024;

struct CSCMatrix {
    int rows, cols, nnz;
    std::vector<int> col_ptr;
    std::vector<int> row_idx;
    std::vector<float> values;

    CSCMatrix(int r = 0, int c = 0) : rows(r), cols(c), nnz(0) {
        col_ptr.assign(c + 1, 0);
    }
};

/**
 * Partitions a global CSC matrix into a 2D grid of CSC tiles.
 * Handles non-perfect divisions by creating smaller tiles at the edges.
 */
std::vector<std::vector<CSCMatrix>> partition_csc(const CSCMatrix& global) {
    // 1. Calculate grid dimensions (Ceiling Division)
    int grid_rows = (global.rows + TILE_SIZE - 1) / TILE_SIZE;
    int grid_cols = (global.cols + TILE_SIZE - 1) / TILE_SIZE;

    // Initialize the grid of tiles
    std::vector<std::vector<CSCMatrix>> tiles(grid_rows, std::vector<CSCMatrix>(grid_cols));
    
    for (int r = 0; r < grid_rows; ++r) {
        for (int c = 0; c < grid_cols; ++c) {
            // Determine tile dimensions (handling the edges)
            int t_rows = std::min(TILE_SIZE, global.rows - r * TILE_SIZE);
            int t_cols = std::min(TILE_SIZE, global.cols - c * TILE_SIZE);
            tiles[r][c] = CSCMatrix(t_rows, t_cols);
        }
    }

    // 2. First Pass: Count NNZs per tile per column (to build col_ptrs)
    for (int c = 0; c < global.cols; ++c) {
        int tile_c = c / TILE_SIZE;
        int local_c = c % TILE_SIZE;

        for (int i = global.col_ptr[c]; i < global.col_ptr[c + 1]; ++i) {
            int r = global.row_idx[i];
            int tile_r = r / TILE_SIZE;
            
            // Increment the specific column pointer in the target tile
            tiles[tile_r][tile_c].col_ptr[local_c + 1]++;
        }
    }

    // 3. Finalize Col Pointers (Prefix Sum for each tile)
    for (int r = 0; r < grid_rows; ++r) {
        for (int c = 0; c < grid_cols; ++c) {
            CSCMatrix& t = tiles[r][c];
            int current_ptr = 0;
            for (int j = 0; j <= t.cols; ++j) {
                int count = t.col_ptr[j];
                t.col_ptr[j] = current_ptr;
                current_ptr += count;
            }
            // Pre-allocate memory for speed
            t.nnz = current_ptr;
            t.row_idx.resize(t.nnz);
            t.values.resize(t.nnz);
        }
    }

    // 4. Second Pass: Distribute values and row indices
    // We use a temporary offset array for each tile to know where to insert
    std::vector<std::vector<std::vector<int>>> current_offsets(
        grid_rows, std::vector<std::vector<int>>(grid_cols)
    );
    for(int r=0; r<grid_rows; ++r)
        for(int c=0; c<grid_cols; ++c)
            current_offsets[r][c] = tiles[r][c].col_ptr;

    for (int c = 0; c < global.cols; ++c) {
        int tile_c = c / TILE_SIZE;
        int local_c = c % TILE_SIZE;

        for (int i = global.col_ptr[c]; i < global.col_ptr[c + 1]; ++i) {
            int r = global.row_idx[i];
            int tile_r = r / TILE_SIZE;
            int local_r = r % TILE_SIZE;

            CSCMatrix& t = tiles[tile_r][tile_c];
            int dest = current_offsets[tile_r][tile_c][local_c]++;
            
            t.row_idx[dest] = local_r; // Localized coordinate
            t.values[dest] = global.values[i];
        }
    }

    return tiles;
}



int main() {
    // 1. Setup Matrix Dimensions and Sparsity
    int rows = 4096;
    int cols = 4096;
    float sparsity = 0.1f; // 10%

    std::cout << "Initializing " << rows << "x" << cols << " matrix..." << std::endl;

    // 2. Generate Random Global CSC Matrix
    // We'll simulate this by randomly deciding how many NNZ per column
    CSCMatrix global(rows, cols);
    std::default_random_engine gen(42); // Fixed seed for reproducibility
    std::uniform_real_distribution<float> dist(0.0, 1.0);
    std::uniform_int_distribution<int> row_dist(0, rows - 1);

    int total_nnz = 0;
    global.col_ptr[0] = 0;

    for (int c = 0; c < cols; ++c) {
        for (int r = 0; r < rows; ++r) {
            if (dist(gen) < sparsity) {
                global.row_idx.push_back(r);
                global.values.push_back(dist(gen) * 10.0f); // Random value 0-10
                total_nnz++;
            }
        }
        global.col_ptr[c + 1] = total_nnz;
    }
    global.nnz = total_nnz;

    std::cout << "Global Matrix generated. Total NNZ: " << global.nnz << std::endl;
    std::cout << "Actual Sparsity: " << (float)global.nnz / (rows * cols) * 100 << "%" << std::endl;

    // 3. Call the Partitioning Function
    std::cout << "\nPartitioning into " << TILE_SIZE << "x" << TILE_SIZE << " tiles..." << std::endl;
    auto tile_grid = partition_csc(global);

    // 4. Verify the Results
    int grid_rows = tile_grid.size();
    int grid_cols = tile_grid[0].size();
    int check_total_nnz = 0;

    std::cout << "Grid Dimensions: " << grid_rows << "x" << grid_cols << " tiles." << std::endl;
    std::cout << "--------------------------------------------------" << std::endl;
    std::cout << "Tile Stats (NNZ count per tile):" << std::endl;

    for (int r = 0; r < grid_rows; ++r) {
        for (int c = 0; c < grid_cols; ++c) {
            std::cout << std::setw(6) << tile_grid[r][c].nnz << " ";
            check_total_nnz += tile_grid[r][c].nnz;
        }
        std::cout << std::endl;
    }
    std::cout << "--------------------------------------------------" << std::endl;

    // 5. Final Integrity Check
    if (check_total_nnz == global.nnz) {
        std::cout << "SUCCESS: All " << check_total_nnz << " non-zeros accounted for." << std::endl;
    } else {
        std::cout << "ERROR: NNZ mismatch! Global: " << global.nnz << ", Tiles: " << check_total_nnz << std::endl;
    }

    // Example of localized indexing verification
    if (tile_grid[0][0].nnz > 0) {
        std::cout << "\nSample from Tile(0,0):" << std::endl;
        std::cout << "Local Row Index: " << tile_grid[0][0].row_idx[0] << std::endl;
        std::cout << "Value: " << tile_grid[0][0].values[0] << std::endl;
    }

    return 0;
}
