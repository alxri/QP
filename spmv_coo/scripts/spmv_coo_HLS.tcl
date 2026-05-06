open_project spmv_coo_HW_HLS
set_top spmv_coo

# Design Files
add_files HLS/include/spmv_coo.h
add_files HLS/src/spmv_coo.cpp -cflags "-I HLS/include"

# Testbench Files - Adding it here makes it available for hls_sim
add_files -tb HLS/test/tb_spmv_coo.cpp -cflags "-I HLS/include -I HLS/test"

open_solution "solution1" -flow_target vivado
set_part {xczu7ev-ffvc1156-2-e}
create_clock -period 10 -name default
set_clock_uncertainty 1
config_interface -m_axi_addr64=1
quit