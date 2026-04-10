# create_project.tcl

open_project -reset mv

set_top mv

add_files /home/romoirib/QP/mv/HLS/src/mv.cpp \
    -cflags "-I/home/romoirib/QP/mv/HLS/include"

add_files -tb /home/romoirib/QP/mv/HLS/test/tb_mv.cpp \
    -cflags "-I/home/romoirib/QP/mv/HLS/include"

open_solution -reset solution1

set_part xczu7ev-ffvc1156-2-e
create_clock -period 10ns -name default

csim_design
csynth_design
export_design -rtl verilog -format ip_catalog

exit
