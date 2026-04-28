#ifndef AXPY_H
#define AXPY_H

#include "hls_stream.h"
#include "hls_vector.h"

void axpy(float a, float *x, float *y, int size, float *result);


#endif // AXPY_H