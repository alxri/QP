# Open the existing project instead of recreating it
open_project spmv_csr_optimized_HW_HLS
open_solution "solution1"

# Run C-Simulation
csim_design -O
quit