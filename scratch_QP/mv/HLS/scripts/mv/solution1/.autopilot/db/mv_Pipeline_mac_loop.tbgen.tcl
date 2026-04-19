set moduleName mv_Pipeline_mac_loop
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
set cdfgNum 6
set C_modelName {mv_Pipeline_mac_loop}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict row_buf { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_1 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_2 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_3 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_4 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_5 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_6 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict row_buf_7 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_1 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_2 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_3 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_4 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_5 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_6 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict x_buf_7 { MEM_WIDTH 32 MEM_SIZE 256 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ columns int 31 regular  }
	{ row_buf float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_1 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_2 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_3 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_4 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_5 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_6 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ row_buf_7 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_1 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_2 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_3 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_4 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_5 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_6 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ x_buf_7 float 32 regular {array 64 { 1 3 } 1 1 }  }
	{ acc_out float 32 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "columns", "interface" : "wire", "bitwidth" : 31, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "row_buf_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "x_buf_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "acc_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 57
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ columns sc_in sc_lv 31 signal 0 } 
	{ row_buf_address0 sc_out sc_lv 6 signal 1 } 
	{ row_buf_ce0 sc_out sc_logic 1 signal 1 } 
	{ row_buf_q0 sc_in sc_lv 32 signal 1 } 
	{ row_buf_1_address0 sc_out sc_lv 6 signal 2 } 
	{ row_buf_1_ce0 sc_out sc_logic 1 signal 2 } 
	{ row_buf_1_q0 sc_in sc_lv 32 signal 2 } 
	{ row_buf_2_address0 sc_out sc_lv 6 signal 3 } 
	{ row_buf_2_ce0 sc_out sc_logic 1 signal 3 } 
	{ row_buf_2_q0 sc_in sc_lv 32 signal 3 } 
	{ row_buf_3_address0 sc_out sc_lv 6 signal 4 } 
	{ row_buf_3_ce0 sc_out sc_logic 1 signal 4 } 
	{ row_buf_3_q0 sc_in sc_lv 32 signal 4 } 
	{ row_buf_4_address0 sc_out sc_lv 6 signal 5 } 
	{ row_buf_4_ce0 sc_out sc_logic 1 signal 5 } 
	{ row_buf_4_q0 sc_in sc_lv 32 signal 5 } 
	{ row_buf_5_address0 sc_out sc_lv 6 signal 6 } 
	{ row_buf_5_ce0 sc_out sc_logic 1 signal 6 } 
	{ row_buf_5_q0 sc_in sc_lv 32 signal 6 } 
	{ row_buf_6_address0 sc_out sc_lv 6 signal 7 } 
	{ row_buf_6_ce0 sc_out sc_logic 1 signal 7 } 
	{ row_buf_6_q0 sc_in sc_lv 32 signal 7 } 
	{ row_buf_7_address0 sc_out sc_lv 6 signal 8 } 
	{ row_buf_7_ce0 sc_out sc_logic 1 signal 8 } 
	{ row_buf_7_q0 sc_in sc_lv 32 signal 8 } 
	{ x_buf_address0 sc_out sc_lv 6 signal 9 } 
	{ x_buf_ce0 sc_out sc_logic 1 signal 9 } 
	{ x_buf_q0 sc_in sc_lv 32 signal 9 } 
	{ x_buf_1_address0 sc_out sc_lv 6 signal 10 } 
	{ x_buf_1_ce0 sc_out sc_logic 1 signal 10 } 
	{ x_buf_1_q0 sc_in sc_lv 32 signal 10 } 
	{ x_buf_2_address0 sc_out sc_lv 6 signal 11 } 
	{ x_buf_2_ce0 sc_out sc_logic 1 signal 11 } 
	{ x_buf_2_q0 sc_in sc_lv 32 signal 11 } 
	{ x_buf_3_address0 sc_out sc_lv 6 signal 12 } 
	{ x_buf_3_ce0 sc_out sc_logic 1 signal 12 } 
	{ x_buf_3_q0 sc_in sc_lv 32 signal 12 } 
	{ x_buf_4_address0 sc_out sc_lv 6 signal 13 } 
	{ x_buf_4_ce0 sc_out sc_logic 1 signal 13 } 
	{ x_buf_4_q0 sc_in sc_lv 32 signal 13 } 
	{ x_buf_5_address0 sc_out sc_lv 6 signal 14 } 
	{ x_buf_5_ce0 sc_out sc_logic 1 signal 14 } 
	{ x_buf_5_q0 sc_in sc_lv 32 signal 14 } 
	{ x_buf_6_address0 sc_out sc_lv 6 signal 15 } 
	{ x_buf_6_ce0 sc_out sc_logic 1 signal 15 } 
	{ x_buf_6_q0 sc_in sc_lv 32 signal 15 } 
	{ x_buf_7_address0 sc_out sc_lv 6 signal 16 } 
	{ x_buf_7_ce0 sc_out sc_logic 1 signal 16 } 
	{ x_buf_7_q0 sc_in sc_lv 32 signal 16 } 
	{ acc_out sc_out sc_lv 32 signal 17 } 
	{ acc_out_ap_vld sc_out sc_logic 1 outvld 17 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "columns", "direction": "in", "datatype": "sc_lv", "bitwidth":31, "type": "signal", "bundle":{"name": "columns", "role": "default" }} , 
 	{ "name": "row_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf", "role": "address0" }} , 
 	{ "name": "row_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf", "role": "ce0" }} , 
 	{ "name": "row_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf", "role": "q0" }} , 
 	{ "name": "row_buf_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_1", "role": "address0" }} , 
 	{ "name": "row_buf_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_1", "role": "ce0" }} , 
 	{ "name": "row_buf_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_1", "role": "q0" }} , 
 	{ "name": "row_buf_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_2", "role": "address0" }} , 
 	{ "name": "row_buf_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_2", "role": "ce0" }} , 
 	{ "name": "row_buf_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_2", "role": "q0" }} , 
 	{ "name": "row_buf_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_3", "role": "address0" }} , 
 	{ "name": "row_buf_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_3", "role": "ce0" }} , 
 	{ "name": "row_buf_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_3", "role": "q0" }} , 
 	{ "name": "row_buf_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_4", "role": "address0" }} , 
 	{ "name": "row_buf_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_4", "role": "ce0" }} , 
 	{ "name": "row_buf_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_4", "role": "q0" }} , 
 	{ "name": "row_buf_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_5", "role": "address0" }} , 
 	{ "name": "row_buf_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_5", "role": "ce0" }} , 
 	{ "name": "row_buf_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_5", "role": "q0" }} , 
 	{ "name": "row_buf_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_6", "role": "address0" }} , 
 	{ "name": "row_buf_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_6", "role": "ce0" }} , 
 	{ "name": "row_buf_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_6", "role": "q0" }} , 
 	{ "name": "row_buf_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "row_buf_7", "role": "address0" }} , 
 	{ "name": "row_buf_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "row_buf_7", "role": "ce0" }} , 
 	{ "name": "row_buf_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "row_buf_7", "role": "q0" }} , 
 	{ "name": "x_buf_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf", "role": "address0" }} , 
 	{ "name": "x_buf_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf", "role": "ce0" }} , 
 	{ "name": "x_buf_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf", "role": "q0" }} , 
 	{ "name": "x_buf_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_1", "role": "address0" }} , 
 	{ "name": "x_buf_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_1", "role": "ce0" }} , 
 	{ "name": "x_buf_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_1", "role": "q0" }} , 
 	{ "name": "x_buf_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_2", "role": "address0" }} , 
 	{ "name": "x_buf_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_2", "role": "ce0" }} , 
 	{ "name": "x_buf_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_2", "role": "q0" }} , 
 	{ "name": "x_buf_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_3", "role": "address0" }} , 
 	{ "name": "x_buf_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_3", "role": "ce0" }} , 
 	{ "name": "x_buf_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_3", "role": "q0" }} , 
 	{ "name": "x_buf_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_4", "role": "address0" }} , 
 	{ "name": "x_buf_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_4", "role": "ce0" }} , 
 	{ "name": "x_buf_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_4", "role": "q0" }} , 
 	{ "name": "x_buf_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_5", "role": "address0" }} , 
 	{ "name": "x_buf_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_5", "role": "ce0" }} , 
 	{ "name": "x_buf_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_5", "role": "q0" }} , 
 	{ "name": "x_buf_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_6", "role": "address0" }} , 
 	{ "name": "x_buf_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_6", "role": "ce0" }} , 
 	{ "name": "x_buf_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_6", "role": "q0" }} , 
 	{ "name": "x_buf_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "x_buf_7", "role": "address0" }} , 
 	{ "name": "x_buf_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "x_buf_7", "role": "ce0" }} , 
 	{ "name": "x_buf_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "x_buf_7", "role": "q0" }} , 
 	{ "name": "acc_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "acc_out", "role": "default" }} , 
 	{ "name": "acc_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "acc_out", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5"],
		"CDFG" : "mv_Pipeline_mac_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "10", "EstimateLatencyMax" : "1543",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "columns", "Type" : "None", "Direction" : "I"},
			{"Name" : "row_buf", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_1", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_2", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_3", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_4", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_5", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_6", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "row_buf_7", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_1", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_2", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_3", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_4", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_5", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_6", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "x_buf_7", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "acc_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "mac_loop", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "3", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage2", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage2_subdone", "QuitState" : "ap_ST_fsm_pp0_stage2", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage2_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fadd_32ns_32ns_32_4_full_dsp_1_U23", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fmul_32ns_32ns_32_3_max_dsp_1_U24", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_17_3_32_1_1_U25", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.sparsemux_17_3_32_1_1_U26", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	mv_Pipeline_mac_loop {
		columns {Type I LastRead 0 FirstWrite -1}
		row_buf {Type I LastRead 0 FirstWrite -1}
		row_buf_1 {Type I LastRead 0 FirstWrite -1}
		row_buf_2 {Type I LastRead 0 FirstWrite -1}
		row_buf_3 {Type I LastRead 0 FirstWrite -1}
		row_buf_4 {Type I LastRead 0 FirstWrite -1}
		row_buf_5 {Type I LastRead 0 FirstWrite -1}
		row_buf_6 {Type I LastRead 0 FirstWrite -1}
		row_buf_7 {Type I LastRead 0 FirstWrite -1}
		x_buf {Type I LastRead 0 FirstWrite -1}
		x_buf_1 {Type I LastRead 0 FirstWrite -1}
		x_buf_2 {Type I LastRead 0 FirstWrite -1}
		x_buf_3 {Type I LastRead 0 FirstWrite -1}
		x_buf_4 {Type I LastRead 0 FirstWrite -1}
		x_buf_5 {Type I LastRead 0 FirstWrite -1}
		x_buf_6 {Type I LastRead 0 FirstWrite -1}
		x_buf_7 {Type I LastRead 0 FirstWrite -1}
		acc_out {Type O LastRead -1 FirstWrite 5}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "10", "Max" : "1543"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "1543"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	columns { ap_none {  { columns in_data 0 31 } } }
	row_buf { ap_memory {  { row_buf_address0 mem_address 1 6 }  { row_buf_ce0 mem_ce 1 1 }  { row_buf_q0 mem_dout 0 32 } } }
	row_buf_1 { ap_memory {  { row_buf_1_address0 mem_address 1 6 }  { row_buf_1_ce0 mem_ce 1 1 }  { row_buf_1_q0 mem_dout 0 32 } } }
	row_buf_2 { ap_memory {  { row_buf_2_address0 mem_address 1 6 }  { row_buf_2_ce0 mem_ce 1 1 }  { row_buf_2_q0 mem_dout 0 32 } } }
	row_buf_3 { ap_memory {  { row_buf_3_address0 mem_address 1 6 }  { row_buf_3_ce0 mem_ce 1 1 }  { row_buf_3_q0 mem_dout 0 32 } } }
	row_buf_4 { ap_memory {  { row_buf_4_address0 mem_address 1 6 }  { row_buf_4_ce0 mem_ce 1 1 }  { row_buf_4_q0 mem_dout 0 32 } } }
	row_buf_5 { ap_memory {  { row_buf_5_address0 mem_address 1 6 }  { row_buf_5_ce0 mem_ce 1 1 }  { row_buf_5_q0 mem_dout 0 32 } } }
	row_buf_6 { ap_memory {  { row_buf_6_address0 mem_address 1 6 }  { row_buf_6_ce0 mem_ce 1 1 }  { row_buf_6_q0 mem_dout 0 32 } } }
	row_buf_7 { ap_memory {  { row_buf_7_address0 mem_address 1 6 }  { row_buf_7_ce0 mem_ce 1 1 }  { row_buf_7_q0 mem_dout 0 32 } } }
	x_buf { ap_memory {  { x_buf_address0 mem_address 1 6 }  { x_buf_ce0 mem_ce 1 1 }  { x_buf_q0 mem_dout 0 32 } } }
	x_buf_1 { ap_memory {  { x_buf_1_address0 mem_address 1 6 }  { x_buf_1_ce0 mem_ce 1 1 }  { x_buf_1_q0 mem_dout 0 32 } } }
	x_buf_2 { ap_memory {  { x_buf_2_address0 mem_address 1 6 }  { x_buf_2_ce0 mem_ce 1 1 }  { x_buf_2_q0 mem_dout 0 32 } } }
	x_buf_3 { ap_memory {  { x_buf_3_address0 mem_address 1 6 }  { x_buf_3_ce0 mem_ce 1 1 }  { x_buf_3_q0 mem_dout 0 32 } } }
	x_buf_4 { ap_memory {  { x_buf_4_address0 mem_address 1 6 }  { x_buf_4_ce0 mem_ce 1 1 }  { x_buf_4_q0 mem_dout 0 32 } } }
	x_buf_5 { ap_memory {  { x_buf_5_address0 mem_address 1 6 }  { x_buf_5_ce0 mem_ce 1 1 }  { x_buf_5_q0 mem_dout 0 32 } } }
	x_buf_6 { ap_memory {  { x_buf_6_address0 mem_address 1 6 }  { x_buf_6_ce0 mem_ce 1 1 }  { x_buf_6_q0 mem_dout 0 32 } } }
	x_buf_7 { ap_memory {  { x_buf_7_address0 mem_address 1 6 }  { x_buf_7_ce0 mem_ce 1 1 }  { x_buf_7_q0 mem_dout 0 32 } } }
	acc_out { ap_vld {  { acc_out out_data 1 32 }  { acc_out_ap_vld out_vld 1 1 } } }
}
