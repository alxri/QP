set moduleName compute_pe_14_Pipeline_VITIS_LOOP_251_2
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 62
set C_modelName {compute_pe.14_Pipeline_VITIS_LOOP_251_2}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict y_partial { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 0 }
set C_modelArgList {
	{ pe_streams_14 int 97 regular {fifo 0 volatile }  }
	{ num_rows_10 int 32 regular  }
	{ y_partial float 32 regular {array 1024 { 2 3 } 1 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "pe_streams_14", "interface" : "fifo", "bitwidth" : 97, "direction" : "READONLY"} , 
 	{ "Name" : "num_rows_10", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} ]}
# RTL Port declarations: 
set portNum 17
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ pe_streams_14_dout sc_in sc_lv 97 signal 0 } 
	{ pe_streams_14_empty_n sc_in sc_logic 1 signal 0 } 
	{ pe_streams_14_read sc_out sc_logic 1 signal 0 } 
	{ pe_streams_14_num_data_valid sc_in sc_lv 9 signal 0 } 
	{ pe_streams_14_fifo_cap sc_in sc_lv 9 signal 0 } 
	{ num_rows_10 sc_in sc_lv 32 signal 1 } 
	{ y_partial_address0 sc_out sc_lv 10 signal 2 } 
	{ y_partial_ce0 sc_out sc_logic 1 signal 2 } 
	{ y_partial_we0 sc_out sc_logic 1 signal 2 } 
	{ y_partial_d0 sc_out sc_lv 32 signal 2 } 
	{ y_partial_q0 sc_in sc_lv 32 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "pe_streams_14_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "dout" }} , 
 	{ "name": "pe_streams_14_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "empty_n" }} , 
 	{ "name": "pe_streams_14_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "read" }} , 
 	{ "name": "pe_streams_14_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_14_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_10", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_10", "role": "default" }} , 
 	{ "name": "y_partial_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial", "role": "address0" }} , 
 	{ "name": "y_partial_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial", "role": "ce0" }} , 
 	{ "name": "y_partial_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial", "role": "we0" }} , 
 	{ "name": "y_partial_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial", "role": "d0" }} , 
 	{ "name": "y_partial_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial", "role": "q0" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3"],
		"CDFG" : "compute_pe_14_Pipeline_VITIS_LOOP_251_2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "pe_streams_14", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_14_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_10", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fadd_32ns_32ns_32_5_no_dsp_1_U279", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fmul_32ns_32ns_32_4_max_dsp_1_U280", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	compute_pe_14_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_14 {Type I LastRead 0 FirstWrite -1}
		num_rows_10 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	pe_streams_14 { ap_fifo {  { pe_streams_14_dout fifo_data_in 0 97 }  { pe_streams_14_empty_n fifo_status 0 1 }  { pe_streams_14_read fifo_port_we 1 1 }  { pe_streams_14_num_data_valid fifo_status_num_data_valid 0 9 }  { pe_streams_14_fifo_cap fifo_update 0 9 } } }
	num_rows_10 { ap_none {  { num_rows_10 in_data 0 32 } } }
	y_partial { ap_memory {  { y_partial_address0 mem_address 1 10 }  { y_partial_ce0 mem_ce 1 1 }  { y_partial_we0 mem_we 1 1 }  { y_partial_d0 mem_din 1 32 }  { y_partial_q0 mem_dout 0 32 } } }
}
