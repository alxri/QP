open_project dot_prod_HW_HLS
set_top dot_prod

# Design Files
add_files HLS/include/dot_prod.h
add_files HLS/src/dot_prod.cpp -cflags "-I HLS/include"

# Testbench Files - Adding it here makes it available for hls_sim
add_files -tb HLS/test/tb_dot_prod.cpp -cflags "-I HLS/include -I HLS/test"

open_solution "solution1" -flow_target vivado
set_part {xczu7ev-ffvc1156-2-e}
create_clock -period 10 -name default
set_clock_uncertainty 1
config_interface -m_axi_addr64=1
quit