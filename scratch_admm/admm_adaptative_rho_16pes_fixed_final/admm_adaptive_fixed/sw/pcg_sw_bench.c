// Enable POSIX clock APIs (needed on some PetaLinux/glibc builds
// to expose CLOCK_MONOTONIC/CLOCK_MONOTONIC_RAW in <time.h>).
#if defined(__linux__) && !defined(_POSIX_C_SOURCE)
#define _POSIX_C_SOURCE 200809L
#endif

#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if defined(__linux__)
#include <sys/time.h>
#include <time.h>
#else
#include "xtime_l.h"
#endif

// ZCU104 MPSoC A53 benchmark: software PCG solve time for
// K = P + sigma*I + A^T * diag(rho) * A
// where A is in CSC with ~1 nnz/column and P is diagonal.
//
// Build (Linux on ZCU104):
//   aarch64-linux-gnu-gcc -O3 -march=armv8-a+simd -ffast-math -std=c11 -o pcg_sw_bench pcg_sw_bench.c -lm
// Run:
//   ./pcg_sw_bench [runs] [seed]
//
// Build (Vitis standalone/bare-metal A53):
//   Add this file to an Application Project and ensure BSP provides xtime_l.h.

#ifndef NUM_ROWS
#define NUM_ROWS 1024
#endif
#ifndef NUM_COLS
#define NUM_COLS 1024
#endif

#define A_NNZ (NUM_COLS) // exactly 1 nnz/column
#define MAX_ITERS (NUM_COLS)

// ---------------- Timing ----------------

static uint64_t now_ns(void)
{
#if defined(__linux__)
    // Linux user-space (monotonic clock preferred; fallback to gettimeofday).
    struct timespec ts;
#if defined(CLOCK_MONOTONIC_RAW)
    if (clock_gettime(CLOCK_MONOTONIC_RAW, &ts) == 0)
        return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
#endif
#if defined(CLOCK_MONOTONIC)
    if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0)
        return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
#endif

    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (uint64_t)tv.tv_sec * 1000000000ULL + (uint64_t)tv.tv_usec * 1000ULL;
#else
    // Xilinx Standalone BSP (Vitis)
    XTime t;
    XTime_GetTime(&t);
    // COUNTS_PER_SECOND is provided by xtime_l.h
    return (uint64_t)((double)t * (1e9 / (double)COUNTS_PER_SECOND));
#endif
}

// ---------------- Deterministic RNG ----------------

static inline uint32_t xorshift32(uint32_t *state)
{
    uint32_t x = *state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    *state = x;
    return x;
}

static inline int rand_int_range(uint32_t *state, int lo, int hi_inclusive)
{
    const uint32_t r = xorshift32(state);
    const uint32_t span = (uint32_t)(hi_inclusive - lo + 1);
    return lo + (int)(r % span);
}

static inline float rand_float_range(uint32_t *state, float lo, float hi)
{
    // Map uint32 -> [0,1)
    const uint32_t r = xorshift32(state);
    const float u = (float)r * (1.0f / 4294967296.0f);
    return lo + (hi - lo) * u;
}

// ---------------- Linear algebra helpers ----------------

static float dot_f32(const float *a, const float *b, int n)
{
    float acc0 = 0.0f, acc1 = 0.0f, acc2 = 0.0f, acc3 = 0.0f;
    int i = 0;
    for (; i + 3 < n; i += 4)
    {
        acc0 += a[i + 0] * b[i + 0];
        acc1 += a[i + 1] * b[i + 1];
        acc2 += a[i + 2] * b[i + 2];
        acc3 += a[i + 3] * b[i + 3];
    }
    for (; i < n; ++i)
    {
        acc0 += a[i] * b[i];
    }
    return (acc0 + acc1) + (acc2 + acc3);
}

static void spmv_csc_f32(int num_rows,
                         int num_cols,
                         const int *col_ptr,
                         const int *row_idx,
                         const float *values,
                         const float *x,
                         float *y)
{
    (void)num_cols;
    memset(y, 0, (size_t)num_rows * sizeof(float));
    for (int c = 0; c < num_cols; ++c)
    {
        const float xc = x[c];
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx)
        {
            y[row_idx[idx]] += values[idx] * xc;
        }
    }
}

static void at_mul_from_csc_f32(int num_rows,
                                int num_cols,
                                const int *col_ptr,
                                const int *row_idx,
                                const float *values,
                                const float *v, // length num_rows
                                float *y)       // length num_cols
{
    for (int c = 0; c < num_cols; ++c)
    {
        float sum = 0.0f;
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx)
        {
            sum += values[idx] * v[row_idx[idx]];
        }
        y[c] = sum;
    }
}

static int pcg_solve_sw(int num_rows,
                        int num_cols,
                        const int *A_col_ptr,
                        const int *A_row_idx,
                        const float *A_values,
                        const float *P_diag,
                        const float *rho,
                        const float *M_inv,
                        const float *b,
                        float sigma,
                        float epsilon_sq,
                        int max_iters,
                        float *x_out,
                        float *rel_res_out)
{
    // Work buffers (static to avoid large stack usage on bare-metal)
    static float r[NUM_COLS];
    static float p[NUM_COLS];
    static float y[NUM_COLS];
    static float Kp[NUM_COLS];

    static float tmp0[NUM_ROWS];
    static float tmp1[NUM_ROWS];
    static float tmp2[NUM_COLS];

    // init x=0, r=b
    for (int i = 0; i < num_cols; ++i)
    {
        x_out[i] = 0.0f;
        r[i] = b[i];
        y[i] = M_inv[i] * r[i];
        p[i] = y[i];
    }

    const float norm_b_sq = dot_f32(b, b, num_cols);
    const float threshold = epsilon_sq * norm_b_sq;

    float rTy = dot_f32(r, y, num_cols);
    float rTr = dot_f32(r, r, num_cols);

    int k = 0;
    for (; k < max_iters && rTr > threshold; ++k)
    {
        // Kp = A^T*(rho*(A*p)) + (P + sigma*I)*p
        spmv_csc_f32(num_rows, num_cols, A_col_ptr, A_row_idx, A_values, p, tmp0); // tmp0 = A*p

        for (int i = 0; i < num_rows; ++i)
        {
            tmp1[i] = rho[i] * tmp0[i]; // tmp1 = rho*(A*p)
        }

        at_mul_from_csc_f32(num_rows, num_cols, A_col_ptr, A_row_idx, A_values, tmp1, tmp2); // tmp2 = A^T*tmp1

        for (int i = 0; i < num_cols; ++i)
        {
            Kp[i] = tmp2[i] + (P_diag[i] + sigma) * p[i];
        }

        const float pTKp = dot_f32(p, Kp, num_cols);
        if (!(pTKp > 0.0f) || !isfinite(pTKp))
        {
            // Breakdown or numerical issue
            break;
        }

        const float alpha = rTy / pTKp;

        for (int i = 0; i < num_cols; ++i)
        {
            x_out[i] += alpha * p[i];
            r[i] -= alpha * Kp[i];
            y[i] = M_inv[i] * r[i];
        }

        const float rTy_next = dot_f32(r, y, num_cols);
        rTr = dot_f32(r, r, num_cols);

        if (!(rTy != 0.0f) || !isfinite(rTy_next))
        {
            break;
        }

        const float beta = rTy_next / rTy;

        for (int i = 0; i < num_cols; ++i)
        {
            p[i] = y[i] + beta * p[i];
        }

        rTy = rTy_next;
    }

    if (rel_res_out)
    {
        const double denom = (double)norm_b_sq + 1e-30;
        const double rr = (double)rTr;
        *rel_res_out = (float)sqrt(rr / denom);
    }

    return k;
}

int main(int argc, char **argv)
{
    const int num_rows = NUM_ROWS;
    const int num_cols = NUM_COLS;
    const int runs = (argc > 1) ? atoi(argv[1]) : 10;
    uint32_t seed = (argc > 2) ? (uint32_t)strtoul(argv[2], NULL, 0) : 123u;

    const float sigma = 1e-1f;
    const float epsilon_sq = 1e-8f;

    static int A_col_ptr[NUM_COLS + 1];
    static int A_row_idx[A_NNZ];
    static float A_values[A_NNZ];

    static float P_diag[NUM_COLS];
    static float rho[NUM_ROWS];
    static float b[NUM_COLS];
    static float M_inv[NUM_COLS];

    static float x[NUM_COLS];

    // --- Generate QP-style inputs ---
    for (int i = 0; i < num_rows; ++i)
        rho[i] = 1.0f;

    for (int c = 0; c < num_cols; ++c)
    {
        A_col_ptr[c] = c;
        A_row_idx[c] = rand_int_range(&seed, 0, num_rows - 1);
        float v = rand_float_range(&seed, -1.0f, 1.0f);
        if (fabsf(v) < 1e-3f)
            v = (v >= 0.0f) ? 1e-3f : -1e-3f;
        A_values[c] = v;
    }
    A_col_ptr[num_cols] = A_NNZ;

    for (int c = 0; c < num_cols; ++c)
    {
        P_diag[c] = rand_float_range(&seed, 1.0f, 2.0f);
        b[c] = rand_float_range(&seed, -1.0f, 1.0f);
    }

    // M_inv[i] = 1 / diag(K)_i
    // diag(K)_i = P_ii + sigma + sum_j rho_j * (A_{j,i})^2
    for (int c = 0; c < num_cols; ++c)
    {
        float diagK = P_diag[c] + sigma;
        for (int idx = A_col_ptr[c]; idx < A_col_ptr[c + 1]; ++idx)
        {
            const int r = A_row_idx[idx];
            const float v = A_values[idx];
            diagK += rho[r] * v * v;
        }
        M_inv[c] = 1.0f / diagK;
    }

    // --- Benchmark ---
    float rel_res = 0.0f;

    // warmup
    (void)pcg_solve_sw(num_rows,
                      num_cols,
                      A_col_ptr,
                      A_row_idx,
                      A_values,
                      P_diag,
                      rho,
                      M_inv,
                      b,
                      sigma,
                      epsilon_sq,
                      MAX_ITERS,
                      x,
                      &rel_res);

    uint64_t t0 = now_ns();
    int iters = 0;
    for (int r = 0; r < runs; ++r)
    {
        iters = pcg_solve_sw(num_rows,
                             num_cols,
                             A_col_ptr,
                             A_row_idx,
                             A_values,
                             P_diag,
                             rho,
                             M_inv,
                             b,
                             sigma,
                             epsilon_sq,
                             MAX_ITERS,
                             x,
                             &rel_res);
    }
    uint64_t t1 = now_ns();

    const double total_ms = (double)(t1 - t0) * 1e-6;
    const double avg_ms = total_ms / (double)runs;

    printf("PCG SW benchmark (A53)\n");
    printf("  N=%dx%d, nnz=%d (~1/col)\n", num_rows, num_cols, A_NNZ);
    printf("  sigma=%.3g, epsilon_sq=%.3g (epsilon=%.3g)\n", sigma, epsilon_sq, sqrt(epsilon_sq));
    printf("  runs=%d, last iters=%d, last rel_res=%.3e\n", runs, iters, rel_res);
    printf("  total=%.3f ms, avg=%.6f ms/solve\n", total_ms, avg_ms);

    // prevent compiler from optimizing away the solve
    volatile float sink = x[0];
    (void)sink;

    return 0;
}
