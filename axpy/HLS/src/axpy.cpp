#include "axpy.h"

void axpy(float a, float *x, float *y, int size, float *result)
{
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = gmem0 depth = 1024
#pragma HLS INTERFACE m_axi port = y offset = slave bundle = gmem1 depth = 1024
#pragma HLS INTERFACE m_axi port = result offset = slave bundle = gmem2 depth = 1024

#pragma HLS INTERFACE s_axilite port = a bundle = control
#pragma HLS INTERFACE s_axilite port = x bundle = control
#pragma HLS INTERFACE s_axilite port = y bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = result bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control


    for (int i = 0; i < size; i++) {
#pragma HLS PIPELINE
        result[i] = a * x[i] + y[i];
    }
}

