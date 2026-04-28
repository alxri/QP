# Step 1 & 2: Create Vivado project in vivado_build/spmv_bd
set proj_name "spmv_bd"
set proj_dir "./vivado_build"
create_project $proj_name $proj_dir/$proj_name -part xczu7ev-ffvc1156-2-e -force

# Step 3: Set Board to ZCU104
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]
set_property target_language Verilog [current_project]

# Step 4: Settings -> IP -> Repository
set ip_repo_path "/home/romoirib/QP/spmv_csc/spmv_csc_HW_HLS/solution1/impl/ip"
set_property ip_repo_paths $ip_repo_path [current_project]
update_ip_catalog -rebuild

# Step 5: Create Block Design
create_bd_design "design_1"

# Step 6: Add IP block Zynq Ultrascale+ MPSoC
set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0 ]

# Step 7: Add IP block Spmv_csc
set spmv_csc_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:spmv_csc:1.0 spmv_csc_0 ]

# Step 8: Run block automation with board preset
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]

# Step 9: PS-PL configuration (The High-Performance Memory Setup)
# Disable unused Master HPM1 to fix clock errors. Disable HPC (GP0/GP1). Enable HP0-HP3 (GP2-GP5) at 128-bit.
set_property -dict [list \
  CONFIG.PSU__USE__M_AXI_GP1 {0} \
  CONFIG.PSU__USE__S_AXI_GP0 {0} \
  CONFIG.PSU__USE__S_AXI_GP1 {0} \
  CONFIG.PSU__USE__S_AXI_GP2 {1} \
  CONFIG.PSU__USE__S_AXI_GP3 {1} \
  CONFIG.PSU__USE__S_AXI_GP4 {1} \
  CONFIG.PSU__USE__S_AXI_GP5 {1} \
  CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
  CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
  CONFIG.PSU__SAXIGP4__DATA_WIDTH {128} \
  CONFIG.PSU__SAXIGP5__DATA_WIDTH {128} \
] [get_bd_cells zynq_ultra_ps_e_0]

# Step 10: Run Connect Automation for AXI-Lite Control registers
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins spmv_csc_0/s_axi_control]

# Step 11: Create and Route 4 Dedicated Memory SmartConnects

# Instantiate four separate SmartConnects
set smc_gmem2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smc_gmem2 ] ;# For A_values
set smc_gmem0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smc_gmem0 ] ;# For A_row_idx
set smc_gmem4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smc_gmem4 ] ;# For y_out
set smc_gmem1_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smc_gmem1_3 ] ;# For A_col_ptr & x

# Explicitly configure the first three to have exactly 1 input
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $smc_gmem2
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $smc_gmem0
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] $smc_gmem4

# Configure the 4th SmartConnect to accept 2 inputs
set_property -dict [list CONFIG.NUM_SI {2} CONFIG.NUM_MI {1}] $smc_gmem1_3

# Route 1: A_values (gmem2) -> HP0
connect_bd_intf_net [get_bd_intf_pins spmv_csc_0/m_axi_gmem2] [get_bd_intf_pins smc_gmem2/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smc_gmem2/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]

# Route 2: A_row_idx (gmem0) -> HP1
connect_bd_intf_net [get_bd_intf_pins spmv_csc_0/m_axi_gmem0] [get_bd_intf_pins smc_gmem0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smc_gmem0/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP1_FPD]

# Route 3: y_out (gmem4) -> HP2
connect_bd_intf_net [get_bd_intf_pins spmv_csc_0/m_axi_gmem4] [get_bd_intf_pins smc_gmem4/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins smc_gmem4/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP2_FPD]

# Route 4: A_col_ptr (gmem1) & x (gmem3) -> HP3
connect_bd_intf_net [get_bd_intf_pins spmv_csc_0/m_axi_gmem1] [get_bd_intf_pins smc_gmem1_3/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins spmv_csc_0/m_axi_gmem3] [get_bd_intf_pins smc_gmem1_3/S01_AXI]
connect_bd_intf_net [get_bd_intf_pins smc_gmem1_3/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP3_FPD]

# Step 12: Manually wire Clocks and Resets (Bypassing auto-router bugs)

# 1. Get the main clock pin
set sys_clk [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]

# 2. Find the Processor System Reset block generated in Step 10 and get its active-low reset pin
set rst_blk [get_bd_cells -filter {vlnv =~ "*proc_sys_reset*"}]
set sys_rst_pin [get_bd_pins $rst_blk/peripheral_aresetn]

# 3. Wire the clock to the Zynq HP ports
connect_bd_net $sys_clk [get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk]
connect_bd_net $sys_clk [get_bd_pins zynq_ultra_ps_e_0/saxihp1_fpd_aclk]
connect_bd_net $sys_clk [get_bd_pins zynq_ultra_ps_e_0/saxihp2_fpd_aclk]
connect_bd_net $sys_clk [get_bd_pins zynq_ultra_ps_e_0/saxihp3_fpd_aclk]

# 4. Wire the clock to the 4 SmartConnects
connect_bd_net $sys_clk [get_bd_pins smc_gmem2/aclk]
connect_bd_net $sys_clk [get_bd_pins smc_gmem0/aclk]
connect_bd_net $sys_clk [get_bd_pins smc_gmem4/aclk]
connect_bd_net $sys_clk [get_bd_pins smc_gmem1_3/aclk]

# 5. Wire the reset pin directly to the 4 SmartConnects
connect_bd_net $sys_rst_pin [get_bd_pins smc_gmem2/aresetn]
connect_bd_net $sys_rst_pin [get_bd_pins smc_gmem0/aresetn]
connect_bd_net $sys_rst_pin [get_bd_pins smc_gmem4/aresetn]
connect_bd_net $sys_rst_pin [get_bd_pins smc_gmem1_3/aresetn]

# Step 13: Address Assignment (Simulates hitting "Yes" on the auto-assign prompt)
assign_bd_address

# Step 14: Validate and Save
regenerate_bd_layout
validate_bd_design
save_bd_design

# Step 15: Create HDL wrapper
set wrapper_path [make_wrapper -files [get_files design_1.bd] -top]
add_files -norecurse $wrapper_path

# Step 16: Let Vivado manage wrapper and auto-update
set_property top design_1_wrapper [current_fileset]
update_compile_order -fileset sources_1

# Exit gracefully
quit