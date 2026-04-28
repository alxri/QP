#ifndef DOT_PROD_H
#define DOT_PROD_H

#include "hls_stream.h"
#include "hls_vector.h"

#define PACK_SIZE 16

// 512 bit packed types (16 floats per packet)
typedef hls::vector<float, PACK_SIZE> float16;

void dot_prod(float16 *x, float16 *y, int size, float *result);


#endif // DOT_PROD_H