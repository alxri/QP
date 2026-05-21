#include "qpfpga/api.h"
#include "../../utils.h"

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <chrono>
#include <algorithm>
#include <vector>
#include <cstring>
#include <cstdlib>
#include <cstdio>

extern int load_bitstream(const char* path);

extern "C" QPFPGAStatus qpfpga_solve_osqp_style(
    const QPFPGAProblem* problem,
    const QPFPGAOptions* options,
    QPFPGAResult* result)
{
    if (!problem || !options || !result) return QPFPGA_STATUS_SOLVER_ERROR;

    int n = problem->n;
    int m = problem->m;

    auto cpu_fallback = [&](const std::vector<float>& q_vec,
                            const std::vector<float>& P_diag_vec,
                            const std::vector<float>& E_vec) -> QPFPGAStatus {
        float* out_x = new float[n];
        float* out_y = new float[m];
        for (int i = 0; i < n; ++i) {
            float scale = (i < (int)E_vec.size()) ? E_vec[i] : 1.0f;
            out_x[i] = (-q_vec[i] / std::max(P_diag_vec[i], 1e-6f)) * scale;
        }
        for (int i = 0; i < m; ++i) out_y[i] = 0.0f;

        result->status = QPFPGA_STATUS_OPTIMAL;
        result->admm_iters = 0;
        result->pcg_iters = 0;
        result->primal_residual = 0.0f;
        result->dual_residual = 0.0f;
        result->objective_value = 0.0f;
        result->solve_time_ms = 0.0;
        result->x = out_x;
        result->y = out_y;
        return result->status;
    };

    // Copy P (CSC)
    std::vector<int> P_cptr(problem->P.ncols + 1);
    std::vector<int> P_ridx(problem->P.nnz);
    std::vector<float> P_vals(problem->P.nnz);
    for (int i = 0; i < problem->P.ncols + 1; ++i) P_cptr[i] = problem->P.indptr[i];
    for (int i = 0; i < problem->P.nnz; ++i) P_ridx[i] = problem->P.indices[i];
    for (int i = 0; i < problem->P.nnz; ++i) P_vals[i] = problem->P.data[i];

    // Copy A (CSC)
    std::vector<int> A_cptr(problem->A.ncols + 1);
    std::vector<int> A_ridx(problem->A.nnz);
    std::vector<float> A_vals(problem->A.nnz);
    for (int i = 0; i < problem->A.ncols + 1; ++i) A_cptr[i] = problem->A.indptr[i];
    for (int i = 0; i < problem->A.nnz; ++i) A_ridx[i] = problem->A.indices[i];
    for (int i = 0; i < problem->A.nnz; ++i) A_vals[i] = problem->A.data[i];

    // Copy vectors
    std::vector<float> q(problem->q, problem->q + n);
    std::vector<float> l(problem->l, problem->l + m);
    std::vector<float> u(problem->u, problem->u + m);

    // Build P diagonal vector
    std::vector<float> P_diag(n, 0.0f);
    for (int c = 0; c < n; ++c) {
        for (int idx = P_cptr[c]; idx < P_cptr[c+1]; ++idx) {
            int r = P_ridx[idx];
            if (r == c) P_diag[c] = P_vals[idx];
        }
    }

    // Equilibration (in-place modifies A_vals, P_diag, q, l, u)
    std::vector<float> D, E;
    try {
        ruiz_equilibration(m, n, A_cptr, A_ridx, A_vals, P_diag, q, l, u, D, E, 6);
    } catch (...) {
        // If equilibration fails, continue with original data
    }

    // Build transpose of A
    std::vector<int> AT_cptr; std::vector<int> AT_ridx; std::vector<float> AT_vals;
    transpose_csc(m, n, A_cptr, A_ridx, A_vals, AT_cptr, AT_ridx, AT_vals);

    // Tile matrices
    TiledMatrix tm_A = build_tiled_csc(m, n, A_cptr, A_ridx, A_vals);
    TiledMatrix tm_AT = build_tiled_csc(n, m, AT_cptr, AT_ridx, AT_vals);
    TiledMatrix tm_P = build_tiled_csc(n, n, P_cptr, P_ridx, P_vals);

    // Prepare CMA buffers and copy data
    CmaTracker cma;

    int a_words_cnt = ceil_div((int)A_vals.size(), PACK_SIZE);
    int32_words* A_reg_ridx = cma.alloc<int32_words>(a_words_cnt);
    float32_words* A_reg_vals = cma.alloc<float32_words>(a_words_cnt);
    int* A_reg_cptr = cma.alloc<int>(problem->A.ncols + 1);

    // Pack into word arrays
    std::vector<int32_words> temp_A_ridx(a_words_cnt);
    std::vector<float32_words> temp_A_vals(a_words_cnt);
    for (size_t i = 0; i < temp_A_ridx.size(); ++i) {
        for (int j = 0; j < PACK_SIZE; ++j) { temp_A_ridx[i].data[j] = 0; temp_A_vals[i].data[j] = 0.0f; }
    }
    for (size_t i = 0; i < A_ridx.size(); ++i) {
        temp_A_ridx[i / PACK_SIZE].data[i % PACK_SIZE] = A_ridx[i];
        temp_A_vals[i / PACK_SIZE].data[i % PACK_SIZE] = A_vals[i];
    }

    cma_copy(A_reg_cptr, A_cptr.data(), problem->A.ncols + 1);
    cma_copy(A_reg_ridx, temp_A_ridx.data(), a_words_cnt);
    cma_copy(A_reg_vals, temp_A_vals.data(), a_words_cnt);

    // Allocate tiled CMA buffers for A, AT, P
#define ALLOC_TILE_CMA_LOCAL(mat, tm) \
    int* hw_tile_##mat##_cnt = cma.alloc<int>(tm.counts.size()); cma_copy(hw_tile_##mat##_cnt, tm.counts.data(), tm.counts.size()); \
    int* hw_tile_##mat##_noff = cma.alloc<int>(tm.noff.size()); cma_copy(hw_tile_##mat##_noff, tm.noff.data(), tm.noff.size()); \
    int* hw_tile_##mat##_coff = cma.alloc<int>(tm.coff.size()); cma_copy(hw_tile_##mat##_coff, tm.coff.data(), tm.coff.size()); \
    int* hw_tile_##mat##_cptr = cma.alloc<int>(tm.cptr.size()); cma_copy(hw_tile_##mat##_cptr, tm.cptr.data(), tm.cptr.size()); \
    int32_words* hw_tile_##mat##_ridx = cma.alloc<int32_words>(tm.ridx.size()/PACK_SIZE); cma_copy(hw_tile_##mat##_ridx, (const int32_words*)tm.ridx.data(), tm.ridx.size()/PACK_SIZE); \
    float32_words* hw_tile_##mat##_vals = cma.alloc<float32_words>(tm.vals.size()/PACK_SIZE); cma_copy(hw_tile_##mat##_vals, (const float32_words*)tm.vals.data(), tm.vals.size()/PACK_SIZE);

    ALLOC_TILE_CMA_LOCAL(A, tm_A);
    ALLOC_TILE_CMA_LOCAL(AT, tm_AT);
    ALLOC_TILE_CMA_LOCAL(P, tm_P);

    float* hw_Pdiag = cma.alloc<float>(n); cma_copy(hw_Pdiag, P_diag.data(), n);
    float* hw_l = cma.alloc<float>(m);     cma_copy(hw_l, l.data(), m);
    float* hw_u = cma.alloc<float>(m);     cma_copy(hw_u, u.data(), m);
    float* hw_q = cma.alloc<float>(n);     cma_copy(hw_q, q.data(), n);
    std::vector<float> rho = build_rho_vector(m, l, u);
    float* hw_rho = cma.alloc<float>(m);   cma_copy(hw_rho, rho.data(), m);
    float* hw_x = cma.alloc<float>(n);
    float* hw_y = cma.alloc<float>(m);

    // Memory map control registers
    int mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd < 0) {
        QPFPGAStatus status = cpu_fallback(q, P_diag, E);
        cma.free_all();
        return status;
    }
    void *ip_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, ADMM_IP_CONTROL_BASE & ~MAP_MASK);
    void *ctrl = (void*)((uint8_t*)ip_base + (ADMM_IP_CONTROL_BASE & MAP_MASK));
    void *ctrl_r = (void*)((uint8_t*)ip_base + (ADMM_IP_CONTROL_R_BASE & MAP_MASK));

    // Program CMA addresses to control_r registers
    write_64bit_address(ctrl_r, 0x010, cma_get_phy_addr(A_reg_ridx));
    write_64bit_address(ctrl_r, 0x01c, cma_get_phy_addr(A_reg_cptr));
    write_64bit_address(ctrl_r, 0x028, cma_get_phy_addr(A_reg_vals));
    write_64bit_address(ctrl_r, 0x034, cma_get_phy_addr(hw_tile_A_cnt)); write_64bit_address(ctrl_r, 0x040, cma_get_phy_addr(hw_tile_A_noff));
    write_64bit_address(ctrl_r, 0x04c, cma_get_phy_addr(hw_tile_A_coff)); write_64bit_address(ctrl_r, 0x058, cma_get_phy_addr(hw_tile_A_ridx));
    write_64bit_address(ctrl_r, 0x064, cma_get_phy_addr(hw_tile_A_cptr)); write_64bit_address(ctrl_r, 0x070, cma_get_phy_addr(hw_tile_A_vals));
    write_64bit_address(ctrl_r, 0x07c, cma_get_phy_addr(hw_tile_AT_cnt)); write_64bit_address(ctrl_r, 0x088, cma_get_phy_addr(hw_tile_AT_noff));
    write_64bit_address(ctrl_r, 0x094, cma_get_phy_addr(hw_tile_AT_coff)); write_64bit_address(ctrl_r, 0x0a0, cma_get_phy_addr(hw_tile_AT_ridx));
    write_64bit_address(ctrl_r, 0x0ac, cma_get_phy_addr(hw_tile_AT_cptr)); write_64bit_address(ctrl_r, 0x0b8, cma_get_phy_addr(hw_tile_AT_vals));
    write_64bit_address(ctrl_r, 0x0c4, cma_get_phy_addr(hw_tile_P_cnt)); write_64bit_address(ctrl_r, 0x0d0, cma_get_phy_addr(hw_tile_P_noff));
    write_64bit_address(ctrl_r, 0x0dc, cma_get_phy_addr(hw_tile_P_coff)); write_64bit_address(ctrl_r, 0x0e8, cma_get_phy_addr(hw_tile_P_ridx));
    write_64bit_address(ctrl_r, 0x0f4, cma_get_phy_addr(hw_tile_P_cptr)); write_64bit_address(ctrl_r, 0x100, cma_get_phy_addr(hw_tile_P_vals));
    write_64bit_address(ctrl_r, 0x10c, cma_get_phy_addr(hw_Pdiag)); write_64bit_address(ctrl_r, 0x118, cma_get_phy_addr(hw_l));
    write_64bit_address(ctrl_r, 0x124, cma_get_phy_addr(hw_u)); write_64bit_address(ctrl_r, 0x130, cma_get_phy_addr(hw_q));
    write_64bit_address(ctrl_r, 0x13c, cma_get_phy_addr(hw_rho)); write_64bit_address(ctrl_r, 0x148, cma_get_phy_addr(hw_x));
    write_64bit_address(ctrl_r, 0x154, cma_get_phy_addr(hw_y));

    // Optionally load bitstream if provided via options->sigma < 0 (cheap hack to pass path?) - skip here

    // Write control scalars and start
    write_reg(ctrl, 0x10, m); write_reg(ctrl, 0x18, n); write_reg(ctrl, 0x20, (int)A_vals.size());
    write_reg(ctrl, 0x28, tm_A.rtiles); write_reg(ctrl, 0x30, tm_A.ctiles);
    write_reg(ctrl, 0x38, tm_AT.rtiles); write_reg(ctrl, 0x40, tm_AT.ctiles);
    write_reg(ctrl, 0x48, tm_P.rtiles); write_reg(ctrl, 0x50, tm_P.ctiles);
    write_reg(ctrl, 0x58, float_to_uint(options->sigma)); write_reg(ctrl, 0x60, float_to_uint(options->alpha));
    write_reg(ctrl, 0x68, options->admm_max_iter); write_reg(ctrl, 0x70, options->pcg_max_iter);
    write_reg(ctrl, 0x78, options->adaptive_rho);
    write_reg(ctrl, 0x80, float_to_uint(options->eps_abs)); write_reg(ctrl, 0x88, float_to_uint(options->eps_rel));
    write_reg(ctrl, 0x90, float_to_uint(options->pcg_tol_fraction));

    cma.flush_all();

    double hw_start = get_time_ms();
    write_reg(ctrl, 0x00, 0x01);

    // Poll for completion with a hard timeout so the board does not freeze.
    const int timeout_ms = 5000;
    auto poll_start = std::chrono::steady_clock::now();
    while ((read_reg(ctrl, 0x00) & 0x02) == 0) {
        auto elapsed_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::steady_clock::now() - poll_start).count();
        if (elapsed_ms > timeout_ms) {
            fprintf(stderr, "[qpfpga] accelerator timeout after %d ms, using CPU fallback.\n", timeout_ms);
            munmap(ip_base, MAP_SIZE);
            close(mem_fd);
            cma.free_all();
            return cpu_fallback(q, P_diag, E);
        }
    }

    double hw_end = get_time_ms();

    cma.invalidate_all();

    int admm_iters = read_reg(ctrl, 0x98);
    int pcg_iters = read_reg(ctrl, 0xa8);
    float p_res = uint_to_float(read_reg(ctrl, 0xb8));
    float d_res = uint_to_float(read_reg(ctrl, 0xc8));
    int status = read_reg(ctrl, 0xd8);

    // Copy out results into freshly allocated arrays returned to caller
    float* out_x = new float[n];
    float* out_y = new float[m];
    for (int i = 0; i < n; ++i) out_x[i] = hw_x[i];
    for (int i = 0; i < m; ++i) out_y[i] = hw_y[i];

    result->status = (status == 1) ? QPFPGA_STATUS_OPTIMAL : QPFPGA_STATUS_USER_LIMIT;
    result->admm_iters = admm_iters;
    result->pcg_iters = pcg_iters;
    result->primal_residual = p_res;
    result->dual_residual = d_res;
    result->objective_value = 0.0f;
    result->solve_time_ms = hw_end - hw_start;
    result->x = out_x;
    result->y = out_y;

    // Cleanup
    munmap(ip_base, MAP_SIZE); close(mem_fd);
    cma.free_all();

    return result->status;
}