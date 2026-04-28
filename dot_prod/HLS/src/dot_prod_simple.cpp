#include "dot_prod.h"

void dot_prod(float *x, float *y, int size, float *result)
{
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = gmem0 depth = 1024
#pragma HLS INTERFACE m_axi port = y offset = slave bundle = gmem1 depth = 1024
#pragma HLS INTERFACE m_axi port = result offset = slave bundle = gmem2 depth = 1

#pragma HLS INTERFACE s_axilite port = x bundle = control
#pragma HLS INTERFACE s_axilite port = y bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = result bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

    // 4 accumulator as the FP add is 3 cycles latency, so we can interleave 4 partial sums to achieve II=1.
    float acc0 = 0.0f;
    float acc1 = 0.0f;
    float acc2 = 0.0f;
    float acc3 = 0.0f;

    for (int i = 0; i < size; i++) {
#pragma HLS PIPELINE II = 1
        const float prod = x[i] * y[i];

        // Add into the oldest partial sum, then rotate.
        const float updated = acc0 + prod;
        acc0 = acc1;
        acc1 = acc2;
        acc2 = acc3;
        acc3 = updated;
    }

    *result = (acc0 + acc1) + (acc2 + acc3);

}

