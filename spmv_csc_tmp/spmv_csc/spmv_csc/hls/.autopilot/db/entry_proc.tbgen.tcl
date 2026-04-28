set moduleName entry_proc
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 1
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 62
set C_modelName {entry_proc}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ num_rows int 32 regular  }
	{ num_rows_c int 32 regular {fifo 1}  }
	{ num_rows_c2 int 32 regular {fifo 1}  }
	{ num_rows_c3 int 32 regular {fifo 1}  }
	{ num_rows_c4 int 32 regular {fifo 1}  }
	{ num_rows_c5 int 32 regular {fifo 1}  }
	{ num_rows_c6 int 32 regular {fifo 1}  }
	{ num_rows_c7 int 32 regular {fifo 1}  }
	{ num_rows_c8 int 32 regular {fifo 1}  }
	{ num_rows_c9 int 32 regular {fifo 1}  }
	{ num_rows_c10 int 32 regular {fifo 1}  }
	{ num_rows_c11 int 32 regular {fifo 1}  }
	{ num_rows_c12 int 32 regular {fifo 1}  }
	{ num_rows_c13 int 32 regular {fifo 1}  }
	{ num_rows_c14 int 32 regular {fifo 1}  }
	{ num_rows_c15 int 32 regular {fifo 1}  }
	{ num_rows_c16 int 32 regular {fifo 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "num_rows", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "num_rows_c", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c2", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c3", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c4", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c5", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c6", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c7", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c8", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c9", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c10", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c11", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c12", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c13", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c14", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c15", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "num_rows_c16", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 88
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ num_rows sc_in sc_lv 32 signal 0 } 
	{ num_rows_c_din sc_out sc_lv 32 signal 1 } 
	{ num_rows_c_full_n sc_in sc_logic 1 signal 1 } 
	{ num_rows_c_write sc_out sc_logic 1 signal 1 } 
	{ num_rows_c_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ num_rows_c_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ num_rows_c2_din sc_out sc_lv 32 signal 2 } 
	{ num_rows_c2_full_n sc_in sc_logic 1 signal 2 } 
	{ num_rows_c2_write sc_out sc_logic 1 signal 2 } 
	{ num_rows_c2_num_data_valid sc_in sc_lv 3 signal 2 } 
	{ num_rows_c2_fifo_cap sc_in sc_lv 3 signal 2 } 
	{ num_rows_c3_din sc_out sc_lv 32 signal 3 } 
	{ num_rows_c3_full_n sc_in sc_logic 1 signal 3 } 
	{ num_rows_c3_write sc_out sc_logic 1 signal 3 } 
	{ num_rows_c3_num_data_valid sc_in sc_lv 3 signal 3 } 
	{ num_rows_c3_fifo_cap sc_in sc_lv 3 signal 3 } 
	{ num_rows_c4_din sc_out sc_lv 32 signal 4 } 
	{ num_rows_c4_full_n sc_in sc_logic 1 signal 4 } 
	{ num_rows_c4_write sc_out sc_logic 1 signal 4 } 
	{ num_rows_c4_num_data_valid sc_in sc_lv 3 signal 4 } 
	{ num_rows_c4_fifo_cap sc_in sc_lv 3 signal 4 } 
	{ num_rows_c5_din sc_out sc_lv 32 signal 5 } 
	{ num_rows_c5_full_n sc_in sc_logic 1 signal 5 } 
	{ num_rows_c5_write sc_out sc_logic 1 signal 5 } 
	{ num_rows_c5_num_data_valid sc_in sc_lv 3 signal 5 } 
	{ num_rows_c5_fifo_cap sc_in sc_lv 3 signal 5 } 
	{ num_rows_c6_din sc_out sc_lv 32 signal 6 } 
	{ num_rows_c6_full_n sc_in sc_logic 1 signal 6 } 
	{ num_rows_c6_write sc_out sc_logic 1 signal 6 } 
	{ num_rows_c6_num_data_valid sc_in sc_lv 3 signal 6 } 
	{ num_rows_c6_fifo_cap sc_in sc_lv 3 signal 6 } 
	{ num_rows_c7_din sc_out sc_lv 32 signal 7 } 
	{ num_rows_c7_full_n sc_in sc_logic 1 signal 7 } 
	{ num_rows_c7_write sc_out sc_logic 1 signal 7 } 
	{ num_rows_c7_num_data_valid sc_in sc_lv 3 signal 7 } 
	{ num_rows_c7_fifo_cap sc_in sc_lv 3 signal 7 } 
	{ num_rows_c8_din sc_out sc_lv 32 signal 8 } 
	{ num_rows_c8_full_n sc_in sc_logic 1 signal 8 } 
	{ num_rows_c8_write sc_out sc_logic 1 signal 8 } 
	{ num_rows_c8_num_data_valid sc_in sc_lv 3 signal 8 } 
	{ num_rows_c8_fifo_cap sc_in sc_lv 3 signal 8 } 
	{ num_rows_c9_din sc_out sc_lv 32 signal 9 } 
	{ num_rows_c9_full_n sc_in sc_logic 1 signal 9 } 
	{ num_rows_c9_write sc_out sc_logic 1 signal 9 } 
	{ num_rows_c9_num_data_valid sc_in sc_lv 3 signal 9 } 
	{ num_rows_c9_fifo_cap sc_in sc_lv 3 signal 9 } 
	{ num_rows_c10_din sc_out sc_lv 32 signal 10 } 
	{ num_rows_c10_full_n sc_in sc_logic 1 signal 10 } 
	{ num_rows_c10_write sc_out sc_logic 1 signal 10 } 
	{ num_rows_c10_num_data_valid sc_in sc_lv 3 signal 10 } 
	{ num_rows_c10_fifo_cap sc_in sc_lv 3 signal 10 } 
	{ num_rows_c11_din sc_out sc_lv 32 signal 11 } 
	{ num_rows_c11_full_n sc_in sc_logic 1 signal 11 } 
	{ num_rows_c11_write sc_out sc_logic 1 signal 11 } 
	{ num_rows_c11_num_data_valid sc_in sc_lv 3 signal 11 } 
	{ num_rows_c11_fifo_cap sc_in sc_lv 3 signal 11 } 
	{ num_rows_c12_din sc_out sc_lv 32 signal 12 } 
	{ num_rows_c12_full_n sc_in sc_logic 1 signal 12 } 
	{ num_rows_c12_write sc_out sc_logic 1 signal 12 } 
	{ num_rows_c12_num_data_valid sc_in sc_lv 3 signal 12 } 
	{ num_rows_c12_fifo_cap sc_in sc_lv 3 signal 12 } 
	{ num_rows_c13_din sc_out sc_lv 32 signal 13 } 
	{ num_rows_c13_full_n sc_in sc_logic 1 signal 13 } 
	{ num_rows_c13_write sc_out sc_logic 1 signal 13 } 
	{ num_rows_c13_num_data_valid sc_in sc_lv 3 signal 13 } 
	{ num_rows_c13_fifo_cap sc_in sc_lv 3 signal 13 } 
	{ num_rows_c14_din sc_out sc_lv 32 signal 14 } 
	{ num_rows_c14_full_n sc_in sc_logic 1 signal 14 } 
	{ num_rows_c14_write sc_out sc_logic 1 signal 14 } 
	{ num_rows_c14_num_data_valid sc_in sc_lv 3 signal 14 } 
	{ num_rows_c14_fifo_cap sc_in sc_lv 3 signal 14 } 
	{ num_rows_c15_din sc_out sc_lv 32 signal 15 } 
	{ num_rows_c15_full_n sc_in sc_logic 1 signal 15 } 
	{ num_rows_c15_write sc_out sc_logic 1 signal 15 } 
	{ num_rows_c15_num_data_valid sc_in sc_lv 3 signal 15 } 
	{ num_rows_c15_fifo_cap sc_in sc_lv 3 signal 15 } 
	{ num_rows_c16_din sc_out sc_lv 32 signal 16 } 
	{ num_rows_c16_full_n sc_in sc_logic 1 signal 16 } 
	{ num_rows_c16_write sc_out sc_logic 1 signal 16 } 
	{ num_rows_c16_num_data_valid sc_in sc_lv 3 signal 16 } 
	{ num_rows_c16_fifo_cap sc_in sc_lv 3 signal 16 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "num_rows", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows", "role": "default" }} , 
 	{ "name": "num_rows_c_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c", "role": "din" }} , 
 	{ "name": "num_rows_c_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c", "role": "full_n" }} , 
 	{ "name": "num_rows_c_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c", "role": "write" }} , 
 	{ "name": "num_rows_c_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c2", "role": "din" }} , 
 	{ "name": "num_rows_c2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c2", "role": "full_n" }} , 
 	{ "name": "num_rows_c2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c2", "role": "write" }} , 
 	{ "name": "num_rows_c2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c2", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c2", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c3_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c3", "role": "din" }} , 
 	{ "name": "num_rows_c3_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c3", "role": "full_n" }} , 
 	{ "name": "num_rows_c3_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c3", "role": "write" }} , 
 	{ "name": "num_rows_c3_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c3", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c3_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c3", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c4_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c4", "role": "din" }} , 
 	{ "name": "num_rows_c4_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c4", "role": "full_n" }} , 
 	{ "name": "num_rows_c4_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c4", "role": "write" }} , 
 	{ "name": "num_rows_c4_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c4", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c4_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c4", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c5_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c5", "role": "din" }} , 
 	{ "name": "num_rows_c5_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c5", "role": "full_n" }} , 
 	{ "name": "num_rows_c5_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c5", "role": "write" }} , 
 	{ "name": "num_rows_c5_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c5", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c5_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c5", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c6_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c6", "role": "din" }} , 
 	{ "name": "num_rows_c6_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c6", "role": "full_n" }} , 
 	{ "name": "num_rows_c6_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c6", "role": "write" }} , 
 	{ "name": "num_rows_c6_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c6", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c6_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c6", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c7_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c7", "role": "din" }} , 
 	{ "name": "num_rows_c7_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c7", "role": "full_n" }} , 
 	{ "name": "num_rows_c7_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c7", "role": "write" }} , 
 	{ "name": "num_rows_c7_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c7", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c7_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c7", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c8_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c8", "role": "din" }} , 
 	{ "name": "num_rows_c8_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c8", "role": "full_n" }} , 
 	{ "name": "num_rows_c8_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c8", "role": "write" }} , 
 	{ "name": "num_rows_c8_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c8", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c8_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c8", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c9_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c9", "role": "din" }} , 
 	{ "name": "num_rows_c9_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c9", "role": "full_n" }} , 
 	{ "name": "num_rows_c9_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c9", "role": "write" }} , 
 	{ "name": "num_rows_c9_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c9", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c9_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c9", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c10_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c10", "role": "din" }} , 
 	{ "name": "num_rows_c10_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c10", "role": "full_n" }} , 
 	{ "name": "num_rows_c10_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c10", "role": "write" }} , 
 	{ "name": "num_rows_c10_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c10", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c10_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c10", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c11_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c11", "role": "din" }} , 
 	{ "name": "num_rows_c11_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c11", "role": "full_n" }} , 
 	{ "name": "num_rows_c11_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c11", "role": "write" }} , 
 	{ "name": "num_rows_c11_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c11", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c11_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c11", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c12_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c12", "role": "din" }} , 
 	{ "name": "num_rows_c12_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c12", "role": "full_n" }} , 
 	{ "name": "num_rows_c12_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c12", "role": "write" }} , 
 	{ "name": "num_rows_c12_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c12", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c12_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c12", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c13_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c13", "role": "din" }} , 
 	{ "name": "num_rows_c13_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c13", "role": "full_n" }} , 
 	{ "name": "num_rows_c13_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c13", "role": "write" }} , 
 	{ "name": "num_rows_c13_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c13", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c13_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c13", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c14_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c14", "role": "din" }} , 
 	{ "name": "num_rows_c14_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c14", "role": "full_n" }} , 
 	{ "name": "num_rows_c14_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c14", "role": "write" }} , 
 	{ "name": "num_rows_c14_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c14", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c14_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c14", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c15_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c15", "role": "din" }} , 
 	{ "name": "num_rows_c15_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c15", "role": "full_n" }} , 
 	{ "name": "num_rows_c15_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c15", "role": "write" }} , 
 	{ "name": "num_rows_c15_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c15", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c15_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c15", "role": "fifo_cap" }} , 
 	{ "name": "num_rows_c16_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows_c16", "role": "din" }} , 
 	{ "name": "num_rows_c16_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c16", "role": "full_n" }} , 
 	{ "name": "num_rows_c16_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "num_rows_c16", "role": "write" }} , 
 	{ "name": "num_rows_c16_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c16", "role": "num_data_valid" }} , 
 	{ "name": "num_rows_c16_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "num_rows_c16", "role": "fifo_cap" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "entry_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "None", "Direction" : "I"},
			{"Name" : "num_rows_c", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c4", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c4_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c5", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c5_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c6", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c6_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c7", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c7_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c8", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c8_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c9", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c9_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c10", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c10_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c11", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c11_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c12", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c12_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c13", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c13_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c14", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c14_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c15", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c15_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c16", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["0"], "DependentChan" : "0", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c16_blk_n", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	entry_proc {
		num_rows {Type I LastRead 0 FirstWrite -1}
		num_rows_c {Type O LastRead -1 FirstWrite 0}
		num_rows_c2 {Type O LastRead -1 FirstWrite 0}
		num_rows_c3 {Type O LastRead -1 FirstWrite 0}
		num_rows_c4 {Type O LastRead -1 FirstWrite 0}
		num_rows_c5 {Type O LastRead -1 FirstWrite 0}
		num_rows_c6 {Type O LastRead -1 FirstWrite 0}
		num_rows_c7 {Type O LastRead -1 FirstWrite 0}
		num_rows_c8 {Type O LastRead -1 FirstWrite 0}
		num_rows_c9 {Type O LastRead -1 FirstWrite 0}
		num_rows_c10 {Type O LastRead -1 FirstWrite 0}
		num_rows_c11 {Type O LastRead -1 FirstWrite 0}
		num_rows_c12 {Type O LastRead -1 FirstWrite 0}
		num_rows_c13 {Type O LastRead -1 FirstWrite 0}
		num_rows_c14 {Type O LastRead -1 FirstWrite 0}
		num_rows_c15 {Type O LastRead -1 FirstWrite 0}
		num_rows_c16 {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	num_rows { ap_none {  { num_rows in_data 0 32 } } }
	num_rows_c { ap_fifo {  { num_rows_c_din fifo_data_in 1 32 }  { num_rows_c_full_n fifo_status 0 1 }  { num_rows_c_write fifo_port_we 1 1 }  { num_rows_c_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c_fifo_cap fifo_update 0 3 } } }
	num_rows_c2 { ap_fifo {  { num_rows_c2_din fifo_data_in 1 32 }  { num_rows_c2_full_n fifo_status 0 1 }  { num_rows_c2_write fifo_port_we 1 1 }  { num_rows_c2_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c2_fifo_cap fifo_update 0 3 } } }
	num_rows_c3 { ap_fifo {  { num_rows_c3_din fifo_data_in 1 32 }  { num_rows_c3_full_n fifo_status 0 1 }  { num_rows_c3_write fifo_port_we 1 1 }  { num_rows_c3_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c3_fifo_cap fifo_update 0 3 } } }
	num_rows_c4 { ap_fifo {  { num_rows_c4_din fifo_data_in 1 32 }  { num_rows_c4_full_n fifo_status 0 1 }  { num_rows_c4_write fifo_port_we 1 1 }  { num_rows_c4_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c4_fifo_cap fifo_update 0 3 } } }
	num_rows_c5 { ap_fifo {  { num_rows_c5_din fifo_data_in 1 32 }  { num_rows_c5_full_n fifo_status 0 1 }  { num_rows_c5_write fifo_port_we 1 1 }  { num_rows_c5_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c5_fifo_cap fifo_update 0 3 } } }
	num_rows_c6 { ap_fifo {  { num_rows_c6_din fifo_data_in 1 32 }  { num_rows_c6_full_n fifo_status 0 1 }  { num_rows_c6_write fifo_port_we 1 1 }  { num_rows_c6_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c6_fifo_cap fifo_update 0 3 } } }
	num_rows_c7 { ap_fifo {  { num_rows_c7_din fifo_data_in 1 32 }  { num_rows_c7_full_n fifo_status 0 1 }  { num_rows_c7_write fifo_port_we 1 1 }  { num_rows_c7_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c7_fifo_cap fifo_update 0 3 } } }
	num_rows_c8 { ap_fifo {  { num_rows_c8_din fifo_data_in 1 32 }  { num_rows_c8_full_n fifo_status 0 1 }  { num_rows_c8_write fifo_port_we 1 1 }  { num_rows_c8_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c8_fifo_cap fifo_update 0 3 } } }
	num_rows_c9 { ap_fifo {  { num_rows_c9_din fifo_data_in 1 32 }  { num_rows_c9_full_n fifo_status 0 1 }  { num_rows_c9_write fifo_port_we 1 1 }  { num_rows_c9_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c9_fifo_cap fifo_update 0 3 } } }
	num_rows_c10 { ap_fifo {  { num_rows_c10_din fifo_data_in 1 32 }  { num_rows_c10_full_n fifo_status 0 1 }  { num_rows_c10_write fifo_port_we 1 1 }  { num_rows_c10_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c10_fifo_cap fifo_update 0 3 } } }
	num_rows_c11 { ap_fifo {  { num_rows_c11_din fifo_data_in 1 32 }  { num_rows_c11_full_n fifo_status 0 1 }  { num_rows_c11_write fifo_port_we 1 1 }  { num_rows_c11_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c11_fifo_cap fifo_update 0 3 } } }
	num_rows_c12 { ap_fifo {  { num_rows_c12_din fifo_data_in 1 32 }  { num_rows_c12_full_n fifo_status 0 1 }  { num_rows_c12_write fifo_port_we 1 1 }  { num_rows_c12_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c12_fifo_cap fifo_update 0 3 } } }
	num_rows_c13 { ap_fifo {  { num_rows_c13_din fifo_data_in 1 32 }  { num_rows_c13_full_n fifo_status 0 1 }  { num_rows_c13_write fifo_port_we 1 1 }  { num_rows_c13_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c13_fifo_cap fifo_update 0 3 } } }
	num_rows_c14 { ap_fifo {  { num_rows_c14_din fifo_data_in 1 32 }  { num_rows_c14_full_n fifo_status 0 1 }  { num_rows_c14_write fifo_port_we 1 1 }  { num_rows_c14_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c14_fifo_cap fifo_update 0 3 } } }
	num_rows_c15 { ap_fifo {  { num_rows_c15_din fifo_data_in 1 32 }  { num_rows_c15_full_n fifo_status 0 1 }  { num_rows_c15_write fifo_port_we 1 1 }  { num_rows_c15_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c15_fifo_cap fifo_update 0 3 } } }
	num_rows_c16 { ap_fifo {  { num_rows_c16_din fifo_data_in 1 32 }  { num_rows_c16_full_n fifo_status 0 1 }  { num_rows_c16_write fifo_port_we 1 1 }  { num_rows_c16_num_data_valid fifo_status_num_data_valid 0 3 }  { num_rows_c16_fifo_cap fifo_update 0 3 } } }
}
