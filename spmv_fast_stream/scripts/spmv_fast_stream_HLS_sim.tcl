# Open the existing project instead of recreating it
open_project spmv_fast_stream_HW_HLS
open_solution "solution1"

# Run C-Simulation
csim_design -O
quit