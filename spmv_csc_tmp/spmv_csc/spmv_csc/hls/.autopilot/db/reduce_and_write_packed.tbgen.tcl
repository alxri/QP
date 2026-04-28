set moduleName reduce_and_write_packed
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
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
set C_modelName {reduce_and_write_packed}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict y_partial_0 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_1 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_2 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_3 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_4 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_5 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_6 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_7 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_8 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_9 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_10 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_11 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_12 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_13 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_14 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict y_partial_15 { MEM_WIDTH 32 MEM_SIZE 4096 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ num_rows int 32 regular  }
	{ y_partial_0 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_1 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_2 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_3 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_4 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_5 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_6 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_7 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_8 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_9 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_10 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_11 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_12 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_13 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_14 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ y_partial_15 float 32 regular {array 1024 { 1 3 } 1 1 }  }
	{ gmem4 int 512 regular {axi_master 1}  }
	{ y_out int 64 regular  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "num_rows", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_0", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_8", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_9", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_10", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_11", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_12", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_13", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_14", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_15", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "gmem4", "interface" : "axi_master", "bitwidth" : 512, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "y","offset": { "type": "dynamic","port_name": "y","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "y_out", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 102
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ num_rows sc_in sc_lv 32 signal 0 } 
	{ y_partial_0_address0 sc_out sc_lv 10 signal 1 } 
	{ y_partial_0_ce0 sc_out sc_logic 1 signal 1 } 
	{ y_partial_0_q0 sc_in sc_lv 32 signal 1 } 
	{ y_partial_1_address0 sc_out sc_lv 10 signal 2 } 
	{ y_partial_1_ce0 sc_out sc_logic 1 signal 2 } 
	{ y_partial_1_q0 sc_in sc_lv 32 signal 2 } 
	{ y_partial_2_address0 sc_out sc_lv 10 signal 3 } 
	{ y_partial_2_ce0 sc_out sc_logic 1 signal 3 } 
	{ y_partial_2_q0 sc_in sc_lv 32 signal 3 } 
	{ y_partial_3_address0 sc_out sc_lv 10 signal 4 } 
	{ y_partial_3_ce0 sc_out sc_logic 1 signal 4 } 
	{ y_partial_3_q0 sc_in sc_lv 32 signal 4 } 
	{ y_partial_4_address0 sc_out sc_lv 10 signal 5 } 
	{ y_partial_4_ce0 sc_out sc_logic 1 signal 5 } 
	{ y_partial_4_q0 sc_in sc_lv 32 signal 5 } 
	{ y_partial_5_address0 sc_out sc_lv 10 signal 6 } 
	{ y_partial_5_ce0 sc_out sc_logic 1 signal 6 } 
	{ y_partial_5_q0 sc_in sc_lv 32 signal 6 } 
	{ y_partial_6_address0 sc_out sc_lv 10 signal 7 } 
	{ y_partial_6_ce0 sc_out sc_logic 1 signal 7 } 
	{ y_partial_6_q0 sc_in sc_lv 32 signal 7 } 
	{ y_partial_7_address0 sc_out sc_lv 10 signal 8 } 
	{ y_partial_7_ce0 sc_out sc_logic 1 signal 8 } 
	{ y_partial_7_q0 sc_in sc_lv 32 signal 8 } 
	{ y_partial_8_address0 sc_out sc_lv 10 signal 9 } 
	{ y_partial_8_ce0 sc_out sc_logic 1 signal 9 } 
	{ y_partial_8_q0 sc_in sc_lv 32 signal 9 } 
	{ y_partial_9_address0 sc_out sc_lv 10 signal 10 } 
	{ y_partial_9_ce0 sc_out sc_logic 1 signal 10 } 
	{ y_partial_9_q0 sc_in sc_lv 32 signal 10 } 
	{ y_partial_10_address0 sc_out sc_lv 10 signal 11 } 
	{ y_partial_10_ce0 sc_out sc_logic 1 signal 11 } 
	{ y_partial_10_q0 sc_in sc_lv 32 signal 11 } 
	{ y_partial_11_address0 sc_out sc_lv 10 signal 12 } 
	{ y_partial_11_ce0 sc_out sc_logic 1 signal 12 } 
	{ y_partial_11_q0 sc_in sc_lv 32 signal 12 } 
	{ y_partial_12_address0 sc_out sc_lv 10 signal 13 } 
	{ y_partial_12_ce0 sc_out sc_logic 1 signal 13 } 
	{ y_partial_12_q0 sc_in sc_lv 32 signal 13 } 
	{ y_partial_13_address0 sc_out sc_lv 10 signal 14 } 
	{ y_partial_13_ce0 sc_out sc_logic 1 signal 14 } 
	{ y_partial_13_q0 sc_in sc_lv 32 signal 14 } 
	{ y_partial_14_address0 sc_out sc_lv 10 signal 15 } 
	{ y_partial_14_ce0 sc_out sc_logic 1 signal 15 } 
	{ y_partial_14_q0 sc_in sc_lv 32 signal 15 } 
	{ y_partial_15_address0 sc_out sc_lv 10 signal 16 } 
	{ y_partial_15_ce0 sc_out sc_logic 1 signal 16 } 
	{ y_partial_15_q0 sc_in sc_lv 32 signal 16 } 
	{ m_axi_gmem4_0_AWVALID sc_out sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_AWREADY sc_in sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_AWADDR sc_out sc_lv 64 signal 17 } 
	{ m_axi_gmem4_0_AWID sc_out sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_AWLEN sc_out sc_lv 32 signal 17 } 
	{ m_axi_gmem4_0_AWSIZE sc_out sc_lv 3 signal 17 } 
	{ m_axi_gmem4_0_AWBURST sc_out sc_lv 2 signal 17 } 
	{ m_axi_gmem4_0_AWLOCK sc_out sc_lv 2 signal 17 } 
	{ m_axi_gmem4_0_AWCACHE sc_out sc_lv 4 signal 17 } 
	{ m_axi_gmem4_0_AWPROT sc_out sc_lv 3 signal 17 } 
	{ m_axi_gmem4_0_AWQOS sc_out sc_lv 4 signal 17 } 
	{ m_axi_gmem4_0_AWREGION sc_out sc_lv 4 signal 17 } 
	{ m_axi_gmem4_0_AWUSER sc_out sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_WVALID sc_out sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_WREADY sc_in sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_WDATA sc_out sc_lv 512 signal 17 } 
	{ m_axi_gmem4_0_WSTRB sc_out sc_lv 64 signal 17 } 
	{ m_axi_gmem4_0_WLAST sc_out sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_WID sc_out sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_WUSER sc_out sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_ARVALID sc_out sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_ARREADY sc_in sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_ARADDR sc_out sc_lv 64 signal 17 } 
	{ m_axi_gmem4_0_ARID sc_out sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_ARLEN sc_out sc_lv 32 signal 17 } 
	{ m_axi_gmem4_0_ARSIZE sc_out sc_lv 3 signal 17 } 
	{ m_axi_gmem4_0_ARBURST sc_out sc_lv 2 signal 17 } 
	{ m_axi_gmem4_0_ARLOCK sc_out sc_lv 2 signal 17 } 
	{ m_axi_gmem4_0_ARCACHE sc_out sc_lv 4 signal 17 } 
	{ m_axi_gmem4_0_ARPROT sc_out sc_lv 3 signal 17 } 
	{ m_axi_gmem4_0_ARQOS sc_out sc_lv 4 signal 17 } 
	{ m_axi_gmem4_0_ARREGION sc_out sc_lv 4 signal 17 } 
	{ m_axi_gmem4_0_ARUSER sc_out sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_RVALID sc_in sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_RREADY sc_out sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_RDATA sc_in sc_lv 512 signal 17 } 
	{ m_axi_gmem4_0_RLAST sc_in sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_RID sc_in sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_RFIFONUM sc_in sc_lv 9 signal 17 } 
	{ m_axi_gmem4_0_RUSER sc_in sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_RRESP sc_in sc_lv 2 signal 17 } 
	{ m_axi_gmem4_0_BVALID sc_in sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_BREADY sc_out sc_logic 1 signal 17 } 
	{ m_axi_gmem4_0_BRESP sc_in sc_lv 2 signal 17 } 
	{ m_axi_gmem4_0_BID sc_in sc_lv 1 signal 17 } 
	{ m_axi_gmem4_0_BUSER sc_in sc_lv 1 signal 17 } 
	{ y_out sc_in sc_lv 64 signal 18 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "num_rows", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows", "role": "default" }} , 
 	{ "name": "y_partial_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_0", "role": "address0" }} , 
 	{ "name": "y_partial_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_0", "role": "ce0" }} , 
 	{ "name": "y_partial_0_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_0", "role": "q0" }} , 
 	{ "name": "y_partial_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_1", "role": "address0" }} , 
 	{ "name": "y_partial_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_1", "role": "ce0" }} , 
 	{ "name": "y_partial_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_1", "role": "q0" }} , 
 	{ "name": "y_partial_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_2", "role": "address0" }} , 
 	{ "name": "y_partial_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_2", "role": "ce0" }} , 
 	{ "name": "y_partial_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_2", "role": "q0" }} , 
 	{ "name": "y_partial_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_3", "role": "address0" }} , 
 	{ "name": "y_partial_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_3", "role": "ce0" }} , 
 	{ "name": "y_partial_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_3", "role": "q0" }} , 
 	{ "name": "y_partial_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_4", "role": "address0" }} , 
 	{ "name": "y_partial_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_4", "role": "ce0" }} , 
 	{ "name": "y_partial_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_4", "role": "q0" }} , 
 	{ "name": "y_partial_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_5", "role": "address0" }} , 
 	{ "name": "y_partial_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_5", "role": "ce0" }} , 
 	{ "name": "y_partial_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_5", "role": "q0" }} , 
 	{ "name": "y_partial_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_6", "role": "address0" }} , 
 	{ "name": "y_partial_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_6", "role": "ce0" }} , 
 	{ "name": "y_partial_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_6", "role": "q0" }} , 
 	{ "name": "y_partial_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_7", "role": "address0" }} , 
 	{ "name": "y_partial_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_7", "role": "ce0" }} , 
 	{ "name": "y_partial_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_7", "role": "q0" }} , 
 	{ "name": "y_partial_8_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_8", "role": "address0" }} , 
 	{ "name": "y_partial_8_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_8", "role": "ce0" }} , 
 	{ "name": "y_partial_8_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_8", "role": "q0" }} , 
 	{ "name": "y_partial_9_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_9", "role": "address0" }} , 
 	{ "name": "y_partial_9_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_9", "role": "ce0" }} , 
 	{ "name": "y_partial_9_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_9", "role": "q0" }} , 
 	{ "name": "y_partial_10_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_10", "role": "address0" }} , 
 	{ "name": "y_partial_10_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_10", "role": "ce0" }} , 
 	{ "name": "y_partial_10_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_10", "role": "q0" }} , 
 	{ "name": "y_partial_11_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_11", "role": "address0" }} , 
 	{ "name": "y_partial_11_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_11", "role": "ce0" }} , 
 	{ "name": "y_partial_11_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_11", "role": "q0" }} , 
 	{ "name": "y_partial_12_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_12", "role": "address0" }} , 
 	{ "name": "y_partial_12_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_12", "role": "ce0" }} , 
 	{ "name": "y_partial_12_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_12", "role": "q0" }} , 
 	{ "name": "y_partial_13_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_13", "role": "address0" }} , 
 	{ "name": "y_partial_13_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_13", "role": "ce0" }} , 
 	{ "name": "y_partial_13_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_13", "role": "q0" }} , 
 	{ "name": "y_partial_14_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_14", "role": "address0" }} , 
 	{ "name": "y_partial_14_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_14", "role": "ce0" }} , 
 	{ "name": "y_partial_14_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_14", "role": "q0" }} , 
 	{ "name": "y_partial_15_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_15", "role": "address0" }} , 
 	{ "name": "y_partial_15_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_15", "role": "ce0" }} , 
 	{ "name": "y_partial_15_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_15", "role": "q0" }} , 
 	{ "name": "m_axi_gmem4_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWVALID" }} , 
 	{ "name": "m_axi_gmem4_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWREADY" }} , 
 	{ "name": "m_axi_gmem4_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWADDR" }} , 
 	{ "name": "m_axi_gmem4_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWID" }} , 
 	{ "name": "m_axi_gmem4_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWLEN" }} , 
 	{ "name": "m_axi_gmem4_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWSIZE" }} , 
 	{ "name": "m_axi_gmem4_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWBURST" }} , 
 	{ "name": "m_axi_gmem4_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWLOCK" }} , 
 	{ "name": "m_axi_gmem4_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWCACHE" }} , 
 	{ "name": "m_axi_gmem4_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWPROT" }} , 
 	{ "name": "m_axi_gmem4_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWQOS" }} , 
 	{ "name": "m_axi_gmem4_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWREGION" }} , 
 	{ "name": "m_axi_gmem4_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_AWUSER" }} , 
 	{ "name": "m_axi_gmem4_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WVALID" }} , 
 	{ "name": "m_axi_gmem4_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WREADY" }} , 
 	{ "name": "m_axi_gmem4_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WDATA" }} , 
 	{ "name": "m_axi_gmem4_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WSTRB" }} , 
 	{ "name": "m_axi_gmem4_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WLAST" }} , 
 	{ "name": "m_axi_gmem4_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WID" }} , 
 	{ "name": "m_axi_gmem4_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_WUSER" }} , 
 	{ "name": "m_axi_gmem4_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARVALID" }} , 
 	{ "name": "m_axi_gmem4_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARREADY" }} , 
 	{ "name": "m_axi_gmem4_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARADDR" }} , 
 	{ "name": "m_axi_gmem4_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARID" }} , 
 	{ "name": "m_axi_gmem4_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARLEN" }} , 
 	{ "name": "m_axi_gmem4_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARSIZE" }} , 
 	{ "name": "m_axi_gmem4_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARBURST" }} , 
 	{ "name": "m_axi_gmem4_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARLOCK" }} , 
 	{ "name": "m_axi_gmem4_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARCACHE" }} , 
 	{ "name": "m_axi_gmem4_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARPROT" }} , 
 	{ "name": "m_axi_gmem4_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARQOS" }} , 
 	{ "name": "m_axi_gmem4_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARREGION" }} , 
 	{ "name": "m_axi_gmem4_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_ARUSER" }} , 
 	{ "name": "m_axi_gmem4_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RVALID" }} , 
 	{ "name": "m_axi_gmem4_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RREADY" }} , 
 	{ "name": "m_axi_gmem4_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RDATA" }} , 
 	{ "name": "m_axi_gmem4_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RLAST" }} , 
 	{ "name": "m_axi_gmem4_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RID" }} , 
 	{ "name": "m_axi_gmem4_0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RFIFONUM" }} , 
 	{ "name": "m_axi_gmem4_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RUSER" }} , 
 	{ "name": "m_axi_gmem4_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "0_RRESP" }} , 
 	{ "name": "m_axi_gmem4_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_BVALID" }} , 
 	{ "name": "m_axi_gmem4_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_BREADY" }} , 
 	{ "name": "m_axi_gmem4_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "0_BRESP" }} , 
 	{ "name": "m_axi_gmem4_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_BID" }} , 
 	{ "name": "m_axi_gmem4_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "0_BUSER" }} , 
 	{ "name": "y_out", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "y_out", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "reduce_and_write_packed",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "10", "EstimateLatencyMax" : "2147483772",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial_0", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_0", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_1", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_1", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_2", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_2", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_3", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_3", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_4", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_4", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_5", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_5", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_6", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_6", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_7", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_7", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_8", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_8", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_9", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_9", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_10", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_10", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_11", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_11", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_12", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_12", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_13", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_13", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_14", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_14", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_15", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_15", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "gmem4", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "gmem4_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "gmem4_blk_n_B", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "gmem4", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_out", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Parent" : "0", "Child" : ["2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"],
		"CDFG" : "reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "2147483764",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "bound", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem4", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "gmem4_blk_n_W", "Type" : "RtlSignal"}]},
			{"Name" : "sext_ln273", "Type" : "None", "Direction" : "I"},
			{"Name" : "num_rows_cast", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial_0", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_1", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_2", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_3", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_4", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_5", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_6", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_7", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_8", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_9", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_10", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_11", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_12", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_13", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_14", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "y_partial_15", "Type" : "Memory", "Direction" : "I"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_273_1_VITIS_LOOP_277_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter132", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter132", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U360", "Parent" : "1"},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U361", "Parent" : "1"},
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U362", "Parent" : "1"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U363", "Parent" : "1"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U364", "Parent" : "1"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U365", "Parent" : "1"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U366", "Parent" : "1"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U367", "Parent" : "1"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U368", "Parent" : "1"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U369", "Parent" : "1"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U370", "Parent" : "1"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U371", "Parent" : "1"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U372", "Parent" : "1"},
	{"ID" : "15", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U373", "Parent" : "1"},
	{"ID" : "16", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U374", "Parent" : "1"},
	{"ID" : "17", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U375", "Parent" : "1"},
	{"ID" : "18", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.flow_control_loop_pipe_sequential_init_U", "Parent" : "1"}]}


set ArgLastReadFirstWriteLatency {
	reduce_and_write_packed {
		num_rows {Type I LastRead 0 FirstWrite -1}
		y_partial_0 {Type I LastRead 1 FirstWrite -1}
		y_partial_1 {Type I LastRead 9 FirstWrite -1}
		y_partial_2 {Type I LastRead 17 FirstWrite -1}
		y_partial_3 {Type I LastRead 25 FirstWrite -1}
		y_partial_4 {Type I LastRead 33 FirstWrite -1}
		y_partial_5 {Type I LastRead 41 FirstWrite -1}
		y_partial_6 {Type I LastRead 49 FirstWrite -1}
		y_partial_7 {Type I LastRead 57 FirstWrite -1}
		y_partial_8 {Type I LastRead 65 FirstWrite -1}
		y_partial_9 {Type I LastRead 73 FirstWrite -1}
		y_partial_10 {Type I LastRead 81 FirstWrite -1}
		y_partial_11 {Type I LastRead 89 FirstWrite -1}
		y_partial_12 {Type I LastRead 97 FirstWrite -1}
		y_partial_13 {Type I LastRead 105 FirstWrite -1}
		y_partial_14 {Type I LastRead 113 FirstWrite -1}
		y_partial_15 {Type I LastRead 121 FirstWrite -1}
		gmem4 {Type O LastRead 4 FirstWrite 132}
		y_out {Type I LastRead 1 FirstWrite -1}}
	reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2 {
		bound {Type I LastRead 0 FirstWrite -1}
		gmem4 {Type O LastRead -1 FirstWrite 132}
		sext_ln273 {Type I LastRead 0 FirstWrite -1}
		num_rows_cast {Type I LastRead 0 FirstWrite -1}
		y_partial_0 {Type I LastRead 1 FirstWrite -1}
		y_partial_1 {Type I LastRead 9 FirstWrite -1}
		y_partial_2 {Type I LastRead 17 FirstWrite -1}
		y_partial_3 {Type I LastRead 25 FirstWrite -1}
		y_partial_4 {Type I LastRead 33 FirstWrite -1}
		y_partial_5 {Type I LastRead 41 FirstWrite -1}
		y_partial_6 {Type I LastRead 49 FirstWrite -1}
		y_partial_7 {Type I LastRead 57 FirstWrite -1}
		y_partial_8 {Type I LastRead 65 FirstWrite -1}
		y_partial_9 {Type I LastRead 73 FirstWrite -1}
		y_partial_10 {Type I LastRead 81 FirstWrite -1}
		y_partial_11 {Type I LastRead 89 FirstWrite -1}
		y_partial_12 {Type I LastRead 97 FirstWrite -1}
		y_partial_13 {Type I LastRead 105 FirstWrite -1}
		y_partial_14 {Type I LastRead 113 FirstWrite -1}
		y_partial_15 {Type I LastRead 121 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "10", "Max" : "2147483772"}
	, {"Name" : "Interval", "Min" : "10", "Max" : "2147483772"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	num_rows { ap_none {  { num_rows in_data 0 32 } } }
	y_partial_0 { ap_memory {  { y_partial_0_address0 mem_address 1 10 }  { y_partial_0_ce0 mem_ce 1 1 }  { y_partial_0_q0 mem_dout 0 32 } } }
	y_partial_1 { ap_memory {  { y_partial_1_address0 mem_address 1 10 }  { y_partial_1_ce0 mem_ce 1 1 }  { y_partial_1_q0 mem_dout 0 32 } } }
	y_partial_2 { ap_memory {  { y_partial_2_address0 mem_address 1 10 }  { y_partial_2_ce0 mem_ce 1 1 }  { y_partial_2_q0 mem_dout 0 32 } } }
	y_partial_3 { ap_memory {  { y_partial_3_address0 mem_address 1 10 }  { y_partial_3_ce0 mem_ce 1 1 }  { y_partial_3_q0 mem_dout 0 32 } } }
	y_partial_4 { ap_memory {  { y_partial_4_address0 mem_address 1 10 }  { y_partial_4_ce0 mem_ce 1 1 }  { y_partial_4_q0 mem_dout 0 32 } } }
	y_partial_5 { ap_memory {  { y_partial_5_address0 mem_address 1 10 }  { y_partial_5_ce0 mem_ce 1 1 }  { y_partial_5_q0 mem_dout 0 32 } } }
	y_partial_6 { ap_memory {  { y_partial_6_address0 mem_address 1 10 }  { y_partial_6_ce0 mem_ce 1 1 }  { y_partial_6_q0 mem_dout 0 32 } } }
	y_partial_7 { ap_memory {  { y_partial_7_address0 mem_address 1 10 }  { y_partial_7_ce0 mem_ce 1 1 }  { y_partial_7_q0 mem_dout 0 32 } } }
	y_partial_8 { ap_memory {  { y_partial_8_address0 mem_address 1 10 }  { y_partial_8_ce0 mem_ce 1 1 }  { y_partial_8_q0 mem_dout 0 32 } } }
	y_partial_9 { ap_memory {  { y_partial_9_address0 mem_address 1 10 }  { y_partial_9_ce0 mem_ce 1 1 }  { y_partial_9_q0 mem_dout 0 32 } } }
	y_partial_10 { ap_memory {  { y_partial_10_address0 mem_address 1 10 }  { y_partial_10_ce0 mem_ce 1 1 }  { y_partial_10_q0 mem_dout 0 32 } } }
	y_partial_11 { ap_memory {  { y_partial_11_address0 mem_address 1 10 }  { y_partial_11_ce0 mem_ce 1 1 }  { y_partial_11_q0 mem_dout 0 32 } } }
	y_partial_12 { ap_memory {  { y_partial_12_address0 mem_address 1 10 }  { y_partial_12_ce0 mem_ce 1 1 }  { y_partial_12_q0 mem_dout 0 32 } } }
	y_partial_13 { ap_memory {  { y_partial_13_address0 mem_address 1 10 }  { y_partial_13_ce0 mem_ce 1 1 }  { y_partial_13_q0 mem_dout 0 32 } } }
	y_partial_14 { ap_memory {  { y_partial_14_address0 mem_address 1 10 }  { y_partial_14_ce0 mem_ce 1 1 }  { y_partial_14_q0 mem_dout 0 32 } } }
	y_partial_15 { ap_memory {  { y_partial_15_address0 mem_address 1 10 }  { y_partial_15_ce0 mem_ce 1 1 }  { y_partial_15_q0 mem_dout 0 32 } } }
	 { m_axi {  { m_axi_gmem4_0_AWVALID VALID 1 1 }  { m_axi_gmem4_0_AWREADY READY 0 1 }  { m_axi_gmem4_0_AWADDR ADDR 1 64 }  { m_axi_gmem4_0_AWID ID 1 1 }  { m_axi_gmem4_0_AWLEN SIZE 1 32 }  { m_axi_gmem4_0_AWSIZE BURST 1 3 }  { m_axi_gmem4_0_AWBURST LOCK 1 2 }  { m_axi_gmem4_0_AWLOCK CACHE 1 2 }  { m_axi_gmem4_0_AWCACHE PROT 1 4 }  { m_axi_gmem4_0_AWPROT QOS 1 3 }  { m_axi_gmem4_0_AWQOS REGION 1 4 }  { m_axi_gmem4_0_AWREGION USER 1 4 }  { m_axi_gmem4_0_AWUSER DATA 1 1 }  { m_axi_gmem4_0_WVALID VALID 1 1 }  { m_axi_gmem4_0_WREADY READY 0 1 }  { m_axi_gmem4_0_WDATA FIFONUM 1 512 }  { m_axi_gmem4_0_WSTRB STRB 1 64 }  { m_axi_gmem4_0_WLAST LAST 1 1 }  { m_axi_gmem4_0_WID ID 1 1 }  { m_axi_gmem4_0_WUSER DATA 1 1 }  { m_axi_gmem4_0_ARVALID VALID 1 1 }  { m_axi_gmem4_0_ARREADY READY 0 1 }  { m_axi_gmem4_0_ARADDR ADDR 1 64 }  { m_axi_gmem4_0_ARID ID 1 1 }  { m_axi_gmem4_0_ARLEN SIZE 1 32 }  { m_axi_gmem4_0_ARSIZE BURST 1 3 }  { m_axi_gmem4_0_ARBURST LOCK 1 2 }  { m_axi_gmem4_0_ARLOCK CACHE 1 2 }  { m_axi_gmem4_0_ARCACHE PROT 1 4 }  { m_axi_gmem4_0_ARPROT QOS 1 3 }  { m_axi_gmem4_0_ARQOS REGION 1 4 }  { m_axi_gmem4_0_ARREGION USER 1 4 }  { m_axi_gmem4_0_ARUSER DATA 1 1 }  { m_axi_gmem4_0_RVALID VALID 0 1 }  { m_axi_gmem4_0_RREADY READY 1 1 }  { m_axi_gmem4_0_RDATA FIFONUM 0 512 }  { m_axi_gmem4_0_RLAST LAST 0 1 }  { m_axi_gmem4_0_RID ID 0 1 }  { m_axi_gmem4_0_RFIFONUM LEN 0 9 }  { m_axi_gmem4_0_RUSER DATA 0 1 }  { m_axi_gmem4_0_RRESP RESP 0 2 }  { m_axi_gmem4_0_BVALID VALID 0 1 }  { m_axi_gmem4_0_BREADY READY 1 1 }  { m_axi_gmem4_0_BRESP RESP 0 2 }  { m_axi_gmem4_0_BID ID 0 1 }  { m_axi_gmem4_0_BUSER DATA 0 1 } } }
	y_out { ap_none {  { y_out in_data 0 64 } } }
}
