set moduleName distribute_to_pe_Pipeline_VITIS_LOOP_230_3
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
set C_modelName {distribute_to_pe_Pipeline_VITIS_LOOP_230_3}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ pe_streams_0 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_1 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_2 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_3 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_4 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_5 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_6 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_7 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_8 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_9 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_10 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_11 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_12 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_13 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_14 int 97 regular {fifo 1 volatile }  }
	{ pe_streams_15 int 97 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "pe_streams_0", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_1", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_2", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_3", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_4", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_5", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_6", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_7", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_8", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_9", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_10", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_11", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_12", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_13", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_14", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} , 
 	{ "Name" : "pe_streams_15", "interface" : "fifo", "bitwidth" : 97, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 86
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ pe_streams_14_din sc_out sc_lv 97 signal 14 } 
	{ pe_streams_14_full_n sc_in sc_logic 1 signal 14 } 
	{ pe_streams_14_write sc_out sc_logic 1 signal 14 } 
	{ pe_streams_14_num_data_valid sc_in sc_lv 32 signal 14 } 
	{ pe_streams_14_fifo_cap sc_in sc_lv 32 signal 14 } 
	{ pe_streams_13_din sc_out sc_lv 97 signal 13 } 
	{ pe_streams_13_full_n sc_in sc_logic 1 signal 13 } 
	{ pe_streams_13_write sc_out sc_logic 1 signal 13 } 
	{ pe_streams_13_num_data_valid sc_in sc_lv 32 signal 13 } 
	{ pe_streams_13_fifo_cap sc_in sc_lv 32 signal 13 } 
	{ pe_streams_12_din sc_out sc_lv 97 signal 12 } 
	{ pe_streams_12_full_n sc_in sc_logic 1 signal 12 } 
	{ pe_streams_12_write sc_out sc_logic 1 signal 12 } 
	{ pe_streams_12_num_data_valid sc_in sc_lv 32 signal 12 } 
	{ pe_streams_12_fifo_cap sc_in sc_lv 32 signal 12 } 
	{ pe_streams_11_din sc_out sc_lv 97 signal 11 } 
	{ pe_streams_11_full_n sc_in sc_logic 1 signal 11 } 
	{ pe_streams_11_write sc_out sc_logic 1 signal 11 } 
	{ pe_streams_11_num_data_valid sc_in sc_lv 32 signal 11 } 
	{ pe_streams_11_fifo_cap sc_in sc_lv 32 signal 11 } 
	{ pe_streams_10_din sc_out sc_lv 97 signal 10 } 
	{ pe_streams_10_full_n sc_in sc_logic 1 signal 10 } 
	{ pe_streams_10_write sc_out sc_logic 1 signal 10 } 
	{ pe_streams_10_num_data_valid sc_in sc_lv 32 signal 10 } 
	{ pe_streams_10_fifo_cap sc_in sc_lv 32 signal 10 } 
	{ pe_streams_9_din sc_out sc_lv 97 signal 9 } 
	{ pe_streams_9_full_n sc_in sc_logic 1 signal 9 } 
	{ pe_streams_9_write sc_out sc_logic 1 signal 9 } 
	{ pe_streams_9_num_data_valid sc_in sc_lv 32 signal 9 } 
	{ pe_streams_9_fifo_cap sc_in sc_lv 32 signal 9 } 
	{ pe_streams_8_din sc_out sc_lv 97 signal 8 } 
	{ pe_streams_8_full_n sc_in sc_logic 1 signal 8 } 
	{ pe_streams_8_write sc_out sc_logic 1 signal 8 } 
	{ pe_streams_8_num_data_valid sc_in sc_lv 32 signal 8 } 
	{ pe_streams_8_fifo_cap sc_in sc_lv 32 signal 8 } 
	{ pe_streams_7_din sc_out sc_lv 97 signal 7 } 
	{ pe_streams_7_full_n sc_in sc_logic 1 signal 7 } 
	{ pe_streams_7_write sc_out sc_logic 1 signal 7 } 
	{ pe_streams_7_num_data_valid sc_in sc_lv 32 signal 7 } 
	{ pe_streams_7_fifo_cap sc_in sc_lv 32 signal 7 } 
	{ pe_streams_6_din sc_out sc_lv 97 signal 6 } 
	{ pe_streams_6_full_n sc_in sc_logic 1 signal 6 } 
	{ pe_streams_6_write sc_out sc_logic 1 signal 6 } 
	{ pe_streams_6_num_data_valid sc_in sc_lv 32 signal 6 } 
	{ pe_streams_6_fifo_cap sc_in sc_lv 32 signal 6 } 
	{ pe_streams_5_din sc_out sc_lv 97 signal 5 } 
	{ pe_streams_5_full_n sc_in sc_logic 1 signal 5 } 
	{ pe_streams_5_write sc_out sc_logic 1 signal 5 } 
	{ pe_streams_5_num_data_valid sc_in sc_lv 32 signal 5 } 
	{ pe_streams_5_fifo_cap sc_in sc_lv 32 signal 5 } 
	{ pe_streams_4_din sc_out sc_lv 97 signal 4 } 
	{ pe_streams_4_full_n sc_in sc_logic 1 signal 4 } 
	{ pe_streams_4_write sc_out sc_logic 1 signal 4 } 
	{ pe_streams_4_num_data_valid sc_in sc_lv 32 signal 4 } 
	{ pe_streams_4_fifo_cap sc_in sc_lv 32 signal 4 } 
	{ pe_streams_3_din sc_out sc_lv 97 signal 3 } 
	{ pe_streams_3_full_n sc_in sc_logic 1 signal 3 } 
	{ pe_streams_3_write sc_out sc_logic 1 signal 3 } 
	{ pe_streams_3_num_data_valid sc_in sc_lv 32 signal 3 } 
	{ pe_streams_3_fifo_cap sc_in sc_lv 32 signal 3 } 
	{ pe_streams_2_din sc_out sc_lv 97 signal 2 } 
	{ pe_streams_2_full_n sc_in sc_logic 1 signal 2 } 
	{ pe_streams_2_write sc_out sc_logic 1 signal 2 } 
	{ pe_streams_2_num_data_valid sc_in sc_lv 32 signal 2 } 
	{ pe_streams_2_fifo_cap sc_in sc_lv 32 signal 2 } 
	{ pe_streams_1_din sc_out sc_lv 97 signal 1 } 
	{ pe_streams_1_full_n sc_in sc_logic 1 signal 1 } 
	{ pe_streams_1_write sc_out sc_logic 1 signal 1 } 
	{ pe_streams_1_num_data_valid sc_in sc_lv 32 signal 1 } 
	{ pe_streams_1_fifo_cap sc_in sc_lv 32 signal 1 } 
	{ pe_streams_0_din sc_out sc_lv 97 signal 0 } 
	{ pe_streams_0_full_n sc_in sc_logic 1 signal 0 } 
	{ pe_streams_0_write sc_out sc_logic 1 signal 0 } 
	{ pe_streams_0_num_data_valid sc_in sc_lv 32 signal 0 } 
	{ pe_streams_0_fifo_cap sc_in sc_lv 32 signal 0 } 
	{ pe_streams_15_din sc_out sc_lv 97 signal 15 } 
	{ pe_streams_15_full_n sc_in sc_logic 1 signal 15 } 
	{ pe_streams_15_write sc_out sc_logic 1 signal 15 } 
	{ pe_streams_15_num_data_valid sc_in sc_lv 32 signal 15 } 
	{ pe_streams_15_fifo_cap sc_in sc_lv 32 signal 15 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "pe_streams_14_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "din" }} , 
 	{ "name": "pe_streams_14_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "full_n" }} , 
 	{ "name": "pe_streams_14_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "write" }} , 
 	{ "name": "pe_streams_14_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_14_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_14", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_13_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_13", "role": "din" }} , 
 	{ "name": "pe_streams_13_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_13", "role": "full_n" }} , 
 	{ "name": "pe_streams_13_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_13", "role": "write" }} , 
 	{ "name": "pe_streams_13_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_13", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_13_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_13", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_12_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_12", "role": "din" }} , 
 	{ "name": "pe_streams_12_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_12", "role": "full_n" }} , 
 	{ "name": "pe_streams_12_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_12", "role": "write" }} , 
 	{ "name": "pe_streams_12_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_12", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_12_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_12", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_11_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_11", "role": "din" }} , 
 	{ "name": "pe_streams_11_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_11", "role": "full_n" }} , 
 	{ "name": "pe_streams_11_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_11", "role": "write" }} , 
 	{ "name": "pe_streams_11_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_11", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_11_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_11", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_10_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_10", "role": "din" }} , 
 	{ "name": "pe_streams_10_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_10", "role": "full_n" }} , 
 	{ "name": "pe_streams_10_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_10", "role": "write" }} , 
 	{ "name": "pe_streams_10_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_10", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_10_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_10", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_9_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_9", "role": "din" }} , 
 	{ "name": "pe_streams_9_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_9", "role": "full_n" }} , 
 	{ "name": "pe_streams_9_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_9", "role": "write" }} , 
 	{ "name": "pe_streams_9_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_9", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_9_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_9", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_8_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_8", "role": "din" }} , 
 	{ "name": "pe_streams_8_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_8", "role": "full_n" }} , 
 	{ "name": "pe_streams_8_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_8", "role": "write" }} , 
 	{ "name": "pe_streams_8_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_8", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_8_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_8", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_7_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_7", "role": "din" }} , 
 	{ "name": "pe_streams_7_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_7", "role": "full_n" }} , 
 	{ "name": "pe_streams_7_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_7", "role": "write" }} , 
 	{ "name": "pe_streams_7_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_7", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_7_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_7", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_6_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_6", "role": "din" }} , 
 	{ "name": "pe_streams_6_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_6", "role": "full_n" }} , 
 	{ "name": "pe_streams_6_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_6", "role": "write" }} , 
 	{ "name": "pe_streams_6_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_6", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_6_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_6", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_5_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_5", "role": "din" }} , 
 	{ "name": "pe_streams_5_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_5", "role": "full_n" }} , 
 	{ "name": "pe_streams_5_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_5", "role": "write" }} , 
 	{ "name": "pe_streams_5_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_5", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_5_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_5", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_4_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_4", "role": "din" }} , 
 	{ "name": "pe_streams_4_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_4", "role": "full_n" }} , 
 	{ "name": "pe_streams_4_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_4", "role": "write" }} , 
 	{ "name": "pe_streams_4_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_4", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_4_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_4", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_3_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_3", "role": "din" }} , 
 	{ "name": "pe_streams_3_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_3", "role": "full_n" }} , 
 	{ "name": "pe_streams_3_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_3", "role": "write" }} , 
 	{ "name": "pe_streams_3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_3", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_3", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_2", "role": "din" }} , 
 	{ "name": "pe_streams_2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_2", "role": "full_n" }} , 
 	{ "name": "pe_streams_2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_2", "role": "write" }} , 
 	{ "name": "pe_streams_2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_2", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_2", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_1", "role": "din" }} , 
 	{ "name": "pe_streams_1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_1", "role": "full_n" }} , 
 	{ "name": "pe_streams_1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_1", "role": "write" }} , 
 	{ "name": "pe_streams_1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_1", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_1", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_0_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_0", "role": "din" }} , 
 	{ "name": "pe_streams_0_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_0", "role": "full_n" }} , 
 	{ "name": "pe_streams_0_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_0", "role": "write" }} , 
 	{ "name": "pe_streams_0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_0", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_0", "role": "fifo_cap" }} , 
 	{ "name": "pe_streams_15_din", "direction": "out", "datatype": "sc_lv", "bitwidth":97, "type": "signal", "bundle":{"name": "pe_streams_15", "role": "din" }} , 
 	{ "name": "pe_streams_15_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_15", "role": "full_n" }} , 
 	{ "name": "pe_streams_15_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "pe_streams_15", "role": "write" }} , 
 	{ "name": "pe_streams_15_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_15", "role": "num_data_valid" }} , 
 	{ "name": "pe_streams_15_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "pe_streams_15", "role": "fifo_cap" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "distribute_to_pe_Pipeline_VITIS_LOOP_230_3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "18", "EstimateLatencyMax" : "18",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "pe_streams_0", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_0_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_1", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_2", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_3", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_4", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_4_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_5", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_5_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_6", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_6_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_7", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_7_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_8", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_8_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_9", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_9_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_10", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_10_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_11", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_11_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_12", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_12_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_13", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_13_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_14", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_14_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_15", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "pe_streams_15_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_230_3", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	distribute_to_pe_Pipeline_VITIS_LOOP_230_3 {
		pe_streams_0 {Type O LastRead -1 FirstWrite 1}
		pe_streams_1 {Type O LastRead -1 FirstWrite 1}
		pe_streams_2 {Type O LastRead -1 FirstWrite 1}
		pe_streams_3 {Type O LastRead -1 FirstWrite 1}
		pe_streams_4 {Type O LastRead -1 FirstWrite 1}
		pe_streams_5 {Type O LastRead -1 FirstWrite 1}
		pe_streams_6 {Type O LastRead -1 FirstWrite 1}
		pe_streams_7 {Type O LastRead -1 FirstWrite 1}
		pe_streams_8 {Type O LastRead -1 FirstWrite 1}
		pe_streams_9 {Type O LastRead -1 FirstWrite 1}
		pe_streams_10 {Type O LastRead -1 FirstWrite 1}
		pe_streams_11 {Type O LastRead -1 FirstWrite 1}
		pe_streams_12 {Type O LastRead -1 FirstWrite 1}
		pe_streams_13 {Type O LastRead -1 FirstWrite 1}
		pe_streams_14 {Type O LastRead -1 FirstWrite 1}
		pe_streams_15 {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "18"}
	, {"Name" : "Interval", "Min" : "18", "Max" : "18"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	pe_streams_0 { ap_fifo {  { pe_streams_0_din fifo_data_in 1 97 }  { pe_streams_0_full_n fifo_status 0 1 }  { pe_streams_0_write fifo_port_we 1 1 }  { pe_streams_0_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_0_fifo_cap fifo_update 0 32 } } }
	pe_streams_1 { ap_fifo {  { pe_streams_1_din fifo_data_in 1 97 }  { pe_streams_1_full_n fifo_status 0 1 }  { pe_streams_1_write fifo_port_we 1 1 }  { pe_streams_1_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_1_fifo_cap fifo_update 0 32 } } }
	pe_streams_2 { ap_fifo {  { pe_streams_2_din fifo_data_in 1 97 }  { pe_streams_2_full_n fifo_status 0 1 }  { pe_streams_2_write fifo_port_we 1 1 }  { pe_streams_2_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_2_fifo_cap fifo_update 0 32 } } }
	pe_streams_3 { ap_fifo {  { pe_streams_3_din fifo_data_in 1 97 }  { pe_streams_3_full_n fifo_status 0 1 }  { pe_streams_3_write fifo_port_we 1 1 }  { pe_streams_3_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_3_fifo_cap fifo_update 0 32 } } }
	pe_streams_4 { ap_fifo {  { pe_streams_4_din fifo_data_in 1 97 }  { pe_streams_4_full_n fifo_status 0 1 }  { pe_streams_4_write fifo_port_we 1 1 }  { pe_streams_4_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_4_fifo_cap fifo_update 0 32 } } }
	pe_streams_5 { ap_fifo {  { pe_streams_5_din fifo_data_in 1 97 }  { pe_streams_5_full_n fifo_status 0 1 }  { pe_streams_5_write fifo_port_we 1 1 }  { pe_streams_5_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_5_fifo_cap fifo_update 0 32 } } }
	pe_streams_6 { ap_fifo {  { pe_streams_6_din fifo_data_in 1 97 }  { pe_streams_6_full_n fifo_status 0 1 }  { pe_streams_6_write fifo_port_we 1 1 }  { pe_streams_6_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_6_fifo_cap fifo_update 0 32 } } }
	pe_streams_7 { ap_fifo {  { pe_streams_7_din fifo_data_in 1 97 }  { pe_streams_7_full_n fifo_status 0 1 }  { pe_streams_7_write fifo_port_we 1 1 }  { pe_streams_7_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_7_fifo_cap fifo_update 0 32 } } }
	pe_streams_8 { ap_fifo {  { pe_streams_8_din fifo_data_in 1 97 }  { pe_streams_8_full_n fifo_status 0 1 }  { pe_streams_8_write fifo_port_we 1 1 }  { pe_streams_8_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_8_fifo_cap fifo_update 0 32 } } }
	pe_streams_9 { ap_fifo {  { pe_streams_9_din fifo_data_in 1 97 }  { pe_streams_9_full_n fifo_status 0 1 }  { pe_streams_9_write fifo_port_we 1 1 }  { pe_streams_9_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_9_fifo_cap fifo_update 0 32 } } }
	pe_streams_10 { ap_fifo {  { pe_streams_10_din fifo_data_in 1 97 }  { pe_streams_10_full_n fifo_status 0 1 }  { pe_streams_10_write fifo_port_we 1 1 }  { pe_streams_10_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_10_fifo_cap fifo_update 0 32 } } }
	pe_streams_11 { ap_fifo {  { pe_streams_11_din fifo_data_in 1 97 }  { pe_streams_11_full_n fifo_status 0 1 }  { pe_streams_11_write fifo_port_we 1 1 }  { pe_streams_11_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_11_fifo_cap fifo_update 0 32 } } }
	pe_streams_12 { ap_fifo {  { pe_streams_12_din fifo_data_in 1 97 }  { pe_streams_12_full_n fifo_status 0 1 }  { pe_streams_12_write fifo_port_we 1 1 }  { pe_streams_12_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_12_fifo_cap fifo_update 0 32 } } }
	pe_streams_13 { ap_fifo {  { pe_streams_13_din fifo_data_in 1 97 }  { pe_streams_13_full_n fifo_status 0 1 }  { pe_streams_13_write fifo_port_we 1 1 }  { pe_streams_13_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_13_fifo_cap fifo_update 0 32 } } }
	pe_streams_14 { ap_fifo {  { pe_streams_14_din fifo_data_in 1 97 }  { pe_streams_14_full_n fifo_status 0 1 }  { pe_streams_14_write fifo_port_we 1 1 }  { pe_streams_14_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_14_fifo_cap fifo_update 0 32 } } }
	pe_streams_15 { ap_fifo {  { pe_streams_15_din fifo_data_in 1 97 }  { pe_streams_15_full_n fifo_status 0 1 }  { pe_streams_15_write fifo_port_we 1 1 }  { pe_streams_15_num_data_valid fifo_status_num_data_valid 0 32 }  { pe_streams_15_fifo_cap fifo_update 0 32 } } }
}
