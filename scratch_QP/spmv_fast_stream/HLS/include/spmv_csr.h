#ifndef __SPMV_H__
#define __SPMV_H__

#define MAX_ROWS 1024
#define MAX_COLS 1024

typedef float DTYPE;

void spmv(int rowPtr[NUM_ROWS+1], int columnIndex[NNZ],
		  DTYPE values[NNZ], DTYPE y[SIZE], DTYPE x[SIZE]);


#endif // __SPMV_H__ not defined