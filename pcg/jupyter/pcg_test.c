#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>
#include <time.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>

// PYNQ libcma prototypes
#ifdef __cplusplus
extern "C" {
#endif
void *cma_alloc(uint32_t len, uint32_t cacheable);
unsigned long cma_get_phy_addr(void *buf);
void cma_free(void *buf);
#ifdef __cplusplus
}
#endif

// =====================================================================
// Configuration & Register Map
// =====================================================================
#define NUM_ROWS 1024
#define NUM_COLS 1024
#define PACK_SIZE 16
#define MAX_NNZ_WORDS ((1024 * 1024) / PACK_SIZE)

// Hardware Map (Split Addresses)
#define PCG_IP_CONTROL_BASE_ADDR   0xA0000000 
#define PCG_IP_CONTROL_R_BASE_ADDR 0xA0010000
#define MAP_SIZE 0x20000UL // 128KB coverage
#define MAP_MASK (MAP_SIZE - 1)

// Control Bundle (Execution & Scalars)
#define ADDR_AP_CTRL         0x00
#define ADDR_NUM_ROWS        0x10
#define ADDR_NUM_COLS        0x18
#define ADDR_A_NNZ           0x20
#define ADDR_P_NNZ           0x28
#define ADDR_SIGMA           0x30
#define ADDR_EPSILON_SQ      0x38

// Control_R Bundle (64-bit Pointers)
#define ADDR_R_A_ROW         0x10
#define ADDR_R_A_COL         0x1c
#define ADDR_R_A_VAL         0x28
#define ADDR_R_AT_ROW        0x34
#define ADDR_R_AT_COL        0x40
#define ADDR_R_AT_VAL        0x4c
#define ADDR_R_P_ROW         0x58
#define ADDR_R_P_COL         0x64
#define ADDR_R_P_VAL         0x70
#define ADDR_R_M_INV         0x7c
#define ADDR_R_B             0x88
#define ADDR_R_RHO           0x94
#define ADDR_R_X_OUT         0xa0

// Hardware Structs (Now correctly sized: 16 * 32-bit = 512 bits)
typedef struct { int32_t data[PACK_SIZE]; } int32_words;
typedef struct { float   data[PACK_SIZE]; } float32_words;

// =====================================================================
// Helper Functions
// =====================================================================
double get_time_ms() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (ts.tv_sec * 1000.0) + (ts.tv_nsec / 1000000.0);
}

void write_reg(void *base, uint32_t offset, uint32_t val) {
    *((volatile uint32_t *)((uint8_t *)base + offset)) = val;
}

uint32_t read_reg(void *base, uint32_t offset) {
    return *((volatile uint32_t *)((uint8_t *)base + offset));
}

void write_64bit_address(void *base, uint32_t offset, uintptr_t address) {
    write_reg(base, offset, (uint32_t)(address & 0xFFFFFFFF));
    write_reg(base, offset + 0x04, (uint32_t)((uint64_t)address >> 32));
}

uint32_t float_to_uint(float f) {
    uint32_t u;
    memcpy(&u, &f, 4);
    return u;
}

float rand_float(float min, float max) {
    return min + ((float)rand() / RAND_MAX) * (max - min);
}

// =====================================================================
// Matrix Helpers
// =====================================================================
void pack_csc_to_words(int nnz, const int *row_idx, const float *values, 
                       int32_words *row_words, float32_words *val_words) 
{
    // Zero-initialize padding
    for(int w = 0; w < MAX_NNZ_WORDS; ++w) {
        for(int lane = 0; lane < PACK_SIZE; ++lane) {
            row_words[w].data[lane] = 0;
            val_words[w].data[lane] = 0.0f;
        }
    }
    // Pack data
    for(int idx = 0; idx < nnz; ++idx) {
        int w = idx / PACK_SIZE;
        int lane = idx % PACK_SIZE;
        row_words[w].data[lane] = row_idx[idx];
        val_words[w].data[lane] = values[idx];
    }
}

void spmv_sw_csc(int rows, int cols, const int *col_ptr, const int *row_idx, 
                 const float *values, const float *x, float *y) 
{
    for(int i = 0; i < rows; i++) y[i] = 0.0f;
    for (int c = 0; c < cols; ++c) {
        float xc = x[c];
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx) {
            y[row_idx[idx]] += values[idx] * xc;
        }
    }
}

void transpose_csc(int rows, int cols, const int *col_ptr, const int *row_idx, const float *values,
                   int *col_ptr_t, int *row_idx_t, float *values_t) 
{
    for(int i = 0; i <= rows; i++) col_ptr_t[i] = 0;
    int *nnz_per_col = (int*)calloc(rows, sizeof(int));
    int nnz = col_ptr[cols];

    for (int idx = 0; idx < nnz; ++idx) nnz_per_col[row_idx[idx]]++;
    for (int c = 0; c < rows; ++c) col_ptr_t[c + 1] = col_ptr_t[c] + nnz_per_col[c];

    int *next = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) next[i] = col_ptr_t[i];

    for (int c = 0; c < cols; ++c) {
        for (int idx = col_ptr[c]; idx < col_ptr[c + 1]; ++idx) {
            int r = row_idx[idx];
            int dst = next[r]++;
            row_idx_t[dst] = c;
            values_t[dst] = values[idx];
        }
    }
    free(nnz_per_col); free(next);
}

// =====================================================================
// Main Logic
// =====================================================================
int main() {
    printf("\n--- Starting PCG ZCU104 PYNQ Hardware Testbench (C/libcma) ---\n");

    srand(42);
    float sigma = 0.1f;
    float epsilon_sq = 1e-8f;

    // 1. Generate CPU Matrices
    printf("Generating A(%dx%d) and P(%dx%d) matrices...\n", NUM_ROWS, NUM_COLS, NUM_COLS, NUM_COLS);
    
    int A_nnz = NUM_COLS;
    int P_nnz = NUM_COLS;

    int *A_col_ptr_cpu   = (int *)malloc((NUM_COLS + 1) * sizeof(int));
    int *A_row_idx_cpu   = (int *)malloc(A_nnz * sizeof(int));
    float *A_values_cpu  = (float *)malloc(A_nnz * sizeof(float));

    int *P_col_ptr_cpu   = (int *)malloc((NUM_COLS + 1) * sizeof(int));
    int *P_row_idx_cpu   = (int *)malloc(P_nnz * sizeof(int));
    float *P_values_cpu  = (float *)malloc(P_nnz * sizeof(float));

    for (int c = 0; c < NUM_COLS; ++c) {
        A_col_ptr_cpu[c] = c;
        A_row_idx_cpu[c] = rand() % NUM_ROWS;
        float v = rand_float(-1.0f, 1.0f);
        if (fabsf(v) < 1e-3f) v = 1e-3f; // Prevent precision washout
        A_values_cpu[c] = v;

        P_col_ptr_cpu[c] = c;
        P_row_idx_cpu[c] = c; // diagonal
        P_values_cpu[c] = rand_float(1.0f, 2.0f);
    }
    A_col_ptr_cpu[NUM_COLS] = A_nnz;
    P_col_ptr_cpu[NUM_COLS] = P_nnz;

    int *AT_col_ptr_cpu  = (int *)malloc((NUM_ROWS + 1) * sizeof(int));
    int *AT_row_idx_cpu  = (int *)malloc(A_nnz * sizeof(int));
    float *AT_values_cpu = (float *)malloc(A_nnz * sizeof(float));
    transpose_csc(NUM_ROWS, NUM_COLS, A_col_ptr_cpu, A_row_idx_cpu, A_values_cpu, 
                  AT_col_ptr_cpu, AT_row_idx_cpu, AT_values_cpu);

    // 2. Allocate CMA (Contiguous Physical Memory, CACHED = 1)
    printf("Allocating Hardware CMA Buffers (Cached)...\n");
    int32_words *A_row_hw  = (int32_words *)cma_alloc(MAX_NNZ_WORDS * sizeof(int32_words), 1);
    float32_words *A_val_hw= (float32_words *)cma_alloc(MAX_NNZ_WORDS * sizeof(float32_words), 1);
    int *A_col_ptr_hw      = (int *)cma_alloc((NUM_COLS + 1) * sizeof(int), 1);

    int32_words *AT_row_hw = (int32_words *)cma_alloc(MAX_NNZ_WORDS * sizeof(int32_words), 1);
    float32_words *AT_val_hw= (float32_words *)cma_alloc(MAX_NNZ_WORDS * sizeof(float32_words), 1);
    int *AT_col_ptr_hw     = (int *)cma_alloc((NUM_ROWS + 1) * sizeof(int), 1);

    int32_words *P_row_hw  = (int32_words *)cma_alloc(MAX_NNZ_WORDS * sizeof(int32_words), 1);
    float32_words *P_val_hw= (float32_words *)cma_alloc(MAX_NNZ_WORDS * sizeof(float32_words), 1);
    int *P_col_ptr_hw      = (int *)cma_alloc((NUM_COLS + 1) * sizeof(int), 1);

    float *b_hw            = (float *)cma_alloc(NUM_COLS * sizeof(float), 1);
    float *rho_hw          = (float *)cma_alloc(NUM_ROWS * sizeof(float), 1);
    float *M_inv_hw        = (float *)cma_alloc(NUM_COLS * sizeof(float), 1);
    float *x_out_hw        = (float *)cma_alloc(NUM_COLS * sizeof(float), 1);

    // 3. Populate CMA Buffers
    memcpy(A_col_ptr_hw, A_col_ptr_cpu, (NUM_COLS + 1) * sizeof(int));
    memcpy(P_col_ptr_hw, P_col_ptr_cpu, (NUM_COLS + 1) * sizeof(int));
    memcpy(AT_col_ptr_hw, AT_col_ptr_cpu, (NUM_ROWS + 1) * sizeof(int));

    for (int i = 0; i < NUM_COLS; ++i) b_hw[i] = rand_float(-1.0f, 1.0f);
    for (int i = 0; i < NUM_ROWS; ++i) rho_hw[i] = 1.0f;
    for (int i = 0; i < NUM_COLS; ++i) x_out_hw[i] = 0.0f;

    for (int c = 0; c < NUM_COLS; ++c) {
        float diagK = P_values_cpu[c] + sigma;
        for (int idx = A_col_ptr_cpu[c]; idx < A_col_ptr_cpu[c + 1]; ++idx) {
            float v = A_values_cpu[idx];
            diagK += rho_hw[A_row_idx_cpu[idx]] * v * v;
        }
        M_inv_hw[c] = 1.0f / diagK;
    }

    pack_csc_to_words(A_nnz, A_row_idx_cpu, A_values_cpu, A_row_hw, A_val_hw);
    pack_csc_to_words(A_nnz, AT_row_idx_cpu, AT_values_cpu, AT_row_hw, AT_val_hw);
    pack_csc_to_words(P_nnz, P_row_idx_cpu, P_values_cpu, P_row_hw, P_val_hw);

    // --- FLUSH CACHE TO DDR ---
    cma_flush_cache(A_row_hw, cma_get_phy_addr(A_row_hw), MAX_NNZ_WORDS * sizeof(int32_words));
    cma_flush_cache(A_val_hw, cma_get_phy_addr(A_val_hw), MAX_NNZ_WORDS * sizeof(float32_words));
    cma_flush_cache(A_col_ptr_hw, cma_get_phy_addr(A_col_ptr_hw), (NUM_COLS + 1) * sizeof(int));

    cma_flush_cache(AT_row_hw, cma_get_phy_addr(AT_row_hw), MAX_NNZ_WORDS * sizeof(int32_words));
    cma_flush_cache(AT_val_hw, cma_get_phy_addr(AT_val_hw), MAX_NNZ_WORDS * sizeof(float32_words));
    cma_flush_cache(AT_col_ptr_hw, cma_get_phy_addr(AT_col_ptr_hw), (NUM_ROWS + 1) * sizeof(int));

    cma_flush_cache(P_row_hw, cma_get_phy_addr(P_row_hw), MAX_NNZ_WORDS * sizeof(int32_words));
    cma_flush_cache(P_val_hw, cma_get_phy_addr(P_val_hw), MAX_NNZ_WORDS * sizeof(float32_words));
    cma_flush_cache(P_col_ptr_hw, cma_get_phy_addr(P_col_ptr_hw), (NUM_COLS + 1) * sizeof(int));

    cma_flush_cache(b_hw, cma_get_phy_addr(b_hw), NUM_COLS * sizeof(float));
    cma_flush_cache(rho_hw, cma_get_phy_addr(rho_hw), NUM_ROWS * sizeof(float));
    cma_flush_cache(M_inv_hw, cma_get_phy_addr(M_inv_hw), NUM_COLS * sizeof(float));
    cma_flush_cache(x_out_hw, cma_get_phy_addr(x_out_hw), NUM_COLS * sizeof(float));


    // 4. Map IP / Write Registers
    printf("Configuring Hardware Registers...\n");
    int mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    void *ip_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, PCG_IP_CONTROL_BASE_ADDR & ~MAP_MASK);
    
    void *control_ip   = ip_base + (PCG_IP_CONTROL_BASE_ADDR & MAP_MASK);
    void *control_r_ip = ip_base + (PCG_IP_CONTROL_R_BASE_ADDR & MAP_MASK);

    // Control Bundle Writes
    write_reg(control_ip, ADDR_NUM_ROWS, NUM_ROWS);
    write_reg(control_ip, ADDR_NUM_COLS, NUM_COLS);
    write_reg(control_ip, ADDR_A_NNZ, A_nnz);
    write_reg(control_ip, ADDR_P_NNZ, P_nnz);
    write_reg(control_ip, ADDR_SIGMA, float_to_uint(sigma));
    write_reg(control_ip, ADDR_EPSILON_SQ, float_to_uint(epsilon_sq));

    // Control_R Bundle Writes
    write_64bit_address(control_r_ip, ADDR_R_A_ROW, cma_get_phy_addr(A_row_hw));
    write_64bit_address(control_r_ip, ADDR_R_A_COL, cma_get_phy_addr(A_col_ptr_hw));
    write_64bit_address(control_r_ip, ADDR_R_A_VAL, cma_get_phy_addr(A_val_hw));
    write_64bit_address(control_r_ip, ADDR_R_AT_ROW, cma_get_phy_addr(AT_row_hw));
    write_64bit_address(control_r_ip, ADDR_R_AT_COL, cma_get_phy_addr(AT_col_ptr_hw));
    write_64bit_address(control_r_ip, ADDR_R_AT_VAL, cma_get_phy_addr(AT_val_hw));
    write_64bit_address(control_r_ip, ADDR_R_P_ROW, cma_get_phy_addr(P_row_hw));
    write_64bit_address(control_r_ip, ADDR_R_P_COL, cma_get_phy_addr(P_col_ptr_hw));
    write_64bit_address(control_r_ip, ADDR_R_P_VAL, cma_get_phy_addr(P_val_hw));
    write_64bit_address(control_r_ip, ADDR_R_M_INV, cma_get_phy_addr(M_inv_hw));
    write_64bit_address(control_r_ip, ADDR_R_B,     cma_get_phy_addr(b_hw));
    write_64bit_address(control_r_ip, ADDR_R_RHO,   cma_get_phy_addr(rho_hw));
    write_64bit_address(control_r_ip, ADDR_R_X_OUT, cma_get_phy_addr(x_out_hw));

    // 5. Execute
    printf("Starting Hardware Accelerator...\n");
    double hw_start = get_time_ms();

    write_reg(control_ip, ADDR_AP_CTRL, 0x01);
    while ((read_reg(control_ip, ADDR_AP_CTRL) & 0x02) == 0); // Polling ap_done

    // --- INVALIDATE CACHE TO READ FRESH DDR RESULTS ---
    cma_invalidate_cache(x_out_hw, cma_get_phy_addr(x_out_hw), NUM_COLS * sizeof(float));

    double hw_end = get_time_ms();
    
    printf("Hardware execution time: %.4f ms\n", hw_end - hw_start);

    // 6. CPU Verification Check
    printf("\nRunning CPU Reference Check...\n");
    float *tmp0 = (float*)calloc(NUM_ROWS, sizeof(float));
    float *tmp1 = (float*)calloc(NUM_ROWS, sizeof(float));
    float *tmp2 = (float*)calloc(NUM_COLS, sizeof(float));
    float *px   = (float*)calloc(NUM_COLS, sizeof(float));

    spmv_sw_csc(NUM_ROWS, NUM_COLS, A_col_ptr_cpu, A_row_idx_cpu, A_values_cpu, x_out_hw, tmp0);
    for (int i = 0; i < NUM_ROWS; ++i) tmp1[i] = rho_hw[i] * tmp0[i];
    spmv_sw_csc(NUM_COLS, NUM_ROWS, AT_col_ptr_cpu, AT_row_idx_cpu, AT_values_cpu, tmp1, tmp2);
    spmv_sw_csc(NUM_COLS, NUM_COLS, P_col_ptr_cpu, P_row_idx_cpu, P_values_cpu, x_out_hw, px);

    double norm_b2 = 0.0, norm_r2 = 0.0;
    for (int i = 0; i < NUM_COLS; ++i) {
        float Kxi = tmp2[i] + px[i] + (sigma * x_out_hw[i]);
        double bi = (double)b_hw[i];
        double ri = (double)Kxi - bi;
        norm_b2 += bi * bi;
        norm_r2 += ri * ri;
    }

    double rel_res = sqrt(norm_r2 / (norm_b2 + 1e-30));
    double target = sqrt(epsilon_sq);

    printf("\n--- Results ---\n");
    printf("||b||^2    = %e\n", norm_b2);
    printf("||Kx-b||^2 = %e\n", norm_r2);
    printf("rel_res    = %e\n", rel_res);

    if (rel_res <= 5.0 * target) {
        printf(">>> SUCCESS: PCG HW residual meets tolerance (~%e)! <<<\n", target);
    } else {
        printf(">>> ERROR: Residual too large (Target ~ %e). <<<\n", target);
    }

    // Cleanup
    munmap(ip_base, MAP_SIZE); close(mem_fd);
    cma_free(A_row_hw); cma_free(A_val_hw); cma_free(A_col_ptr_hw);
    cma_free(AT_row_hw); cma_free(AT_val_hw); cma_free(AT_col_ptr_hw);
    cma_free(P_row_hw); cma_free(P_val_hw); cma_free(P_col_ptr_hw);
    cma_free(b_hw); cma_free(rho_hw); cma_free(M_inv_hw); cma_free(x_out_hw);
    free(A_col_ptr_cpu); free(A_row_idx_cpu); free(A_values_cpu);
    free(AT_col_ptr_cpu); free(AT_row_idx_cpu); free(AT_values_cpu);
    free(P_col_ptr_cpu); free(P_row_idx_cpu); free(P_values_cpu);
    free(tmp0); free(tmp1); free(tmp2); free(px);

    return 0;
}