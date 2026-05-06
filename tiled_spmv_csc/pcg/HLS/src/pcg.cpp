#include "pcg.h"

// Define the maximum number of tiles for a 65536x65536 matrix (64x64 tiles)
#define MAX_TILES 4096 

// Depths for top-level tiled buffers (used by cosim/csim wrappers)
#define MAX_GLOBAL_COLS MAX_SIZE
#define MAX_GLOBAL_Y_WORDS CEIL_DIV(MAX_SIZE, PACK_SIZE)
#define MAX_TILED_COLPTR_INTS (MAX_TILES * MAX_COL_PTR)

void pcg(
    int global_rows,
    int global_cols,
    int num_row_tiles,
    int num_col_tiles,
    const int *tile_nnz_counts,
    const int *tile_nnz_offsets,
    const int *tile_col_offsets,
    const int16 *A_row_idx_tiled,
    const int *A_col_ptr_tiled,
    const float16 *A_values_tiled,
    const float *x_global,
    float16 *y_global
)
{

#pragma HLS INTERFACE m_axi port = x_global offset = slave bundle = gmem0 depth = MAX_GLOBAL_COLS
#pragma HLS INTERFACE m_axi port = tile_nnz_counts offset = slave bundle = gmem1 depth = MAX_TILES
#pragma HLS INTERFACE m_axi port = tile_nnz_offsets offset = slave bundle = gmem2 depth = MAX_TILES
#pragma HLS INTERFACE m_axi port = tile_col_offsets offset = slave bundle = gmem3 depth = MAX_TILES
#pragma HLS INTERFACE m_axi port = A_col_ptr_tiled offset = slave bundle = gmem4 depth = MAX_TILED_COLPTR_INTS
#pragma HLS INTERFACE m_axi port = A_row_idx_tiled offset = slave bundle = gmem5 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = A_values_tiled offset = slave bundle = gmem6 depth = MAX_NNZ_WORDS
#pragma HLS INTERFACE m_axi port = y_global offset = slave bundle = gmem7 depth = MAX_GLOBAL_Y_WORDS

#pragma HLS INTERFACE s_axilite port = global_rows bundle = control
#pragma HLS INTERFACE s_axilite port = global_cols bundle = control
#pragma HLS INTERFACE s_axilite port = num_row_tiles bundle = control
#pragma HLS INTERFACE s_axilite port = num_col_tiles bundle = control
#pragma HLS INTERFACE s_axilite port = tile_nnz_counts bundle = control
#pragma HLS INTERFACE s_axilite port = tile_nnz_offsets bundle = control
#pragma HLS INTERFACE s_axilite port = tile_col_offsets bundle = control
#pragma HLS INTERFACE s_axilite port = A_row_idx_tiled bundle = control
#pragma HLS INTERFACE s_axilite port = A_col_ptr_tiled bundle = control
#pragma HLS INTERFACE s_axilite port = A_values_tiled bundle = control
#pragma HLS INTERFACE s_axilite port = x_global bundle = control
#pragma HLS INTERFACE s_axilite port = y_global bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

    // Process one row-tile at a time so `spmv_csc`'s internal accumulator
    // can accumulate across all column-tiles for that row-tile.
    for (int tile_row = 0; tile_row < num_row_tiles; ++tile_row)
    {
        const int row_base = tile_row * MAX_ROWS;
        const int rows_this_tile = (row_base + MAX_ROWS <= global_rows) ? MAX_ROWS : (global_rows - row_base);

        for (int tile_col = 0; tile_col < num_col_tiles; ++tile_col)
        {
            const int col_base = tile_col * MAX_COLS;
            const int cols_this_tile = (col_base + MAX_COLS <= global_cols) ? MAX_COLS : (global_cols - col_base);

            const int tile_idx = tile_row * num_col_tiles + tile_col;
            const int tile_nnz = tile_nnz_counts[tile_idx];
            const int tile_nnz_offset = tile_nnz_offsets[tile_idx];
            const int tile_col_offset = tile_col_offsets[tile_idx];

            // CSC tile is sized rows_this_tile x cols_this_tile.
            // - A_row_idx must be local (0..rows_this_tile-1)
            // - A_col_ptr has length cols_this_tile+1 (pointed to by tile_col_offset)
            // - x is a slice of the global x starting at col_base
            // - y is the packed slice for this row-tile
            spmv_csc(
                rows_this_tile,
                cols_this_tile,
                tile_nnz,
                A_row_idx_tiled + tile_nnz_offset,
                A_col_ptr_tiled + tile_col_offset,
                A_values_tiled + tile_nnz_offset,
                x_global + col_base,
                y_global + tile_row * MAX_ROW_WORDS,
                /*clear_y=*/(tile_col == 0),
                /*write_y=*/(tile_col == num_col_tiles - 1));
        }
    }

}