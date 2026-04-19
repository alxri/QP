# Define the absolute base directory
set BASE_DIR "/home/romoirib/QP/spmv"

# Set project directory inside HLS folder
set proj_dir "${BASE_DIR}/HLS/spmv_hls_prj"
open_project $proj_dir -reset

# Set the top-level function
set_top spmv_csr

# Add source files using absolute paths
add_files ${BASE_DIR}/HLS/src/spmv_csr.cpp -cflags "-I${BASE_DIR}/HLS/include"
add_files -tb ${BASE_DIR}/HLS/test/tb_spmv_csr.cpp -cflags "-I${BASE_DIR}/HLS/include"

# Create a solution
open_solution "solution1" -flow_target vivado

# Set the ZCU104 part and 10ns clock
set_part {xczu7ev-ffvc1156-2-e}
create_clock -period 10 -name default

# Run C Simulation (Comment out if you want to skip testing)
csim_design

# Run C Synthesis
csynth_design

# Package the IP so Vivado can use it
export_design -format ip_catalog

# Close the project
close_project
exit
