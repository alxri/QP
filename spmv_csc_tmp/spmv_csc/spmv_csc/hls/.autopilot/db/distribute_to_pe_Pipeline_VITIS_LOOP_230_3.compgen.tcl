# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 100 \
    name pe_streams_0 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_0 \
    op interface \
    ports { pe_streams_0_din { O 97 vector } pe_streams_0_full_n { I 1 bit } pe_streams_0_write { O 1 bit } pe_streams_0_num_data_valid { I 32 vector } pe_streams_0_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 101 \
    name pe_streams_1 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_1 \
    op interface \
    ports { pe_streams_1_din { O 97 vector } pe_streams_1_full_n { I 1 bit } pe_streams_1_write { O 1 bit } pe_streams_1_num_data_valid { I 32 vector } pe_streams_1_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 102 \
    name pe_streams_2 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_2 \
    op interface \
    ports { pe_streams_2_din { O 97 vector } pe_streams_2_full_n { I 1 bit } pe_streams_2_write { O 1 bit } pe_streams_2_num_data_valid { I 32 vector } pe_streams_2_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 103 \
    name pe_streams_3 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_3 \
    op interface \
    ports { pe_streams_3_din { O 97 vector } pe_streams_3_full_n { I 1 bit } pe_streams_3_write { O 1 bit } pe_streams_3_num_data_valid { I 32 vector } pe_streams_3_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 104 \
    name pe_streams_4 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_4 \
    op interface \
    ports { pe_streams_4_din { O 97 vector } pe_streams_4_full_n { I 1 bit } pe_streams_4_write { O 1 bit } pe_streams_4_num_data_valid { I 32 vector } pe_streams_4_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 105 \
    name pe_streams_5 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_5 \
    op interface \
    ports { pe_streams_5_din { O 97 vector } pe_streams_5_full_n { I 1 bit } pe_streams_5_write { O 1 bit } pe_streams_5_num_data_valid { I 32 vector } pe_streams_5_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 106 \
    name pe_streams_6 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_6 \
    op interface \
    ports { pe_streams_6_din { O 97 vector } pe_streams_6_full_n { I 1 bit } pe_streams_6_write { O 1 bit } pe_streams_6_num_data_valid { I 32 vector } pe_streams_6_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 107 \
    name pe_streams_7 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_7 \
    op interface \
    ports { pe_streams_7_din { O 97 vector } pe_streams_7_full_n { I 1 bit } pe_streams_7_write { O 1 bit } pe_streams_7_num_data_valid { I 32 vector } pe_streams_7_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 108 \
    name pe_streams_8 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_8 \
    op interface \
    ports { pe_streams_8_din { O 97 vector } pe_streams_8_full_n { I 1 bit } pe_streams_8_write { O 1 bit } pe_streams_8_num_data_valid { I 32 vector } pe_streams_8_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 109 \
    name pe_streams_9 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_9 \
    op interface \
    ports { pe_streams_9_din { O 97 vector } pe_streams_9_full_n { I 1 bit } pe_streams_9_write { O 1 bit } pe_streams_9_num_data_valid { I 32 vector } pe_streams_9_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 110 \
    name pe_streams_10 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_10 \
    op interface \
    ports { pe_streams_10_din { O 97 vector } pe_streams_10_full_n { I 1 bit } pe_streams_10_write { O 1 bit } pe_streams_10_num_data_valid { I 32 vector } pe_streams_10_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 111 \
    name pe_streams_11 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_11 \
    op interface \
    ports { pe_streams_11_din { O 97 vector } pe_streams_11_full_n { I 1 bit } pe_streams_11_write { O 1 bit } pe_streams_11_num_data_valid { I 32 vector } pe_streams_11_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 112 \
    name pe_streams_12 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_12 \
    op interface \
    ports { pe_streams_12_din { O 97 vector } pe_streams_12_full_n { I 1 bit } pe_streams_12_write { O 1 bit } pe_streams_12_num_data_valid { I 32 vector } pe_streams_12_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 113 \
    name pe_streams_13 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_13 \
    op interface \
    ports { pe_streams_13_din { O 97 vector } pe_streams_13_full_n { I 1 bit } pe_streams_13_write { O 1 bit } pe_streams_13_num_data_valid { I 32 vector } pe_streams_13_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 114 \
    name pe_streams_14 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_14 \
    op interface \
    ports { pe_streams_14_din { O 97 vector } pe_streams_14_full_n { I 1 bit } pe_streams_14_write { O 1 bit } pe_streams_14_num_data_valid { I 32 vector } pe_streams_14_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 115 \
    name pe_streams_15 \
    type fifo \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_pe_streams_15 \
    op interface \
    ports { pe_streams_15_din { O 97 vector } pe_streams_15_full_n { I 1 bit } pe_streams_15_write { O 1 bit } pe_streams_15_num_data_valid { I 32 vector } pe_streams_15_fifo_cap { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName spmv_csc_flow_control_loop_pipe_sequential_init_U
set CompName spmv_csc_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix spmv_csc_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


