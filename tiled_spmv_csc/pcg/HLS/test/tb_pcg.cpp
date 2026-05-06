#include <cmath>
#include <iomanip>
#include <iostream>
#include <random>
#include <vector>

#include "pcg.h"

// Test configuration
#define GLOBAL_ROWS 4096
#define GLOBAL_COLS 4096

// Tile sizes are the kernel maxima
#define TILE_ROWS MAX_ROWS
#define TILE_COLS MAX_COLS

// Top-level pcg() interfaces are sized for up to MAX_SIZE x MAX_SIZE with 1024x1024 tiles
#define MAX_TILE_ROWS (MAX_SIZE / TILE_ROWS)
#define MAX_TILE_COLS (MAX_SIZE / TILE_COLS)
#define MAX_TILES (MAX_TILE_ROWS * MAX_TILE_COLS)
#define MAX_TILED_COLPTR_INTS (MAX_TILES * (TILE_COLS + 1))
#define MAX_GLOBAL_Y_WORDS CEIL_DIV(MAX_SIZE, PACK_SIZE)

static void spmv_sw_csc(const std::vector<int> &col_ptr,
                        const std::vector<int> &row_idx,
                        const std::vector<float> &values,
                        const std::vector<float> &x,
                        std::vector<float> &y_ref)
{
    y_ref.assign(GLOBAL_ROWS, 0.0f);
    for (int c = 0; c < GLOBAL_COLS; ++c)
    {
        const float xc = x[c];
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx)
        {
            y_ref[row_idx[idx]] += values[idx] * xc;
        }
    }
}

int main()
{
    std::cout << "Running PCG(top) tiled CSC testbench..." << std::endl;
    std::cout << "Global Size: " << GLOBAL_ROWS << "x" << GLOBAL_COLS << std::endl;
    std::cout << "Tile Size:   " << TILE_ROWS << "x" << TILE_COLS << std::endl;

    static constexpr float DENSITY = 0.005f;
    std::cout << "Density:     " << DENSITY << std::endl;

    const int num_row_tiles = (GLOBAL_ROWS + TILE_ROWS - 1) / TILE_ROWS;
    const int num_col_tiles = (GLOBAL_COLS + TILE_COLS - 1) / TILE_COLS;
    const int num_tiles = num_row_tiles * num_col_tiles;

    if (GLOBAL_ROWS % TILE_ROWS != 0 || GLOBAL_COLS % TILE_COLS != 0)
    {
        std::cout << "ERROR: This test assumes GLOBAL dims are multiples of tile dims." << std::endl;
        return 1;
    }

    std::default_random_engine generator(123);
    std::uniform_real_distribution<float> value_dist(1.0f, 10.0f);
    std::uniform_real_distribution<float> prob_dist(0.0f, 1.0f);

    // 1) Global x vector
    // NOTE: In cosim, wrappers copy arrays based on the interface `depth`,
    // so allocate full MAX_SIZE even though we only use GLOBAL_COLS.
    std::vector<float> x_global(MAX_SIZE, 0.0f);
    for (int i = 0; i < GLOBAL_COLS; ++i)
    {
        x_global[i] = value_dist(generator);
    }

    // 2) Generate global matrix directly in CSC.
    //    Global storage: (col_ptr, row_idx, values)
    std::vector<int> g_col_ptr(GLOBAL_COLS + 1, 0);
    std::vector<int> g_row_idx;
    std::vector<float> g_values;

    std::cout << "Generating sparse matrix (global CSC)..." << std::endl;
    int nnz_total = 0;
    for (int c = 0; c < GLOBAL_COLS; ++c)
    {
        g_col_ptr[c] = nnz_total;

        for (int r = 0; r < GLOBAL_ROWS; ++r)
        {
            if (prob_dist(generator) < DENSITY)
            {
                const float v = value_dist(generator);
                g_row_idx.push_back(r);
                g_values.push_back(v);
                ++nnz_total;
            }
        }
    }
    g_col_ptr[GLOBAL_COLS] = nnz_total;
    std::cout << "Total Global NNZ: " << nnz_total << std::endl;

    // 3) Slice global CSC into per-tile local CSC (each tile is TILE_ROWS x TILE_COLS).
    struct TileCscCols
    {
        std::vector<std::vector<int>> rows_by_col;
        std::vector<std::vector<float>> vals_by_col;
        explicit TileCscCols(int cols) : rows_by_col(cols), vals_by_col(cols) {}
    };

    std::vector<TileCscCols> tiles;
    tiles.reserve(num_tiles);
    for (int t = 0; t < num_tiles; ++t)
    {
        tiles.emplace_back(TILE_COLS);
    }

    std::cout << "Slicing global CSC into tile-local CSC..." << std::endl;
    for (int c = 0; c < GLOBAL_COLS; ++c)
    {
        const int tc = c / TILE_COLS;
        const int local_c = c % TILE_COLS;
        for (int idx = g_col_ptr[c]; idx < g_col_ptr[c + 1]; ++idx)
        {
            const int r = g_row_idx[idx];
            const float v = g_values[idx];

            const int tr = r / TILE_ROWS;
            const int local_r = r % TILE_ROWS;
            const int tile_idx = tr * num_col_tiles + tc;
            tiles[tile_idx].rows_by_col[local_c].push_back(local_r);
            tiles[tile_idx].vals_by_col[local_c].push_back(v);
        }
    }

    // 4) Software reference (from global CSC)
    std::vector<float> y_sw(GLOBAL_ROWS, 0.0f);
    std::cout << "Running software reference (CSC)..." << std::endl;
    spmv_sw_csc(g_col_ptr, g_row_idx, g_values, x_global, y_sw);

    // 5) Build tiled CSC buffers expected by pcg()
    std::cout << "Building tiled CSC buffers..." << std::endl;

    // NOTE: Allocate full interface depths to satisfy cosim wrappers.
    std::vector<int> tile_nnz_counts(MAX_TILES, 0);
    std::vector<int> tile_nnz_offsets(MAX_TILES, 0); // offsets in PACKED WORDS (int16/float16 words)
    std::vector<int> tile_col_offsets(MAX_TILES, 0); // offsets in INTs for A_col_ptr_tiled

    std::vector<int> A_col_ptr_tiled(MAX_TILED_COLPTR_INTS, 0);

    std::vector<int16> A_row_idx_tiled(MAX_NNZ_WORDS);
    std::vector<float16> A_values_tiled(MAX_NNZ_WORDS);

    int nnz_word_cursor = 0;
    // Fixed col_ptr slot per tile: tile_col_offsets[tile_idx] = tile_idx*(TILE_COLS+1)
    for (int tile_idx = 0; tile_idx < num_tiles; ++tile_idx)
    {
        tile_col_offsets[tile_idx] = tile_idx * (TILE_COLS + 1);
    }

    for (int tr = 0; tr < num_row_tiles; ++tr)
    {
        for (int tc = 0; tc < num_col_tiles; ++tc)
        {
            const int tile_idx = tr * num_col_tiles + tc;

            // Build tile-local CSC col_ptr from already-collected per-column lists
            std::vector<int> col_ptr(TILE_COLS + 1, 0);
            int tile_nnz = 0;
            for (int c = 0; c < TILE_COLS; ++c)
            {
                tile_nnz += (int)tiles[tile_idx].rows_by_col[c].size();
                col_ptr[c + 1] = tile_nnz;
            }

            tile_nnz_counts[tile_idx] = tile_nnz;
            tile_nnz_offsets[tile_idx] = nnz_word_cursor;
            // Write col_ptr into its fixed slot (tile-local; starts at 0 and ends at tile_nnz)
            const int base = tile_col_offsets[tile_idx];
            for (int i = 0; i < (int)col_ptr.size(); ++i)
            {
                A_col_ptr_tiled[base + i] = col_ptr[i];
            }

            // Append packed NNZ words for this tile
            // Flatten (by increasing local column) and pack
            std::vector<int> rows;
            std::vector<float> vals;
            rows.reserve(tile_nnz);
            vals.reserve(tile_nnz);
            for (int c = 0; c < TILE_COLS; ++c)
            {
                const auto &rlist = tiles[tile_idx].rows_by_col[c];
                const auto &vlist = tiles[tile_idx].vals_by_col[c];
                for (int k = 0; k < (int)rlist.size(); ++k)
                {
                    rows.push_back(rlist[k]);
                    vals.push_back(vlist[k]);
                }
            }

            const int words = CEIL_DIV(tile_nnz, PACK_SIZE);
            for (int w = 0; w < words; ++w)
            {
                int16 row_word;
                float16 val_word;

                for (int lane = 0; lane < PACK_SIZE; ++lane)
                {
                    const int idx = w * PACK_SIZE + lane;
                    if (idx < tile_nnz)
                    {
                        row_word[lane] = rows[idx];
                        val_word[lane] = vals[idx];
                    }
                    else
                    {
                        row_word[lane] = 0;
                        val_word[lane] = 0.0f;
                    }
                }

                if (nnz_word_cursor + w >= MAX_NNZ_WORDS)
                {
                    std::cout << "ERROR: Packed NNZ buffer overflow (MAX_NNZ_WORDS)." << std::endl;
                    return 1;
                }
                A_row_idx_tiled[nnz_word_cursor + w] = row_word;
                A_values_tiled[nnz_word_cursor + w] = val_word;
            }

            nnz_word_cursor += words;
        }
    }

    // 6) Call the top-level accelerator once
    std::cout << "Calling pcg() accelerator..." << std::endl;
    // NOTE: Allocate full interface depth to satisfy cosim wrappers.
    std::vector<float16> y_packed(MAX_GLOBAL_Y_WORDS);
    for (int w = 0; w < (int)y_packed.size(); ++w)
    {
        for (int lane = 0; lane < PACK_SIZE; ++lane)
        {
            y_packed[w][lane] = 0.0f;
        }
    }

    pcg(GLOBAL_ROWS,
        GLOBAL_COLS,
        num_row_tiles,
        num_col_tiles,
        tile_nnz_counts.data(),
        tile_nnz_offsets.data(),
        tile_col_offsets.data(),
        A_row_idx_tiled.data(),
        A_col_ptr_tiled.data(),
        A_values_tiled.data(),
        x_global.data(),
        y_packed.data());

    // 7) Unpack and verify
    std::vector<float> y_hw(GLOBAL_ROWS, 0.0f);
    for (int tr = 0; tr < num_row_tiles; ++tr)
    {
        for (int i = 0; i < TILE_ROWS; ++i)
        {
            const int gr = tr * TILE_ROWS + i;
            const int word = tr * MAX_ROW_WORDS + (i / PACK_SIZE);
            const int lane = i % PACK_SIZE;
            y_hw[gr] = y_packed[word][lane];
        }
    }

    std::cout << "\nResult Vector (y) sample:" << std::endl;
    std::cout << "Row  | SW Ref       | HW Accel" << std::endl;
    std::cout << "----------------------------------" << std::endl;
    int sample_indices[] = {0, 1, 1024, 1025, 2048, 3072, 4095};
    for (int i : sample_indices)
    {
        std::cout << std::setw(4) << i << " | " << std::setw(10) << y_sw[i] << " | " << std::setw(10) << y_hw[i]
                  << std::endl;
    }

    bool pass = true;
    int error_count = 0;
    const float RELATIVE_TOLERANCE = 1e-3f;

    for (int i = 0; i < GLOBAL_ROWS; ++i)
    {
        const float expected = y_sw[i];
        const float actual = y_hw[i];
        const float diff = std::fabs(actual - expected);
        const float rel_error = diff / (std::fabs(expected) + 1e-8f);

        if (rel_error > RELATIVE_TOLERANCE && diff > 1e-4f)
        {
            if (error_count < 10)
            {
                std::cout << "Mismatch at row " << i << ": HW = " << actual << ", SW = " << expected
                          << " (diff=" << diff << ", rel=" << rel_error << ")" << std::endl;
            }
            pass = false;
            ++error_count;
        }
    }

    if (pass)
    {
        std::cout << ">>> SUCCESS: pcg() tiled SpMV matches software reference. <<<" << std::endl;
        return 0;
    }
    std::cout << ">>> FAILED with " << error_count << " mismatches. <<<" << std::endl;
    return 1;
}