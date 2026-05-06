#ifndef PCG_H
#define PCG_H

#include "spmv_csc.h"


#ifndef MAX_COLS
#define MAX_COLS 1024
#endif

#ifndef MAX_ROWS
#define MAX_ROWS 1024
#endif

#ifndef MAX_SIZE
#define MAX_SIZE 65536
#endif

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
	float16 *y_global);

#endif // PCG_H