# Define the absolute base directory
set BASE_DIR "/home/romoirib/QP/spmv"

# Create a dedicated build folder at the root
set build_dir "${BASE_DIR}/vivado_build"
create_project spmv_bd $build_dir -part xczu7ev-ffvc1156-2-e -force
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]

# Point to the HLS IP repository using the absolute path
set_property ip_repo_paths ${BASE_DIR}/HLS/spmv_hls_prj/solution1/impl/ip [current_project]
update_ip_catalog

# Create Block Design
create_bd_design "design_1"

# Add Zynq UltraScale+ and apply block automation (Presets)
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1"} [get_bd_cells zynq_ultra_ps_e_0]

# Configure Zynq PS: Disable HPM1 (M_AXI_GP1) and Enable HPC0 (S_AXI_GP0)
set_property -dict [list \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__S_AXI_GP0 {1} \
] [get_bd_cells zynq_ultra_ps_e_0]

# Add the SpMV HLS IP
create_bd_cell -type ip -vlnv xilinx.com:hls:spmv_csr:1.0 spmv_csr_0

# Run Connection Automation for the AXI-Lite Control interface
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Master "/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD" intc_ip "New AXI Interconnect" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins spmv_csr_0/s_axi_control]

# Run Connection Automation for all 5 GMEM master interfaces (connecting to HPC0)
foreach gmem_port {gmem0 gmem1 gmem2 gmem3 gmem4} {
    apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Master "/spmv_csr_0/m_axi_$gmem_port" intc_ip "New AXI SmartConnect" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC0_FPD]
}

# Validate Design
validate_bd_design

# Create and add the HDL Wrapper
set wrapper_path [make_wrapper -files [get_files [current_bd_design].bd] -top]
add_files -norecurse $wrapper_path
update_compile_order -fileset sources_1

# Launch Synthesis and Implementation to generate Bitstream
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

# Extract the final files and place them cleanly in the absolute root directory
file copy -force ${build_dir}/spmv_bd.runs/impl_1/design_1_wrapper.bit ${BASE_DIR}/spmv.bit
file copy -force ${build_dir}/spmv_bd.gen/sources_1/bd/design_1/hw_handoff/design_1.hwh ${BASE_DIR}/spmv.hwh

puts "Bitstream generation complete! Files copied as spmv.bit and spmv.hwh to ${BASE_DIR}"
exit
