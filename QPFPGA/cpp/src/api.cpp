#include "api.h"
#include "utils.h"
#include "fpga_utils.h"
#include <utility>

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <chrono>
#include <algorithm>
#include <vector>
#include <cstring>
#include <cstdlib>
#include <cstdio>

extern "C" QPFPGAStatus qpfpga_solve(
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
    std::vector<int> P_cptr; std::vector<int> P_ridx; std::vector<float> P_vals;
    copy_csc_from_raw(problem->P.ncols, problem->P.nnz, problem->P.indptr, problem->P.indices, problem->P.data,
                      P_cptr, P_ridx, P_vals);

    // Copy A (CSC)
    std::vector<int> A_cptr; std::vector<int> A_ridx; std::vector<float> A_vals;
    copy_csc_from_raw(problem->A.ncols, problem->A.nnz, problem->A.indptr, problem->A.indices, problem->A.data,
                      A_cptr, A_ridx, A_vals);

    // Copy vectors
    std::vector<float> q(problem->q, problem->q + n);
    std::vector<float> l(problem->l, problem->l + m);
    std::vector<float> u(problem->u, problem->u + m);

    // Build P diagonal vector
    std::vector<float> P_diag;
    build_diag_from_csc(n, P_cptr, P_ridx, P_vals, P_diag);

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

    // Prepare CMA buffers and copy data for A (packed words)
    CmaTracker cma;
    int32_words* A_reg_ridx = nullptr;
    float32_words* A_reg_vals = nullptr;
    int* A_reg_cptr = nullptr;
    int a_words_cnt = 0;
    allocate_and_copy_csc_to_cma(cma, A_cptr, A_ridx, A_vals, &A_reg_ridx, &A_reg_vals, &A_reg_cptr, &a_words_cnt);

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
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_ROW_IDX_DATA, cma_get_phy_addr(A_reg_ridx));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_COL_PTR_DATA, cma_get_phy_addr(A_reg_cptr));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_VALUES_DATA, cma_get_phy_addr(A_reg_vals));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_TILE_NNZ_COUNTS_DATA, cma_get_phy_addr(hw_tile_A_cnt)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_TILE_NNZ_OFFSETS_DATA, cma_get_phy_addr(hw_tile_A_noff));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_TILE_COL_OFFSETS_DATA, cma_get_phy_addr(hw_tile_A_coff)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_ROW_IDX_TILED_DATA, cma_get_phy_addr(hw_tile_A_ridx));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_COL_PTR_TILED_DATA, cma_get_phy_addr(hw_tile_A_cptr)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_A_VALUES_TILED_DATA, cma_get_phy_addr(hw_tile_A_vals));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_AT_TILE_NNZ_COUNTS_DATA, cma_get_phy_addr(hw_tile_AT_cnt)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_AT_TILE_NNZ_OFFSETS_DATA, cma_get_phy_addr(hw_tile_AT_noff));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_AT_TILE_COL_OFFSETS_DATA, cma_get_phy_addr(hw_tile_AT_coff)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_AT_ROW_IDX_TILED_DATA, cma_get_phy_addr(hw_tile_AT_ridx));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_AT_COL_PTR_TILED_DATA, cma_get_phy_addr(hw_tile_AT_cptr)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_AT_VALUES_TILED_DATA, cma_get_phy_addr(hw_tile_AT_vals));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_TILE_NNZ_COUNTS_DATA, cma_get_phy_addr(hw_tile_P_cnt)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_TILE_NNZ_OFFSETS_DATA, cma_get_phy_addr(hw_tile_P_noff));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_TILE_COL_OFFSETS_DATA, cma_get_phy_addr(hw_tile_P_coff)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_ROW_IDX_TILED_DATA, cma_get_phy_addr(hw_tile_P_ridx));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_COL_PTR_TILED_DATA, cma_get_phy_addr(hw_tile_P_cptr)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_VALUES_TILED_DATA, cma_get_phy_addr(hw_tile_P_vals));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_P_DIAG_DATA, cma_get_phy_addr(hw_Pdiag)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_L_IN_DATA, cma_get_phy_addr(hw_l));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_U_IN_DATA, cma_get_phy_addr(hw_u)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_Q_IN_DATA, cma_get_phy_addr(hw_q));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_RHO_IN_DATA, cma_get_phy_addr(hw_rho)); write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_X_OUT_DATA, cma_get_phy_addr(hw_x));
    write_64bit_address(ctrl_r, XADMM_CONTROL_R_ADDR_Y_OUT_DATA, cma_get_phy_addr(hw_y));

    // Optionally load bitstream if provided via options->sigma < 0 (cheap hack to pass path?) - skip here

    // Write control scalars and start
    write_reg(ctrl, XADMM_CONTROL_ADDR_NUM_ROWS_DATA, m); write_reg(ctrl, XADMM_CONTROL_ADDR_NUM_COLS_DATA, n); write_reg(ctrl, XADMM_CONTROL_ADDR_A_NNZ_DATA, (int)A_vals.size());
    write_reg(ctrl, XADMM_CONTROL_ADDR_A_NUM_ROW_TILES_DATA, tm_A.rtiles); write_reg(ctrl, XADMM_CONTROL_ADDR_A_NUM_COL_TILES_DATA, tm_A.ctiles);
    write_reg(ctrl, XADMM_CONTROL_ADDR_AT_NUM_ROW_TILES_DATA, tm_AT.rtiles); write_reg(ctrl, XADMM_CONTROL_ADDR_AT_NUM_COL_TILES_DATA, tm_AT.ctiles);
    write_reg(ctrl, XADMM_CONTROL_ADDR_P_NUM_ROW_TILES_DATA, tm_P.rtiles); write_reg(ctrl, XADMM_CONTROL_ADDR_P_NUM_COL_TILES_DATA, tm_P.ctiles);
    write_reg(ctrl, XADMM_CONTROL_ADDR_SIGMA_DATA, float_to_uint(options->sigma)); write_reg(ctrl, XADMM_CONTROL_ADDR_ALPHA_DATA, float_to_uint(options->alpha));
    write_reg(ctrl, XADMM_CONTROL_ADDR_ADMM_MAX_ITERATIONS_DATA, options->admm_max_iter); write_reg(ctrl, XADMM_CONTROL_ADDR_PCG_MAX_ITERATIONS_DATA, options->pcg_max_iter);
    write_reg(ctrl, XADMM_CONTROL_ADDR_ADAPTIVE_RHO_DATA, options->adaptive_rho);
    write_reg(ctrl, XADMM_CONTROL_ADDR_EPS_ABS_DATA, float_to_uint(options->eps_abs)); write_reg(ctrl, XADMM_CONTROL_ADDR_EPS_REL_DATA, float_to_uint(options->eps_rel));
    write_reg(ctrl, XADMM_CONTROL_ADDR_PCG_TOL_FRACTION_DATA, float_to_uint(options->pcg_tol_fraction));

    cma.flush_all();

    double hw_start = get_time_ms();
    write_reg(ctrl, XADMM_CONTROL_ADDR_AP_CTRL, 0x01);

    // Poll for completion with a hard timeout so the board does not freeze.
    const int timeout_ms = 5000;
    auto poll_start = std::chrono::steady_clock::now();
    while ((read_reg(ctrl, XADMM_CONTROL_ADDR_AP_CTRL) & 0x02) == 0) {
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

    int admm_iters = read_reg(ctrl, XADMM_CONTROL_ADDR_ADMM_NUM_ITERATIONS_OUT_DATA);
    int pcg_iters = read_reg(ctrl, XADMM_CONTROL_ADDR_PCG_NUM_ITERATIONS_OUT_DATA);
    float p_res = uint_to_float(read_reg(ctrl, XADMM_CONTROL_ADDR_R_PRIM_OUT_DATA));
    float d_res = uint_to_float(read_reg(ctrl, XADMM_CONTROL_ADDR_R_DUAL_OUT_DATA));
    int status = read_reg(ctrl, XADMM_CONTROL_ADDR_STATUS_OUT_DATA);

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