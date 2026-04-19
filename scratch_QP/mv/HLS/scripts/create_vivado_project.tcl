# create_vivado_project.tcl
#
# Vivado (IP Integrator) flow for the HLS-generated 'mv' IP.
# Usage (example):
#   vivado -mode batch -source create_vivado_project.tcl
#
# This script expects the HLS IP was exported with:
#   export_design -rtl verilog -format ip_catalog
# and is available under:
#   HLS/scripts/mv/solution1/impl/ip

# ------------------------------------------------------------
# User-configurable settings
# ------------------------------------------------------------
set proj_name      "mv_bd"
set bd_name        "design_1"
set part_name      "xczu7ev-ffvc1156-2-e"

# If your Vivado install has the ZCU104 board files, you can set:
#   set board_part "xilinx.com:zcu104:part0:1.1"
# Otherwise leave empty to avoid errors.
set board_part     ""

# HLS IP name (as it appears in the IP catalog)
set hls_ip_name    "mv"

# Disable HPM1 to avoid common clock warnings in some presets.
# Set to 0 if you explicitly need M_AXI_HPM1_FPD.
set disable_hpm1   1

# Address map (adjust if you want different offsets)
set ctrl_offset    0xA0000000
set ctrl_range     64K

# ------------------------------------------------------------
# Derived paths
# ------------------------------------------------------------
set script_dir [file dirname [file normalize [info script]]]
set hls_root   [file normalize [file join $script_dir ..]]
set ip_repo    [file join $hls_root scripts mv solution1 impl ip]
set proj_dir   [file join $hls_root vivado $proj_name]

if {![file isdirectory $ip_repo]} {
  puts "ERROR: IP repository not found: $ip_repo"
  puts "Did you run Vitis HLS export_design -format ip_catalog?"
  exit 1
}

# ------------------------------------------------------------
# Create project
# ------------------------------------------------------------
create_project -force $proj_name $proj_dir -part $part_name
if {$board_part ne ""} {
  if {[catch {set_property board_part $board_part [current_project]} err]} {
    puts "WARNING: Could not set board_part '$board_part' ($err). Continuing with part only."
  }
}

# Add the HLS IP repository
set_property ip_repo_paths [list $ip_repo] [current_project]
update_ip_catalog

# ------------------------------------------------------------
# Create block design and add IP
# ------------------------------------------------------------
create_bd_design $bd_name

# Zynq UltraScale+ MPSoC
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0

# Apply board preset if possible (requires board_part in most setups)
catch {
  apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e \
    -config {apply_board_preset "1"} \
    [get_bd_cells zynq_ultra_ps_e_0]
}

# Optionally disable HPM1
if {$disable_hpm1} {
  catch {
    set_property -dict [list CONFIG.PSU__USE__M_AXI_HPM1_FPD {0}] [get_bd_cells zynq_ultra_ps_e_0]
  }
}

# Ensure the PS exposes ports we intend to use
# - Control: M_AXI_HPM0_FPD
# - Memory:  S_AXI_HP0/1/2_FPD
catch {
  set_property -dict [list \
    CONFIG.PSU__USE__M_AXI_HPM0_FPD {1} \
    CONFIG.PSU__USE__S_AXI_HP0_FPD  {1} \
    CONFIG.PSU__USE__S_AXI_HP1_FPD  {1} \
    CONFIG.PSU__USE__S_AXI_HP2_FPD  {1} \
  ] [get_bd_cells zynq_ultra_ps_e_0]
}

# HLS IP (mv)
set ipdefs [get_ipdefs -all -filter "NAME == $hls_ip_name"]
if {[llength $ipdefs] == 0} {
  puts "ERROR: HLS IP '$hls_ip_name' not found in IP catalog."
  puts "IP repo: $ip_repo"
  puts "Hint: open Vivado GUI and check Tools -> Settings -> IP -> Repository."
  exit 1
}
set mv_vlnv [lindex $ipdefs 0]
create_bd_cell -type ip -vlnv $mv_vlnv ${hls_ip_name}_0

# ------------------------------------------------------------
# Clock + reset wiring
# ------------------------------------------------------------
# Use pl_clk0/pl_resetn0 from the PS as the PL fabric clock/reset.
# HLS IP typically uses ap_clk and ap_rst_n.
catch {
  connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins ${hls_ip_name}_0/ap_clk]
}

# Try active-low reset first (ap_rst_n). If the IP exposes ap_rst instead, fall back.
if {[catch {connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins ${hls_ip_name}_0/ap_rst_n]}]} {
  catch {connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins ${hls_ip_name}_0/ap_rst]}
}

# ------------------------------------------------------------
# AXI interconnects (SmartConnect)
# ------------------------------------------------------------
# Control path: PS M_AXI_HPM0_FPD -> SmartConnect -> mv_0/s_axi_control*
create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_ctrl

# Some HLS IPs expose more than one AXI4-Lite slave interface, and the name depends on the
# bundle used in the HLS pragmas (e.g. s_axi_control, s_axi_control_r, s_axi_control_bus, ...).
# Auto-detect and connect all s_axi_* slave interfaces.
set ctrl_slaves [lsort [get_bd_intf_pins -of_objects [get_bd_cells ${hls_ip_name}_0] -filter {MODE == Slave && NAME =~ "s_axi_*"}]]
if {[llength $ctrl_slaves] == 0} {
  puts "ERROR: No AXI4-Lite slave interface found on ${hls_ip_name}_0 (expected s_axi_*)"
  exit 1
}
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI [llength $ctrl_slaves]] [get_bd_cells smartconnect_ctrl]

catch {connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins smartconnect_ctrl/aclk]}
catch {connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins smartconnect_ctrl/aresetn]}

catch {
  connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD] [get_bd_intf_pins smartconnect_ctrl/S00_AXI]
}

set ctrl_idx 0
foreach ctrl_if $ctrl_slaves {
  set mi_pin [format "smartconnect_ctrl/%s" [format "M%02d_AXI" $ctrl_idx]]
  catch {connect_bd_intf_net [get_bd_intf_pins $mi_pin] $ctrl_if}
  incr ctrl_idx
}

# Memory paths: connect each HLS AXI master (m_axi_*) to PS HP ports via SmartConnect.
# This is robust to bundle renames (e.g. m_axi_A_port instead of m_axi_gmem0).
set mem_masters [lsort [get_bd_intf_pins -of_objects [get_bd_cells ${hls_ip_name}_0] -filter {MODE == Master && NAME =~ "m_axi_*"}]]
set hp_ports [list \
  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD] \
  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP1_FPD] \
  [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP2_FPD] \
]

if {[llength $mem_masters] == 0} {
  puts "WARNING: No AXI master memory interfaces found on ${hls_ip_name}_0 (m_axi_*)"
}
if {[llength $mem_masters] > [llength $hp_ports]} {
  puts "WARNING: Found [llength $mem_masters] m_axi_* interfaces but only [llength $hp_ports] PS HP ports are enabled in this script."
  puts "WARNING: Only the first [llength $hp_ports] interfaces will be connected."
}

set mem_count [expr {([llength $mem_masters] < [llength $hp_ports]) ? [llength $mem_masters] : [llength $hp_ports]}]
for {set i 0} {$i < $mem_count} {incr i} {
  set mem_if   [lindex $mem_masters $i]
  set hp_if    [lindex $hp_ports $i]

  set mem_name [get_property NAME $mem_if]
  set sc_name  [format "smartconnect_%s" $mem_name]
  regsub -all {[^A-Za-z0-9_]} $sc_name _ sc_name

  create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 $sc_name
  set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1}] [get_bd_cells $sc_name]

  catch {connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins $sc_name/aclk]}
  catch {connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] [get_bd_pins $sc_name/aresetn]}

  catch {connect_bd_intf_net $mem_if [get_bd_intf_pins $sc_name/S00_AXI]}
  catch {connect_bd_intf_net [get_bd_intf_pins $sc_name/M00_AXI] $hp_if}
}

# ------------------------------------------------------------
# Addressing
# ------------------------------------------------------------
# Assign addresses for AXI-Lite control interface.
catch {assign_bd_address}

# Try to force the control segment to the requested offset/range.
# (Vivado names can vary slightly; use catch to keep script resilient.)
catch {
  set segs [get_bd_addr_segs -of_objects [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] -filter "NAME =~ *${hls_ip_name}_0*"]
  set seg_idx 0
  foreach seg $segs {
    set_property offset [format 0x%08X [expr {$ctrl_offset + ($seg_idx * 0x00010000)}]] $seg
    set_property range  $ctrl_range $seg
    incr seg_idx
  }
}

# ------------------------------------------------------------
# Validate, create wrapper, and build bitstream
# ------------------------------------------------------------
validate_bd_design
save_bd_design

set bd_file [get_files -of_objects [get_bd_designs $bd_name]]
generate_target all $bd_file
make_wrapper -files $bd_file -top

# Add wrapper to project
set wrapper_file [get_files -all -filter "NAME =~ *${bd_name}_wrapper.v"]
if {[llength $wrapper_file] > 0} {
  add_files -norecurse [lindex $wrapper_file 0]
}

update_compile_order -fileset sources_1

# Run implementation through bitstream
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# Optional: write out an XSA (contains .hwh-like metadata for PYNQ workflows)
catch {
  write_hw_platform -fixed -include_bit -force -file [file join $proj_dir [format "%s.xsa" $proj_name]]
}

puts "DONE: Bitstream should be under: $proj_dir/$proj_name.runs/impl_1/"
puts "DONE: (Optional) XSA written to: $proj_dir/$proj_name.xsa"
