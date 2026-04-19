#include "mv.h"
#include <cstdio>
#include <cstdlib>
#include <cmath>

#define N 4   // small test

int main() {
    // A = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
    // x = [1,1,1,1]
    // y = [10, 26, 42, 58]
    float A[N*N], x[N], y[N];
    float ref[N] = {10.f, 26.f, 42.f, 58.f};

    for (int i = 0; i < N; i++) {
        x[i] = 1.f;
        for (int j = 0; j < N; j++)
            A[i*N+j] = (float)(i*N + j + 1);
    }

    mv(A, x, y, N, N);

    bool pass = true;
    for (int i = 0; i < N; i++) {
        float err = fabsf(y[i] - ref[i]);
        printf("y[%d] = %.1f  ref = %.1f  %s\n",
               i, y[i], ref[i], err < 1e-3f ? "OK" : "FAIL");
        if (err >= 1e-3f) pass = false;
    }
    return pass ? 0 : 1;
}