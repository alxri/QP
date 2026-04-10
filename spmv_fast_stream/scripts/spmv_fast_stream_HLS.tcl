open_project spmv_fast_stream_HW_HLS
set_top spmv

# Design Files
add_files HLS/include/spmv_csr.h
add_files HLS/src/spmv_csr.cpp -cflags "-I HLS/include"

# Testbench Files - Adding it here makes it available for hls_sim
add_files -tb HLS/test/tb_spmv_csr.cpp -cflags "-I HLS/include"

open_solution "solution1" -flow_target vivado
set_part {xczu7ev-ffvc1156-2-e}
create_clock -period 10 -name default
set_clock_uncertainty 1
config_interface -m_axi_addr64=1
quit