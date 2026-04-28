open_project spmv_csc_HW_HLS
set_top spmv_csc

# Design Files
add_files HLS/include/spmv_csc.h
add_files HLS/src/spmv_csc.cpp -cflags "-I HLS/include"

# Testbench Files - Adding it here makes it available for hls_sim
add_files -tb HLS/test/tb_spmv_csc.cpp -cflags "-I HLS/include -I HLS/test"

add_files -tb HLS/test/cols.dat
add_files -tb HLS/test/data.dat
add_files -tb HLS/test/matrix.dat
add_files -tb HLS/test/rows.dat

open_solution "solution1" -flow_target vivado
set_part {xczu7ev-ffvc1156-2-e}
create_clock -period 5 -name default
set_clock_uncertainty 1
config_interface -m_axi_addr64=1
quit