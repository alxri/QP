create_project prj -part xczu7ev-ffvc1156-2-e -force
set_property target_language verilog [current_project]
set vivado_ver [version -short]
set COE_DIR "../../syn/verilog"
source "/home/romoirib/QP/spmv_csc_tmp/spmv_csc/spmv_csc/hls/syn/verilog/spmv_csc_fadd_32ns_32ns_32_5_no_dsp_1_ip.tcl"
source "/home/romoirib/QP/spmv_csc_tmp/spmv_csc/spmv_csc/hls/syn/verilog/spmv_csc_fmul_32ns_32ns_32_4_max_dsp_1_ip.tcl"
source "/home/romoirib/QP/spmv_csc_tmp/spmv_csc/spmv_csc/hls/syn/verilog/spmv_csc_fadd_32ns_32ns_32_8_full_dsp_1_ip.tcl"
