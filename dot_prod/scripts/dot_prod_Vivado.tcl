# Step 1 & 2: Create Vivado project in vivado_build/spmv_bd
set proj_name "spmv_bd"
set proj_dir "./vivado_build"
create_project $proj_name $proj_dir/$proj_name -part xczu7ev-ffvc1156-2-e -force

# Step 3: Set Board to ZCU104
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]
set_property target_language Verilog [current_project]

# Step 4: Settings -> IP -> Repository
set ip_repo_path "/home/romoirib/QP/dot_prod/dot_prod_HW_HLS/solution1/impl/ip"
set_property ip_repo_paths $ip_repo_path [current_project]
update_ip_catalog -rebuild

# Step 5: Create Block Design
create_bd_design "design_1"

# Step 6: Add IP block Zynq Ultrascale+ MPSoC
set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.5 zynq_ultra_ps_e_0 ]

# Step 7: Add IP block dot_prod
set dot_prod_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:dot_prod:1.0 dot_prod_0 ]

# Step 8: Run block automation with board preset
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]

# Step 9: PS-PL configuration
# Enable AXI HPC0 FPD (for GMEM) AND Disable unused M_AXI_HPM1_FPD to prevent validation errors
set_property -dict [list \
  CONFIG.PSU__USE__S_AXI_GP0 {1} \
  CONFIG.PSU__USE__M_AXI_GP1 {0} \
] [get_bd_cells zynq_ultra_ps_e_0]

# Step 10: Run Connect Automation (First pass - AXI Lite Control and gmem0)
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD} Slave {/dot_prod_0/s_axi_control} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins dot_prod_0/s_axi_control]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/dot_prod_0/m_axi_gmem0} Slave {/zynq_ultra_ps_e_0/S_AXI_HPC0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC0_FPD]

# Step 11: Run Connect Automation (Second pass - remaining gmem ports)
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/dot_prod_0/m_axi_gmem1} Slave {/zynq_ultra_ps_e_0/S_AXI_HPC0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins dot_prod_0/m_axi_gmem1]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/dot_prod_0/m_axi_gmem2} Slave {/zynq_ultra_ps_e_0/S_AXI_HPC0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins dot_prod_0/m_axi_gmem2]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/dot_prod_0/m_axi_gmem3} Slave {/zynq_ultra_ps_e_0/S_AXI_HPC0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins dot_prod_0/m_axi_gmem3]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/dot_prod_0/m_axi_gmem4} Slave {/zynq_ultra_ps_e_0/S_AXI_HPC0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins dot_prod_0/m_axi_gmem4]

# Step 12: Validate and Save
assign_bd_address
regenerate_bd_layout
validate_bd_design
save_bd_design

# Step 13: Create HDL wrapper
set wrapper_path [make_wrapper -files [get_files design_1.bd] -top]
add_files -norecurse $wrapper_path

# Step 14: Let Vivado manage wrapper and auto-update
set_property top design_1_wrapper [current_fileset]
update_compile_order -fileset sources_1

# Exit gracefully
quit