// #ifndef SPMV_H
// #define SPMV_H

// // Define the data type used in the kernel
// typedef float DTYPE;

// // ---------------------------------------------------------
// // Tile Dimensions and Constraints
// // ---------------------------------------------------------
// // NUM_ROWS corresponds to the number of rows in a single tile (TILE_ROWS)
// #define NUM_ROWS 1024

// // VEC_SIZE corresponds to the number of columns in a single tile (TILE_COLS)
// // This is used to size the input vector 'x' and output vector 'y'
// #define VEC_SIZE 1024

// // NNZ is the statically allocated number of non-zeros per tile.
// // Since the reference HLS code uses a fixed loop (for i = 0; i < NNZ),
// // this must be large enough to hold the densest tile, plus padding.
// #define NNZ 15000

// // Pipeline Initiation Interval (used by the reference kernel logic)
// #define II 9

// // ---------------------------------------------------------
// // Top-Level Function Prototype
// // ---------------------------------------------------------
// void spmv_csc(int rowPtr[NUM_ROWS + 1], 
//           int cols[NNZ], 
//           DTYPE values[NNZ], 
//           DTYPE y[VEC_SIZE], 
//           DTYPE x[VEC_SIZE]);

// #endif // SPMV_H