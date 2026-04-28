set moduleName spmv_csc_dataflow
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type dataflow
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
set C_modelName {spmv_csc_dataflow}
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
	{ num_cols int 32 regular  }
	{ nnz int 32 regular  }
	{ gmem0 int 512 regular {axi_master 0}  }
	{ A_row_idx int 64 regular  }
	{ gmem1 int 32 regular {axi_master 0}  }
	{ A_col_ptr int 64 regular  }
	{ gmem2 int 512 regular {axi_master 0}  }
	{ A_values int 64 regular  }
	{ gmem3 int 32 regular {axi_master 0}  }
	{ x int 64 regular  }
	{ y_partial_0 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_1 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_2 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_3 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_4 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_5 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_6 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_7 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_8 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_9 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_10 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_11 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_12 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_13 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_14 float 32 regular {array 1024 { 2 3 } 1 1 }  }
	{ y_partial_15 float 32 regular {array 1024 { 2 3 } 1 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "num_rows", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "num_cols", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "nnz", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "gmem0", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A_row_idx","offset": { "type": "dynamic","port_name": "A_row_idx","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "A_row_idx", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "gmem1", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A_col_ptr","offset": { "type": "dynamic","port_name": "A_col_ptr","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "A_col_ptr", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "gmem2", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A_values","offset": { "type": "dynamic","port_name": "A_values","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "A_values", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "gmem3", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "x","offset": { "type": "dynamic","port_name": "x","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "x", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "y_partial_0", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_1", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_2", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_3", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_4", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_5", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_6", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_7", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_8", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_9", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_10", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_11", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_12", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_13", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_14", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "y_partial_15", "interface" : "memory", "bitwidth" : 32, "direction" : "READWRITE"} ]}
# RTL Port declarations: 
set portNum 365
set portList { 
	{ num_rows sc_in sc_lv 32 signal 0 } 
	{ num_cols sc_in sc_lv 32 signal 1 } 
	{ nnz sc_in sc_lv 32 signal 2 } 
	{ m_axi_gmem0_0_AWVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_AWREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_AWADDR sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem0_0_AWID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_AWLEN sc_out sc_lv 32 signal 3 } 
	{ m_axi_gmem0_0_AWSIZE sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem0_0_AWBURST sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem0_0_AWLOCK sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem0_0_AWCACHE sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem0_0_AWPROT sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem0_0_AWQOS sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem0_0_AWREGION sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem0_0_AWUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_WVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_WREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_WDATA sc_out sc_lv 512 signal 3 } 
	{ m_axi_gmem0_0_WSTRB sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem0_0_WLAST sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_WID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_WUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_ARVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_ARREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_ARADDR sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem0_0_ARID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_ARLEN sc_out sc_lv 32 signal 3 } 
	{ m_axi_gmem0_0_ARSIZE sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem0_0_ARBURST sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem0_0_ARLOCK sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem0_0_ARCACHE sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem0_0_ARPROT sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem0_0_ARQOS sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem0_0_ARREGION sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem0_0_ARUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_RVALID sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_RREADY sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_RDATA sc_in sc_lv 512 signal 3 } 
	{ m_axi_gmem0_0_RLAST sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_RID sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_RFIFONUM sc_in sc_lv 9 signal 3 } 
	{ m_axi_gmem0_0_RUSER sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_RRESP sc_in sc_lv 2 signal 3 } 
	{ m_axi_gmem0_0_BVALID sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_BREADY sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem0_0_BRESP sc_in sc_lv 2 signal 3 } 
	{ m_axi_gmem0_0_BID sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem0_0_BUSER sc_in sc_lv 1 signal 3 } 
	{ A_row_idx sc_in sc_lv 64 signal 4 } 
	{ m_axi_gmem1_0_AWVALID sc_out sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_AWREADY sc_in sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_AWADDR sc_out sc_lv 64 signal 5 } 
	{ m_axi_gmem1_0_AWID sc_out sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_AWLEN sc_out sc_lv 32 signal 5 } 
	{ m_axi_gmem1_0_AWSIZE sc_out sc_lv 3 signal 5 } 
	{ m_axi_gmem1_0_AWBURST sc_out sc_lv 2 signal 5 } 
	{ m_axi_gmem1_0_AWLOCK sc_out sc_lv 2 signal 5 } 
	{ m_axi_gmem1_0_AWCACHE sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_AWPROT sc_out sc_lv 3 signal 5 } 
	{ m_axi_gmem1_0_AWQOS sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_AWREGION sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_AWUSER sc_out sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_WVALID sc_out sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_WREADY sc_in sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_WDATA sc_out sc_lv 32 signal 5 } 
	{ m_axi_gmem1_0_WSTRB sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_WLAST sc_out sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_WID sc_out sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_WUSER sc_out sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_ARVALID sc_out sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_ARREADY sc_in sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_ARADDR sc_out sc_lv 64 signal 5 } 
	{ m_axi_gmem1_0_ARID sc_out sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_ARLEN sc_out sc_lv 32 signal 5 } 
	{ m_axi_gmem1_0_ARSIZE sc_out sc_lv 3 signal 5 } 
	{ m_axi_gmem1_0_ARBURST sc_out sc_lv 2 signal 5 } 
	{ m_axi_gmem1_0_ARLOCK sc_out sc_lv 2 signal 5 } 
	{ m_axi_gmem1_0_ARCACHE sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_ARPROT sc_out sc_lv 3 signal 5 } 
	{ m_axi_gmem1_0_ARQOS sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_ARREGION sc_out sc_lv 4 signal 5 } 
	{ m_axi_gmem1_0_ARUSER sc_out sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_RVALID sc_in sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_RREADY sc_out sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_RDATA sc_in sc_lv 32 signal 5 } 
	{ m_axi_gmem1_0_RLAST sc_in sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_RID sc_in sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_RFIFONUM sc_in sc_lv 9 signal 5 } 
	{ m_axi_gmem1_0_RUSER sc_in sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_RRESP sc_in sc_lv 2 signal 5 } 
	{ m_axi_gmem1_0_BVALID sc_in sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_BREADY sc_out sc_logic 1 signal 5 } 
	{ m_axi_gmem1_0_BRESP sc_in sc_lv 2 signal 5 } 
	{ m_axi_gmem1_0_BID sc_in sc_lv 1 signal 5 } 
	{ m_axi_gmem1_0_BUSER sc_in sc_lv 1 signal 5 } 
	{ A_col_ptr sc_in sc_lv 64 signal 6 } 
	{ m_axi_gmem2_0_AWVALID sc_out sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_AWREADY sc_in sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_AWADDR sc_out sc_lv 64 signal 7 } 
	{ m_axi_gmem2_0_AWID sc_out sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_AWLEN sc_out sc_lv 32 signal 7 } 
	{ m_axi_gmem2_0_AWSIZE sc_out sc_lv 3 signal 7 } 
	{ m_axi_gmem2_0_AWBURST sc_out sc_lv 2 signal 7 } 
	{ m_axi_gmem2_0_AWLOCK sc_out sc_lv 2 signal 7 } 
	{ m_axi_gmem2_0_AWCACHE sc_out sc_lv 4 signal 7 } 
	{ m_axi_gmem2_0_AWPROT sc_out sc_lv 3 signal 7 } 
	{ m_axi_gmem2_0_AWQOS sc_out sc_lv 4 signal 7 } 
	{ m_axi_gmem2_0_AWREGION sc_out sc_lv 4 signal 7 } 
	{ m_axi_gmem2_0_AWUSER sc_out sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_WVALID sc_out sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_WREADY sc_in sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_WDATA sc_out sc_lv 512 signal 7 } 
	{ m_axi_gmem2_0_WSTRB sc_out sc_lv 64 signal 7 } 
	{ m_axi_gmem2_0_WLAST sc_out sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_WID sc_out sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_WUSER sc_out sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_ARVALID sc_out sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_ARREADY sc_in sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_ARADDR sc_out sc_lv 64 signal 7 } 
	{ m_axi_gmem2_0_ARID sc_out sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_ARLEN sc_out sc_lv 32 signal 7 } 
	{ m_axi_gmem2_0_ARSIZE sc_out sc_lv 3 signal 7 } 
	{ m_axi_gmem2_0_ARBURST sc_out sc_lv 2 signal 7 } 
	{ m_axi_gmem2_0_ARLOCK sc_out sc_lv 2 signal 7 } 
	{ m_axi_gmem2_0_ARCACHE sc_out sc_lv 4 signal 7 } 
	{ m_axi_gmem2_0_ARPROT sc_out sc_lv 3 signal 7 } 
	{ m_axi_gmem2_0_ARQOS sc_out sc_lv 4 signal 7 } 
	{ m_axi_gmem2_0_ARREGION sc_out sc_lv 4 signal 7 } 
	{ m_axi_gmem2_0_ARUSER sc_out sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_RVALID sc_in sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_RREADY sc_out sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_RDATA sc_in sc_lv 512 signal 7 } 
	{ m_axi_gmem2_0_RLAST sc_in sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_RID sc_in sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_RFIFONUM sc_in sc_lv 9 signal 7 } 
	{ m_axi_gmem2_0_RUSER sc_in sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_RRESP sc_in sc_lv 2 signal 7 } 
	{ m_axi_gmem2_0_BVALID sc_in sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_BREADY sc_out sc_logic 1 signal 7 } 
	{ m_axi_gmem2_0_BRESP sc_in sc_lv 2 signal 7 } 
	{ m_axi_gmem2_0_BID sc_in sc_lv 1 signal 7 } 
	{ m_axi_gmem2_0_BUSER sc_in sc_lv 1 signal 7 } 
	{ A_values sc_in sc_lv 64 signal 8 } 
	{ m_axi_gmem3_0_AWVALID sc_out sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_AWREADY sc_in sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_AWADDR sc_out sc_lv 64 signal 9 } 
	{ m_axi_gmem3_0_AWID sc_out sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_AWLEN sc_out sc_lv 32 signal 9 } 
	{ m_axi_gmem3_0_AWSIZE sc_out sc_lv 3 signal 9 } 
	{ m_axi_gmem3_0_AWBURST sc_out sc_lv 2 signal 9 } 
	{ m_axi_gmem3_0_AWLOCK sc_out sc_lv 2 signal 9 } 
	{ m_axi_gmem3_0_AWCACHE sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_AWPROT sc_out sc_lv 3 signal 9 } 
	{ m_axi_gmem3_0_AWQOS sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_AWREGION sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_AWUSER sc_out sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_WVALID sc_out sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_WREADY sc_in sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_WDATA sc_out sc_lv 32 signal 9 } 
	{ m_axi_gmem3_0_WSTRB sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_WLAST sc_out sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_WID sc_out sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_WUSER sc_out sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_ARVALID sc_out sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_ARREADY sc_in sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_ARADDR sc_out sc_lv 64 signal 9 } 
	{ m_axi_gmem3_0_ARID sc_out sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_ARLEN sc_out sc_lv 32 signal 9 } 
	{ m_axi_gmem3_0_ARSIZE sc_out sc_lv 3 signal 9 } 
	{ m_axi_gmem3_0_ARBURST sc_out sc_lv 2 signal 9 } 
	{ m_axi_gmem3_0_ARLOCK sc_out sc_lv 2 signal 9 } 
	{ m_axi_gmem3_0_ARCACHE sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_ARPROT sc_out sc_lv 3 signal 9 } 
	{ m_axi_gmem3_0_ARQOS sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_ARREGION sc_out sc_lv 4 signal 9 } 
	{ m_axi_gmem3_0_ARUSER sc_out sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_RVALID sc_in sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_RREADY sc_out sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_RDATA sc_in sc_lv 32 signal 9 } 
	{ m_axi_gmem3_0_RLAST sc_in sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_RID sc_in sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_RFIFONUM sc_in sc_lv 9 signal 9 } 
	{ m_axi_gmem3_0_RUSER sc_in sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_RRESP sc_in sc_lv 2 signal 9 } 
	{ m_axi_gmem3_0_BVALID sc_in sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_BREADY sc_out sc_logic 1 signal 9 } 
	{ m_axi_gmem3_0_BRESP sc_in sc_lv 2 signal 9 } 
	{ m_axi_gmem3_0_BID sc_in sc_lv 1 signal 9 } 
	{ m_axi_gmem3_0_BUSER sc_in sc_lv 1 signal 9 } 
	{ x sc_in sc_lv 64 signal 10 } 
	{ y_partial_0_address0 sc_out sc_lv 10 signal 11 } 
	{ y_partial_0_ce0 sc_out sc_logic 1 signal 11 } 
	{ y_partial_0_d0 sc_out sc_lv 32 signal 11 } 
	{ y_partial_0_q0 sc_in sc_lv 32 signal 11 } 
	{ y_partial_0_we0 sc_out sc_logic 1 signal 11 } 
	{ y_partial_0_address1 sc_out sc_lv 10 signal 11 } 
	{ y_partial_0_ce1 sc_out sc_logic 1 signal 11 } 
	{ y_partial_0_d1 sc_out sc_lv 32 signal 11 } 
	{ y_partial_0_q1 sc_in sc_lv 32 signal 11 } 
	{ y_partial_0_we1 sc_out sc_logic 1 signal 11 } 
	{ y_partial_1_address0 sc_out sc_lv 10 signal 12 } 
	{ y_partial_1_ce0 sc_out sc_logic 1 signal 12 } 
	{ y_partial_1_d0 sc_out sc_lv 32 signal 12 } 
	{ y_partial_1_q0 sc_in sc_lv 32 signal 12 } 
	{ y_partial_1_we0 sc_out sc_logic 1 signal 12 } 
	{ y_partial_1_address1 sc_out sc_lv 10 signal 12 } 
	{ y_partial_1_ce1 sc_out sc_logic 1 signal 12 } 
	{ y_partial_1_d1 sc_out sc_lv 32 signal 12 } 
	{ y_partial_1_q1 sc_in sc_lv 32 signal 12 } 
	{ y_partial_1_we1 sc_out sc_logic 1 signal 12 } 
	{ y_partial_2_address0 sc_out sc_lv 10 signal 13 } 
	{ y_partial_2_ce0 sc_out sc_logic 1 signal 13 } 
	{ y_partial_2_d0 sc_out sc_lv 32 signal 13 } 
	{ y_partial_2_q0 sc_in sc_lv 32 signal 13 } 
	{ y_partial_2_we0 sc_out sc_logic 1 signal 13 } 
	{ y_partial_2_address1 sc_out sc_lv 10 signal 13 } 
	{ y_partial_2_ce1 sc_out sc_logic 1 signal 13 } 
	{ y_partial_2_d1 sc_out sc_lv 32 signal 13 } 
	{ y_partial_2_q1 sc_in sc_lv 32 signal 13 } 
	{ y_partial_2_we1 sc_out sc_logic 1 signal 13 } 
	{ y_partial_3_address0 sc_out sc_lv 10 signal 14 } 
	{ y_partial_3_ce0 sc_out sc_logic 1 signal 14 } 
	{ y_partial_3_d0 sc_out sc_lv 32 signal 14 } 
	{ y_partial_3_q0 sc_in sc_lv 32 signal 14 } 
	{ y_partial_3_we0 sc_out sc_logic 1 signal 14 } 
	{ y_partial_3_address1 sc_out sc_lv 10 signal 14 } 
	{ y_partial_3_ce1 sc_out sc_logic 1 signal 14 } 
	{ y_partial_3_d1 sc_out sc_lv 32 signal 14 } 
	{ y_partial_3_q1 sc_in sc_lv 32 signal 14 } 
	{ y_partial_3_we1 sc_out sc_logic 1 signal 14 } 
	{ y_partial_4_address0 sc_out sc_lv 10 signal 15 } 
	{ y_partial_4_ce0 sc_out sc_logic 1 signal 15 } 
	{ y_partial_4_d0 sc_out sc_lv 32 signal 15 } 
	{ y_partial_4_q0 sc_in sc_lv 32 signal 15 } 
	{ y_partial_4_we0 sc_out sc_logic 1 signal 15 } 
	{ y_partial_4_address1 sc_out sc_lv 10 signal 15 } 
	{ y_partial_4_ce1 sc_out sc_logic 1 signal 15 } 
	{ y_partial_4_d1 sc_out sc_lv 32 signal 15 } 
	{ y_partial_4_q1 sc_in sc_lv 32 signal 15 } 
	{ y_partial_4_we1 sc_out sc_logic 1 signal 15 } 
	{ y_partial_5_address0 sc_out sc_lv 10 signal 16 } 
	{ y_partial_5_ce0 sc_out sc_logic 1 signal 16 } 
	{ y_partial_5_d0 sc_out sc_lv 32 signal 16 } 
	{ y_partial_5_q0 sc_in sc_lv 32 signal 16 } 
	{ y_partial_5_we0 sc_out sc_logic 1 signal 16 } 
	{ y_partial_5_address1 sc_out sc_lv 10 signal 16 } 
	{ y_partial_5_ce1 sc_out sc_logic 1 signal 16 } 
	{ y_partial_5_d1 sc_out sc_lv 32 signal 16 } 
	{ y_partial_5_q1 sc_in sc_lv 32 signal 16 } 
	{ y_partial_5_we1 sc_out sc_logic 1 signal 16 } 
	{ y_partial_6_address0 sc_out sc_lv 10 signal 17 } 
	{ y_partial_6_ce0 sc_out sc_logic 1 signal 17 } 
	{ y_partial_6_d0 sc_out sc_lv 32 signal 17 } 
	{ y_partial_6_q0 sc_in sc_lv 32 signal 17 } 
	{ y_partial_6_we0 sc_out sc_logic 1 signal 17 } 
	{ y_partial_6_address1 sc_out sc_lv 10 signal 17 } 
	{ y_partial_6_ce1 sc_out sc_logic 1 signal 17 } 
	{ y_partial_6_d1 sc_out sc_lv 32 signal 17 } 
	{ y_partial_6_q1 sc_in sc_lv 32 signal 17 } 
	{ y_partial_6_we1 sc_out sc_logic 1 signal 17 } 
	{ y_partial_7_address0 sc_out sc_lv 10 signal 18 } 
	{ y_partial_7_ce0 sc_out sc_logic 1 signal 18 } 
	{ y_partial_7_d0 sc_out sc_lv 32 signal 18 } 
	{ y_partial_7_q0 sc_in sc_lv 32 signal 18 } 
	{ y_partial_7_we0 sc_out sc_logic 1 signal 18 } 
	{ y_partial_7_address1 sc_out sc_lv 10 signal 18 } 
	{ y_partial_7_ce1 sc_out sc_logic 1 signal 18 } 
	{ y_partial_7_d1 sc_out sc_lv 32 signal 18 } 
	{ y_partial_7_q1 sc_in sc_lv 32 signal 18 } 
	{ y_partial_7_we1 sc_out sc_logic 1 signal 18 } 
	{ y_partial_8_address0 sc_out sc_lv 10 signal 19 } 
	{ y_partial_8_ce0 sc_out sc_logic 1 signal 19 } 
	{ y_partial_8_d0 sc_out sc_lv 32 signal 19 } 
	{ y_partial_8_q0 sc_in sc_lv 32 signal 19 } 
	{ y_partial_8_we0 sc_out sc_logic 1 signal 19 } 
	{ y_partial_8_address1 sc_out sc_lv 10 signal 19 } 
	{ y_partial_8_ce1 sc_out sc_logic 1 signal 19 } 
	{ y_partial_8_d1 sc_out sc_lv 32 signal 19 } 
	{ y_partial_8_q1 sc_in sc_lv 32 signal 19 } 
	{ y_partial_8_we1 sc_out sc_logic 1 signal 19 } 
	{ y_partial_9_address0 sc_out sc_lv 10 signal 20 } 
	{ y_partial_9_ce0 sc_out sc_logic 1 signal 20 } 
	{ y_partial_9_d0 sc_out sc_lv 32 signal 20 } 
	{ y_partial_9_q0 sc_in sc_lv 32 signal 20 } 
	{ y_partial_9_we0 sc_out sc_logic 1 signal 20 } 
	{ y_partial_9_address1 sc_out sc_lv 10 signal 20 } 
	{ y_partial_9_ce1 sc_out sc_logic 1 signal 20 } 
	{ y_partial_9_d1 sc_out sc_lv 32 signal 20 } 
	{ y_partial_9_q1 sc_in sc_lv 32 signal 20 } 
	{ y_partial_9_we1 sc_out sc_logic 1 signal 20 } 
	{ y_partial_10_address0 sc_out sc_lv 10 signal 21 } 
	{ y_partial_10_ce0 sc_out sc_logic 1 signal 21 } 
	{ y_partial_10_d0 sc_out sc_lv 32 signal 21 } 
	{ y_partial_10_q0 sc_in sc_lv 32 signal 21 } 
	{ y_partial_10_we0 sc_out sc_logic 1 signal 21 } 
	{ y_partial_10_address1 sc_out sc_lv 10 signal 21 } 
	{ y_partial_10_ce1 sc_out sc_logic 1 signal 21 } 
	{ y_partial_10_d1 sc_out sc_lv 32 signal 21 } 
	{ y_partial_10_q1 sc_in sc_lv 32 signal 21 } 
	{ y_partial_10_we1 sc_out sc_logic 1 signal 21 } 
	{ y_partial_11_address0 sc_out sc_lv 10 signal 22 } 
	{ y_partial_11_ce0 sc_out sc_logic 1 signal 22 } 
	{ y_partial_11_d0 sc_out sc_lv 32 signal 22 } 
	{ y_partial_11_q0 sc_in sc_lv 32 signal 22 } 
	{ y_partial_11_we0 sc_out sc_logic 1 signal 22 } 
	{ y_partial_11_address1 sc_out sc_lv 10 signal 22 } 
	{ y_partial_11_ce1 sc_out sc_logic 1 signal 22 } 
	{ y_partial_11_d1 sc_out sc_lv 32 signal 22 } 
	{ y_partial_11_q1 sc_in sc_lv 32 signal 22 } 
	{ y_partial_11_we1 sc_out sc_logic 1 signal 22 } 
	{ y_partial_12_address0 sc_out sc_lv 10 signal 23 } 
	{ y_partial_12_ce0 sc_out sc_logic 1 signal 23 } 
	{ y_partial_12_d0 sc_out sc_lv 32 signal 23 } 
	{ y_partial_12_q0 sc_in sc_lv 32 signal 23 } 
	{ y_partial_12_we0 sc_out sc_logic 1 signal 23 } 
	{ y_partial_12_address1 sc_out sc_lv 10 signal 23 } 
	{ y_partial_12_ce1 sc_out sc_logic 1 signal 23 } 
	{ y_partial_12_d1 sc_out sc_lv 32 signal 23 } 
	{ y_partial_12_q1 sc_in sc_lv 32 signal 23 } 
	{ y_partial_12_we1 sc_out sc_logic 1 signal 23 } 
	{ y_partial_13_address0 sc_out sc_lv 10 signal 24 } 
	{ y_partial_13_ce0 sc_out sc_logic 1 signal 24 } 
	{ y_partial_13_d0 sc_out sc_lv 32 signal 24 } 
	{ y_partial_13_q0 sc_in sc_lv 32 signal 24 } 
	{ y_partial_13_we0 sc_out sc_logic 1 signal 24 } 
	{ y_partial_13_address1 sc_out sc_lv 10 signal 24 } 
	{ y_partial_13_ce1 sc_out sc_logic 1 signal 24 } 
	{ y_partial_13_d1 sc_out sc_lv 32 signal 24 } 
	{ y_partial_13_q1 sc_in sc_lv 32 signal 24 } 
	{ y_partial_13_we1 sc_out sc_logic 1 signal 24 } 
	{ y_partial_14_address0 sc_out sc_lv 10 signal 25 } 
	{ y_partial_14_ce0 sc_out sc_logic 1 signal 25 } 
	{ y_partial_14_d0 sc_out sc_lv 32 signal 25 } 
	{ y_partial_14_q0 sc_in sc_lv 32 signal 25 } 
	{ y_partial_14_we0 sc_out sc_logic 1 signal 25 } 
	{ y_partial_14_address1 sc_out sc_lv 10 signal 25 } 
	{ y_partial_14_ce1 sc_out sc_logic 1 signal 25 } 
	{ y_partial_14_d1 sc_out sc_lv 32 signal 25 } 
	{ y_partial_14_q1 sc_in sc_lv 32 signal 25 } 
	{ y_partial_14_we1 sc_out sc_logic 1 signal 25 } 
	{ y_partial_15_address0 sc_out sc_lv 10 signal 26 } 
	{ y_partial_15_ce0 sc_out sc_logic 1 signal 26 } 
	{ y_partial_15_d0 sc_out sc_lv 32 signal 26 } 
	{ y_partial_15_q0 sc_in sc_lv 32 signal 26 } 
	{ y_partial_15_we0 sc_out sc_logic 1 signal 26 } 
	{ y_partial_15_address1 sc_out sc_lv 10 signal 26 } 
	{ y_partial_15_ce1 sc_out sc_logic 1 signal 26 } 
	{ y_partial_15_d1 sc_out sc_lv 32 signal 26 } 
	{ y_partial_15_q1 sc_in sc_lv 32 signal 26 } 
	{ y_partial_15_we1 sc_out sc_logic 1 signal 26 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ num_rows_ap_vld sc_in sc_logic 1 invld 0 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ num_cols_ap_vld sc_in sc_logic 1 invld 1 } 
	{ A_col_ptr_ap_vld sc_in sc_logic 1 invld 6 } 
	{ x_ap_vld sc_in sc_logic 1 invld 10 } 
	{ nnz_ap_vld sc_in sc_logic 1 invld 2 } 
	{ A_row_idx_ap_vld sc_in sc_logic 1 invld 4 } 
	{ A_values_ap_vld sc_in sc_logic 1 invld 8 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "num_rows", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_rows", "role": "default" }} , 
 	{ "name": "num_cols", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "num_cols", "role": "default" }} , 
 	{ "name": "nnz", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "nnz", "role": "default" }} , 
 	{ "name": "m_axi_gmem0_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWVALID" }} , 
 	{ "name": "m_axi_gmem0_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWREADY" }} , 
 	{ "name": "m_axi_gmem0_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWADDR" }} , 
 	{ "name": "m_axi_gmem0_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWID" }} , 
 	{ "name": "m_axi_gmem0_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWLEN" }} , 
 	{ "name": "m_axi_gmem0_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWSIZE" }} , 
 	{ "name": "m_axi_gmem0_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWBURST" }} , 
 	{ "name": "m_axi_gmem0_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWLOCK" }} , 
 	{ "name": "m_axi_gmem0_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWCACHE" }} , 
 	{ "name": "m_axi_gmem0_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWPROT" }} , 
 	{ "name": "m_axi_gmem0_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWQOS" }} , 
 	{ "name": "m_axi_gmem0_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWREGION" }} , 
 	{ "name": "m_axi_gmem0_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_AWUSER" }} , 
 	{ "name": "m_axi_gmem0_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WVALID" }} , 
 	{ "name": "m_axi_gmem0_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WREADY" }} , 
 	{ "name": "m_axi_gmem0_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WDATA" }} , 
 	{ "name": "m_axi_gmem0_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WSTRB" }} , 
 	{ "name": "m_axi_gmem0_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WLAST" }} , 
 	{ "name": "m_axi_gmem0_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WID" }} , 
 	{ "name": "m_axi_gmem0_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_WUSER" }} , 
 	{ "name": "m_axi_gmem0_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARVALID" }} , 
 	{ "name": "m_axi_gmem0_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARREADY" }} , 
 	{ "name": "m_axi_gmem0_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARADDR" }} , 
 	{ "name": "m_axi_gmem0_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARID" }} , 
 	{ "name": "m_axi_gmem0_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARLEN" }} , 
 	{ "name": "m_axi_gmem0_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARSIZE" }} , 
 	{ "name": "m_axi_gmem0_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARBURST" }} , 
 	{ "name": "m_axi_gmem0_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARLOCK" }} , 
 	{ "name": "m_axi_gmem0_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARCACHE" }} , 
 	{ "name": "m_axi_gmem0_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARPROT" }} , 
 	{ "name": "m_axi_gmem0_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARQOS" }} , 
 	{ "name": "m_axi_gmem0_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARREGION" }} , 
 	{ "name": "m_axi_gmem0_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_ARUSER" }} , 
 	{ "name": "m_axi_gmem0_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RVALID" }} , 
 	{ "name": "m_axi_gmem0_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RREADY" }} , 
 	{ "name": "m_axi_gmem0_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RDATA" }} , 
 	{ "name": "m_axi_gmem0_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RLAST" }} , 
 	{ "name": "m_axi_gmem0_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RID" }} , 
 	{ "name": "m_axi_gmem0_0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RFIFONUM" }} , 
 	{ "name": "m_axi_gmem0_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RUSER" }} , 
 	{ "name": "m_axi_gmem0_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "0_RRESP" }} , 
 	{ "name": "m_axi_gmem0_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_BVALID" }} , 
 	{ "name": "m_axi_gmem0_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_BREADY" }} , 
 	{ "name": "m_axi_gmem0_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "0_BRESP" }} , 
 	{ "name": "m_axi_gmem0_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_BID" }} , 
 	{ "name": "m_axi_gmem0_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "0_BUSER" }} , 
 	{ "name": "A_row_idx", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "A_row_idx", "role": "default" }} , 
 	{ "name": "m_axi_gmem1_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWVALID" }} , 
 	{ "name": "m_axi_gmem1_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWREADY" }} , 
 	{ "name": "m_axi_gmem1_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWADDR" }} , 
 	{ "name": "m_axi_gmem1_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWID" }} , 
 	{ "name": "m_axi_gmem1_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWLEN" }} , 
 	{ "name": "m_axi_gmem1_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWSIZE" }} , 
 	{ "name": "m_axi_gmem1_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWBURST" }} , 
 	{ "name": "m_axi_gmem1_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWLOCK" }} , 
 	{ "name": "m_axi_gmem1_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWCACHE" }} , 
 	{ "name": "m_axi_gmem1_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWPROT" }} , 
 	{ "name": "m_axi_gmem1_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWQOS" }} , 
 	{ "name": "m_axi_gmem1_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWREGION" }} , 
 	{ "name": "m_axi_gmem1_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_AWUSER" }} , 
 	{ "name": "m_axi_gmem1_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WVALID" }} , 
 	{ "name": "m_axi_gmem1_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WREADY" }} , 
 	{ "name": "m_axi_gmem1_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WDATA" }} , 
 	{ "name": "m_axi_gmem1_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WSTRB" }} , 
 	{ "name": "m_axi_gmem1_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WLAST" }} , 
 	{ "name": "m_axi_gmem1_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WID" }} , 
 	{ "name": "m_axi_gmem1_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_WUSER" }} , 
 	{ "name": "m_axi_gmem1_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARVALID" }} , 
 	{ "name": "m_axi_gmem1_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARREADY" }} , 
 	{ "name": "m_axi_gmem1_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARADDR" }} , 
 	{ "name": "m_axi_gmem1_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARID" }} , 
 	{ "name": "m_axi_gmem1_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARLEN" }} , 
 	{ "name": "m_axi_gmem1_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARSIZE" }} , 
 	{ "name": "m_axi_gmem1_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARBURST" }} , 
 	{ "name": "m_axi_gmem1_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARLOCK" }} , 
 	{ "name": "m_axi_gmem1_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARCACHE" }} , 
 	{ "name": "m_axi_gmem1_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARPROT" }} , 
 	{ "name": "m_axi_gmem1_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARQOS" }} , 
 	{ "name": "m_axi_gmem1_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARREGION" }} , 
 	{ "name": "m_axi_gmem1_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_ARUSER" }} , 
 	{ "name": "m_axi_gmem1_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RVALID" }} , 
 	{ "name": "m_axi_gmem1_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RREADY" }} , 
 	{ "name": "m_axi_gmem1_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RDATA" }} , 
 	{ "name": "m_axi_gmem1_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RLAST" }} , 
 	{ "name": "m_axi_gmem1_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RID" }} , 
 	{ "name": "m_axi_gmem1_0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RFIFONUM" }} , 
 	{ "name": "m_axi_gmem1_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RUSER" }} , 
 	{ "name": "m_axi_gmem1_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_RRESP" }} , 
 	{ "name": "m_axi_gmem1_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BVALID" }} , 
 	{ "name": "m_axi_gmem1_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BREADY" }} , 
 	{ "name": "m_axi_gmem1_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BRESP" }} , 
 	{ "name": "m_axi_gmem1_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BID" }} , 
 	{ "name": "m_axi_gmem1_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "0_BUSER" }} , 
 	{ "name": "A_col_ptr", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "A_col_ptr", "role": "default" }} , 
 	{ "name": "m_axi_gmem2_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWVALID" }} , 
 	{ "name": "m_axi_gmem2_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWREADY" }} , 
 	{ "name": "m_axi_gmem2_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWADDR" }} , 
 	{ "name": "m_axi_gmem2_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWID" }} , 
 	{ "name": "m_axi_gmem2_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWLEN" }} , 
 	{ "name": "m_axi_gmem2_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWSIZE" }} , 
 	{ "name": "m_axi_gmem2_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWBURST" }} , 
 	{ "name": "m_axi_gmem2_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWLOCK" }} , 
 	{ "name": "m_axi_gmem2_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWCACHE" }} , 
 	{ "name": "m_axi_gmem2_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWPROT" }} , 
 	{ "name": "m_axi_gmem2_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWQOS" }} , 
 	{ "name": "m_axi_gmem2_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWREGION" }} , 
 	{ "name": "m_axi_gmem2_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_AWUSER" }} , 
 	{ "name": "m_axi_gmem2_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WVALID" }} , 
 	{ "name": "m_axi_gmem2_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WREADY" }} , 
 	{ "name": "m_axi_gmem2_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WDATA" }} , 
 	{ "name": "m_axi_gmem2_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WSTRB" }} , 
 	{ "name": "m_axi_gmem2_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WLAST" }} , 
 	{ "name": "m_axi_gmem2_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WID" }} , 
 	{ "name": "m_axi_gmem2_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_WUSER" }} , 
 	{ "name": "m_axi_gmem2_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARVALID" }} , 
 	{ "name": "m_axi_gmem2_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARREADY" }} , 
 	{ "name": "m_axi_gmem2_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARADDR" }} , 
 	{ "name": "m_axi_gmem2_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARID" }} , 
 	{ "name": "m_axi_gmem2_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARLEN" }} , 
 	{ "name": "m_axi_gmem2_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARSIZE" }} , 
 	{ "name": "m_axi_gmem2_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARBURST" }} , 
 	{ "name": "m_axi_gmem2_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARLOCK" }} , 
 	{ "name": "m_axi_gmem2_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARCACHE" }} , 
 	{ "name": "m_axi_gmem2_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARPROT" }} , 
 	{ "name": "m_axi_gmem2_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARQOS" }} , 
 	{ "name": "m_axi_gmem2_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARREGION" }} , 
 	{ "name": "m_axi_gmem2_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_ARUSER" }} , 
 	{ "name": "m_axi_gmem2_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RVALID" }} , 
 	{ "name": "m_axi_gmem2_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RREADY" }} , 
 	{ "name": "m_axi_gmem2_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RDATA" }} , 
 	{ "name": "m_axi_gmem2_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RLAST" }} , 
 	{ "name": "m_axi_gmem2_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RID" }} , 
 	{ "name": "m_axi_gmem2_0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RFIFONUM" }} , 
 	{ "name": "m_axi_gmem2_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RUSER" }} , 
 	{ "name": "m_axi_gmem2_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "0_RRESP" }} , 
 	{ "name": "m_axi_gmem2_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_BVALID" }} , 
 	{ "name": "m_axi_gmem2_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_BREADY" }} , 
 	{ "name": "m_axi_gmem2_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "0_BRESP" }} , 
 	{ "name": "m_axi_gmem2_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_BID" }} , 
 	{ "name": "m_axi_gmem2_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "0_BUSER" }} , 
 	{ "name": "A_values", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "A_values", "role": "default" }} , 
 	{ "name": "m_axi_gmem3_0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWVALID" }} , 
 	{ "name": "m_axi_gmem3_0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWREADY" }} , 
 	{ "name": "m_axi_gmem3_0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWADDR" }} , 
 	{ "name": "m_axi_gmem3_0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWID" }} , 
 	{ "name": "m_axi_gmem3_0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWLEN" }} , 
 	{ "name": "m_axi_gmem3_0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWSIZE" }} , 
 	{ "name": "m_axi_gmem3_0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWBURST" }} , 
 	{ "name": "m_axi_gmem3_0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWLOCK" }} , 
 	{ "name": "m_axi_gmem3_0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWCACHE" }} , 
 	{ "name": "m_axi_gmem3_0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWPROT" }} , 
 	{ "name": "m_axi_gmem3_0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWQOS" }} , 
 	{ "name": "m_axi_gmem3_0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWREGION" }} , 
 	{ "name": "m_axi_gmem3_0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_AWUSER" }} , 
 	{ "name": "m_axi_gmem3_0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WVALID" }} , 
 	{ "name": "m_axi_gmem3_0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WREADY" }} , 
 	{ "name": "m_axi_gmem3_0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WDATA" }} , 
 	{ "name": "m_axi_gmem3_0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WSTRB" }} , 
 	{ "name": "m_axi_gmem3_0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WLAST" }} , 
 	{ "name": "m_axi_gmem3_0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WID" }} , 
 	{ "name": "m_axi_gmem3_0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_WUSER" }} , 
 	{ "name": "m_axi_gmem3_0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARVALID" }} , 
 	{ "name": "m_axi_gmem3_0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARREADY" }} , 
 	{ "name": "m_axi_gmem3_0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARADDR" }} , 
 	{ "name": "m_axi_gmem3_0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARID" }} , 
 	{ "name": "m_axi_gmem3_0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARLEN" }} , 
 	{ "name": "m_axi_gmem3_0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARSIZE" }} , 
 	{ "name": "m_axi_gmem3_0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARBURST" }} , 
 	{ "name": "m_axi_gmem3_0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARLOCK" }} , 
 	{ "name": "m_axi_gmem3_0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARCACHE" }} , 
 	{ "name": "m_axi_gmem3_0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARPROT" }} , 
 	{ "name": "m_axi_gmem3_0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARQOS" }} , 
 	{ "name": "m_axi_gmem3_0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARREGION" }} , 
 	{ "name": "m_axi_gmem3_0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_ARUSER" }} , 
 	{ "name": "m_axi_gmem3_0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RVALID" }} , 
 	{ "name": "m_axi_gmem3_0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RREADY" }} , 
 	{ "name": "m_axi_gmem3_0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RDATA" }} , 
 	{ "name": "m_axi_gmem3_0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RLAST" }} , 
 	{ "name": "m_axi_gmem3_0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RID" }} , 
 	{ "name": "m_axi_gmem3_0_RFIFONUM", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RFIFONUM" }} , 
 	{ "name": "m_axi_gmem3_0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RUSER" }} , 
 	{ "name": "m_axi_gmem3_0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "0_RRESP" }} , 
 	{ "name": "m_axi_gmem3_0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_BVALID" }} , 
 	{ "name": "m_axi_gmem3_0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_BREADY" }} , 
 	{ "name": "m_axi_gmem3_0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "0_BRESP" }} , 
 	{ "name": "m_axi_gmem3_0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_BID" }} , 
 	{ "name": "m_axi_gmem3_0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "0_BUSER" }} , 
 	{ "name": "x", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "x", "role": "default" }} , 
 	{ "name": "y_partial_0_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_0", "role": "address0" }} , 
 	{ "name": "y_partial_0_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_0", "role": "ce0" }} , 
 	{ "name": "y_partial_0_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_0", "role": "d0" }} , 
 	{ "name": "y_partial_0_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_0", "role": "q0" }} , 
 	{ "name": "y_partial_0_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_0", "role": "we0" }} , 
 	{ "name": "y_partial_0_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_0", "role": "address1" }} , 
 	{ "name": "y_partial_0_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_0", "role": "ce1" }} , 
 	{ "name": "y_partial_0_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_0", "role": "d1" }} , 
 	{ "name": "y_partial_0_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_0", "role": "q1" }} , 
 	{ "name": "y_partial_0_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_0", "role": "we1" }} , 
 	{ "name": "y_partial_1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_1", "role": "address0" }} , 
 	{ "name": "y_partial_1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_1", "role": "ce0" }} , 
 	{ "name": "y_partial_1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_1", "role": "d0" }} , 
 	{ "name": "y_partial_1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_1", "role": "q0" }} , 
 	{ "name": "y_partial_1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_1", "role": "we0" }} , 
 	{ "name": "y_partial_1_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_1", "role": "address1" }} , 
 	{ "name": "y_partial_1_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_1", "role": "ce1" }} , 
 	{ "name": "y_partial_1_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_1", "role": "d1" }} , 
 	{ "name": "y_partial_1_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_1", "role": "q1" }} , 
 	{ "name": "y_partial_1_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_1", "role": "we1" }} , 
 	{ "name": "y_partial_2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_2", "role": "address0" }} , 
 	{ "name": "y_partial_2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_2", "role": "ce0" }} , 
 	{ "name": "y_partial_2_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_2", "role": "d0" }} , 
 	{ "name": "y_partial_2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_2", "role": "q0" }} , 
 	{ "name": "y_partial_2_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_2", "role": "we0" }} , 
 	{ "name": "y_partial_2_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_2", "role": "address1" }} , 
 	{ "name": "y_partial_2_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_2", "role": "ce1" }} , 
 	{ "name": "y_partial_2_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_2", "role": "d1" }} , 
 	{ "name": "y_partial_2_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_2", "role": "q1" }} , 
 	{ "name": "y_partial_2_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_2", "role": "we1" }} , 
 	{ "name": "y_partial_3_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_3", "role": "address0" }} , 
 	{ "name": "y_partial_3_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_3", "role": "ce0" }} , 
 	{ "name": "y_partial_3_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_3", "role": "d0" }} , 
 	{ "name": "y_partial_3_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_3", "role": "q0" }} , 
 	{ "name": "y_partial_3_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_3", "role": "we0" }} , 
 	{ "name": "y_partial_3_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_3", "role": "address1" }} , 
 	{ "name": "y_partial_3_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_3", "role": "ce1" }} , 
 	{ "name": "y_partial_3_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_3", "role": "d1" }} , 
 	{ "name": "y_partial_3_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_3", "role": "q1" }} , 
 	{ "name": "y_partial_3_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_3", "role": "we1" }} , 
 	{ "name": "y_partial_4_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_4", "role": "address0" }} , 
 	{ "name": "y_partial_4_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_4", "role": "ce0" }} , 
 	{ "name": "y_partial_4_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_4", "role": "d0" }} , 
 	{ "name": "y_partial_4_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_4", "role": "q0" }} , 
 	{ "name": "y_partial_4_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_4", "role": "we0" }} , 
 	{ "name": "y_partial_4_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_4", "role": "address1" }} , 
 	{ "name": "y_partial_4_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_4", "role": "ce1" }} , 
 	{ "name": "y_partial_4_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_4", "role": "d1" }} , 
 	{ "name": "y_partial_4_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_4", "role": "q1" }} , 
 	{ "name": "y_partial_4_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_4", "role": "we1" }} , 
 	{ "name": "y_partial_5_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_5", "role": "address0" }} , 
 	{ "name": "y_partial_5_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_5", "role": "ce0" }} , 
 	{ "name": "y_partial_5_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_5", "role": "d0" }} , 
 	{ "name": "y_partial_5_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_5", "role": "q0" }} , 
 	{ "name": "y_partial_5_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_5", "role": "we0" }} , 
 	{ "name": "y_partial_5_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_5", "role": "address1" }} , 
 	{ "name": "y_partial_5_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_5", "role": "ce1" }} , 
 	{ "name": "y_partial_5_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_5", "role": "d1" }} , 
 	{ "name": "y_partial_5_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_5", "role": "q1" }} , 
 	{ "name": "y_partial_5_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_5", "role": "we1" }} , 
 	{ "name": "y_partial_6_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_6", "role": "address0" }} , 
 	{ "name": "y_partial_6_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_6", "role": "ce0" }} , 
 	{ "name": "y_partial_6_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_6", "role": "d0" }} , 
 	{ "name": "y_partial_6_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_6", "role": "q0" }} , 
 	{ "name": "y_partial_6_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_6", "role": "we0" }} , 
 	{ "name": "y_partial_6_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_6", "role": "address1" }} , 
 	{ "name": "y_partial_6_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_6", "role": "ce1" }} , 
 	{ "name": "y_partial_6_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_6", "role": "d1" }} , 
 	{ "name": "y_partial_6_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_6", "role": "q1" }} , 
 	{ "name": "y_partial_6_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_6", "role": "we1" }} , 
 	{ "name": "y_partial_7_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_7", "role": "address0" }} , 
 	{ "name": "y_partial_7_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_7", "role": "ce0" }} , 
 	{ "name": "y_partial_7_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_7", "role": "d0" }} , 
 	{ "name": "y_partial_7_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_7", "role": "q0" }} , 
 	{ "name": "y_partial_7_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_7", "role": "we0" }} , 
 	{ "name": "y_partial_7_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_7", "role": "address1" }} , 
 	{ "name": "y_partial_7_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_7", "role": "ce1" }} , 
 	{ "name": "y_partial_7_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_7", "role": "d1" }} , 
 	{ "name": "y_partial_7_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_7", "role": "q1" }} , 
 	{ "name": "y_partial_7_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_7", "role": "we1" }} , 
 	{ "name": "y_partial_8_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_8", "role": "address0" }} , 
 	{ "name": "y_partial_8_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_8", "role": "ce0" }} , 
 	{ "name": "y_partial_8_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_8", "role": "d0" }} , 
 	{ "name": "y_partial_8_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_8", "role": "q0" }} , 
 	{ "name": "y_partial_8_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_8", "role": "we0" }} , 
 	{ "name": "y_partial_8_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_8", "role": "address1" }} , 
 	{ "name": "y_partial_8_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_8", "role": "ce1" }} , 
 	{ "name": "y_partial_8_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_8", "role": "d1" }} , 
 	{ "name": "y_partial_8_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_8", "role": "q1" }} , 
 	{ "name": "y_partial_8_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_8", "role": "we1" }} , 
 	{ "name": "y_partial_9_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_9", "role": "address0" }} , 
 	{ "name": "y_partial_9_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_9", "role": "ce0" }} , 
 	{ "name": "y_partial_9_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_9", "role": "d0" }} , 
 	{ "name": "y_partial_9_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_9", "role": "q0" }} , 
 	{ "name": "y_partial_9_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_9", "role": "we0" }} , 
 	{ "name": "y_partial_9_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_9", "role": "address1" }} , 
 	{ "name": "y_partial_9_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_9", "role": "ce1" }} , 
 	{ "name": "y_partial_9_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_9", "role": "d1" }} , 
 	{ "name": "y_partial_9_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_9", "role": "q1" }} , 
 	{ "name": "y_partial_9_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_9", "role": "we1" }} , 
 	{ "name": "y_partial_10_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_10", "role": "address0" }} , 
 	{ "name": "y_partial_10_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_10", "role": "ce0" }} , 
 	{ "name": "y_partial_10_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_10", "role": "d0" }} , 
 	{ "name": "y_partial_10_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_10", "role": "q0" }} , 
 	{ "name": "y_partial_10_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_10", "role": "we0" }} , 
 	{ "name": "y_partial_10_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_10", "role": "address1" }} , 
 	{ "name": "y_partial_10_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_10", "role": "ce1" }} , 
 	{ "name": "y_partial_10_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_10", "role": "d1" }} , 
 	{ "name": "y_partial_10_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_10", "role": "q1" }} , 
 	{ "name": "y_partial_10_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_10", "role": "we1" }} , 
 	{ "name": "y_partial_11_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_11", "role": "address0" }} , 
 	{ "name": "y_partial_11_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_11", "role": "ce0" }} , 
 	{ "name": "y_partial_11_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_11", "role": "d0" }} , 
 	{ "name": "y_partial_11_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_11", "role": "q0" }} , 
 	{ "name": "y_partial_11_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_11", "role": "we0" }} , 
 	{ "name": "y_partial_11_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_11", "role": "address1" }} , 
 	{ "name": "y_partial_11_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_11", "role": "ce1" }} , 
 	{ "name": "y_partial_11_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_11", "role": "d1" }} , 
 	{ "name": "y_partial_11_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_11", "role": "q1" }} , 
 	{ "name": "y_partial_11_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_11", "role": "we1" }} , 
 	{ "name": "y_partial_12_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_12", "role": "address0" }} , 
 	{ "name": "y_partial_12_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_12", "role": "ce0" }} , 
 	{ "name": "y_partial_12_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_12", "role": "d0" }} , 
 	{ "name": "y_partial_12_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_12", "role": "q0" }} , 
 	{ "name": "y_partial_12_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_12", "role": "we0" }} , 
 	{ "name": "y_partial_12_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_12", "role": "address1" }} , 
 	{ "name": "y_partial_12_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_12", "role": "ce1" }} , 
 	{ "name": "y_partial_12_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_12", "role": "d1" }} , 
 	{ "name": "y_partial_12_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_12", "role": "q1" }} , 
 	{ "name": "y_partial_12_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_12", "role": "we1" }} , 
 	{ "name": "y_partial_13_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_13", "role": "address0" }} , 
 	{ "name": "y_partial_13_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_13", "role": "ce0" }} , 
 	{ "name": "y_partial_13_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_13", "role": "d0" }} , 
 	{ "name": "y_partial_13_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_13", "role": "q0" }} , 
 	{ "name": "y_partial_13_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_13", "role": "we0" }} , 
 	{ "name": "y_partial_13_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_13", "role": "address1" }} , 
 	{ "name": "y_partial_13_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_13", "role": "ce1" }} , 
 	{ "name": "y_partial_13_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_13", "role": "d1" }} , 
 	{ "name": "y_partial_13_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_13", "role": "q1" }} , 
 	{ "name": "y_partial_13_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_13", "role": "we1" }} , 
 	{ "name": "y_partial_14_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_14", "role": "address0" }} , 
 	{ "name": "y_partial_14_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_14", "role": "ce0" }} , 
 	{ "name": "y_partial_14_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_14", "role": "d0" }} , 
 	{ "name": "y_partial_14_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_14", "role": "q0" }} , 
 	{ "name": "y_partial_14_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_14", "role": "we0" }} , 
 	{ "name": "y_partial_14_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_14", "role": "address1" }} , 
 	{ "name": "y_partial_14_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_14", "role": "ce1" }} , 
 	{ "name": "y_partial_14_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_14", "role": "d1" }} , 
 	{ "name": "y_partial_14_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_14", "role": "q1" }} , 
 	{ "name": "y_partial_14_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_14", "role": "we1" }} , 
 	{ "name": "y_partial_15_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_15", "role": "address0" }} , 
 	{ "name": "y_partial_15_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_15", "role": "ce0" }} , 
 	{ "name": "y_partial_15_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_15", "role": "d0" }} , 
 	{ "name": "y_partial_15_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_15", "role": "q0" }} , 
 	{ "name": "y_partial_15_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_15", "role": "we0" }} , 
 	{ "name": "y_partial_15_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "y_partial_15", "role": "address1" }} , 
 	{ "name": "y_partial_15_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_15", "role": "ce1" }} , 
 	{ "name": "y_partial_15_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_15", "role": "d1" }} , 
 	{ "name": "y_partial_15_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_partial_15", "role": "q1" }} , 
 	{ "name": "y_partial_15_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_partial_15", "role": "we1" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "num_rows_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "num_rows", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "num_cols_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "num_cols", "role": "ap_vld" }} , 
 	{ "name": "A_col_ptr_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_col_ptr", "role": "ap_vld" }} , 
 	{ "name": "x_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "x", "role": "ap_vld" }} , 
 	{ "name": "nnz_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "nnz", "role": "ap_vld" }} , 
 	{ "name": "A_row_idx_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_row_idx", "role": "ap_vld" }} , 
 	{ "name": "A_values_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "A_values", "role": "ap_vld" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "5", "8", "45", "52", "59", "66", "73", "80", "87", "94", "101", "108", "115", "122", "129", "136", "143", "150", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192"],
		"CDFG" : "spmv_csc_dataflow",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"InputProcess" : [
			{"ID" : "1", "Name" : "entry_proc_U0"},
			{"ID" : "2", "Name" : "read_col_info_U0"},
			{"ID" : "5", "Name" : "read_nnz_packed_U0"},
			{"ID" : "45", "Name" : "compute_pe_U0"},
			{"ID" : "52", "Name" : "compute_pe_1_U0"},
			{"ID" : "59", "Name" : "compute_pe_2_U0"},
			{"ID" : "66", "Name" : "compute_pe_3_U0"},
			{"ID" : "73", "Name" : "compute_pe_4_U0"},
			{"ID" : "80", "Name" : "compute_pe_5_U0"},
			{"ID" : "87", "Name" : "compute_pe_6_U0"},
			{"ID" : "94", "Name" : "compute_pe_7_U0"},
			{"ID" : "101", "Name" : "compute_pe_8_U0"},
			{"ID" : "108", "Name" : "compute_pe_9_U0"},
			{"ID" : "115", "Name" : "compute_pe_10_U0"},
			{"ID" : "122", "Name" : "compute_pe_11_U0"},
			{"ID" : "129", "Name" : "compute_pe_12_U0"},
			{"ID" : "136", "Name" : "compute_pe_13_U0"},
			{"ID" : "143", "Name" : "compute_pe_14_U0"},
			{"ID" : "150", "Name" : "compute_pe_15_U0"}],
		"OutputProcess" : [
			{"ID" : "45", "Name" : "compute_pe_U0"},
			{"ID" : "52", "Name" : "compute_pe_1_U0"},
			{"ID" : "59", "Name" : "compute_pe_2_U0"},
			{"ID" : "66", "Name" : "compute_pe_3_U0"},
			{"ID" : "73", "Name" : "compute_pe_4_U0"},
			{"ID" : "80", "Name" : "compute_pe_5_U0"},
			{"ID" : "87", "Name" : "compute_pe_6_U0"},
			{"ID" : "94", "Name" : "compute_pe_7_U0"},
			{"ID" : "101", "Name" : "compute_pe_8_U0"},
			{"ID" : "108", "Name" : "compute_pe_9_U0"},
			{"ID" : "115", "Name" : "compute_pe_10_U0"},
			{"ID" : "122", "Name" : "compute_pe_11_U0"},
			{"ID" : "129", "Name" : "compute_pe_12_U0"},
			{"ID" : "136", "Name" : "compute_pe_13_U0"},
			{"ID" : "143", "Name" : "compute_pe_14_U0"},
			{"ID" : "150", "Name" : "compute_pe_15_U0"}],
		"Port" : [
			{"Name" : "num_rows", "Type" : "None", "Direction" : "I"},
			{"Name" : "num_cols", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem0", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "read_nnz_packed_U0", "Port" : "gmem0"}]},
			{"Name" : "A_row_idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem1", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "read_col_info_U0", "Port" : "gmem1"}]},
			{"Name" : "A_col_ptr", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "read_nnz_packed_U0", "Port" : "gmem2"}]},
			{"Name" : "A_values", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem3", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "read_col_info_U0", "Port" : "gmem3"}]},
			{"Name" : "x", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial_0", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "45", "SubInstance" : "compute_pe_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "52", "SubInstance" : "compute_pe_1_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_2", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "59", "SubInstance" : "compute_pe_2_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_3", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "66", "SubInstance" : "compute_pe_3_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_4", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "73", "SubInstance" : "compute_pe_4_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_5", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "80", "SubInstance" : "compute_pe_5_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_6", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "87", "SubInstance" : "compute_pe_6_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_7", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "94", "SubInstance" : "compute_pe_7_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_8", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "101", "SubInstance" : "compute_pe_8_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_9", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "108", "SubInstance" : "compute_pe_9_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_10", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "115", "SubInstance" : "compute_pe_10_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_11", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "122", "SubInstance" : "compute_pe_11_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_12", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "129", "SubInstance" : "compute_pe_12_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_13", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "136", "SubInstance" : "compute_pe_13_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_14", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "143", "SubInstance" : "compute_pe_14_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_15", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "150", "SubInstance" : "compute_pe_15_U0", "Port" : "y_partial"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.entry_proc_U0", "Parent" : "0",
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
			{"Name" : "num_rows_c", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["150"], "DependentChan" : "157", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["143"], "DependentChan" : "158", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["136"], "DependentChan" : "159", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c4", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["129"], "DependentChan" : "160", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c4_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c5", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["122"], "DependentChan" : "161", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c5_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c6", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["115"], "DependentChan" : "162", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c6_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c7", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["108"], "DependentChan" : "163", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c7_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c8", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["101"], "DependentChan" : "164", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c8_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c9", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["94"], "DependentChan" : "165", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c9_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c10", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["87"], "DependentChan" : "166", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c10_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c11", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["80"], "DependentChan" : "167", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c11_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c12", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["73"], "DependentChan" : "168", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c12_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c13", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["66"], "DependentChan" : "169", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c13_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c14", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["59"], "DependentChan" : "170", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c14_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c15", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["52"], "DependentChan" : "171", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c15_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c16", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["45"], "DependentChan" : "172", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c16_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.read_col_info_U0", "Parent" : "0", "Child" : ["3"],
		"CDFG" : "read_col_info",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_cols", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem1", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem1_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "gmem1_blk_n_R", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Port" : "gmem1", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "A_col_ptr", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem3", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem3_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "gmem3_blk_n_R", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Port" : "gmem3", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "x_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "col_info_stream", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["8"], "DependentChan" : "173", "DependentChanDepth" : "64", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "col_info_stream_blk_n", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Port" : "col_info_stream", "Inst_start_state" : "10", "Inst_end_state" : "11"}]}]},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.read_col_info_U0.grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Parent" : "2", "Child" : ["4"],
		"CDFG" : "read_col_info_Pipeline_VITIS_LOOP_46_1",
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
			{"Name" : "x_element", "Type" : "None", "Direction" : "I"},
			{"Name" : "prev", "Type" : "None", "Direction" : "I"},
			{"Name" : "sub", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem3", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem3_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "sext_ln46_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem1", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem1_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "sext_ln46", "Type" : "None", "Direction" : "I"},
			{"Name" : "col_info_stream", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "col_info_stream_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "p_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "prev_1_out", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_46_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter3", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter3", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "4", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.read_col_info_U0.grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149.flow_control_loop_pipe_sequential_init_U", "Parent" : "3"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.read_nnz_packed_U0", "Parent" : "0", "Child" : ["6"],
		"CDFG" : "read_nnz_packed",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "13", "EstimateLatencyMax" : "134217740",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "nnz", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem0", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem0_blk_n_AR", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Port" : "gmem0", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "row_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem2_blk_n_AR", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Port" : "gmem2", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "val_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz_stream", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["8"], "DependentChan" : "174", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Port" : "nnz_stream", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "nnz_c", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["8"], "DependentChan" : "175", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "nnz_c_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.read_nnz_packed_U0.grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Parent" : "5", "Child" : ["7"],
		"CDFG" : "read_nnz_packed_Pipeline_VITIS_LOOP_89_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "3", "EstimateLatencyMax" : "134217730",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "words", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem0", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem0_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "sext_ln89", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem2_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "sext_ln89_2", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz_stream", "Type" : "Fifo", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "nnz_stream_blk_n", "Type" : "RtlSignal"}]}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_89_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "7", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.read_nnz_packed_U0.grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114.flow_control_loop_pipe_sequential_init_U", "Parent" : "6"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0", "Parent" : "0", "Child" : ["9", "43"],
		"CDFG" : "distribute_to_pe",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"StartSource" : "2",
		"StartFifo" : "start_for_distribute_to_pe_U0_U",
		"Port" : [
			{"Name" : "nnz", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["5"], "DependentChan" : "175", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "nnz_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "col_info_stream", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["2"], "DependentChan" : "173", "DependentChanDepth" : "64", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "col_info_stream", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "nnz_stream", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["5"], "DependentChan" : "174", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "nnz_stream", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "pe_streams_0", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["45"], "DependentChan" : "176", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_0", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_0", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["52"], "DependentChan" : "177", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_1", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_1", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["59"], "DependentChan" : "178", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_2", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_2", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["66"], "DependentChan" : "179", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_3", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_3", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_4", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["73"], "DependentChan" : "180", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_4", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_4", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_5", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["80"], "DependentChan" : "181", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_5", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_5", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_6", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["87"], "DependentChan" : "182", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_6", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_6", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_7", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["94"], "DependentChan" : "183", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_7", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_7", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_8", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["101"], "DependentChan" : "184", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_8", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_8", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_9", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["108"], "DependentChan" : "185", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_9", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_9", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_10", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["115"], "DependentChan" : "186", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_10", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_10", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_11", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["122"], "DependentChan" : "187", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_11", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_11", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_12", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["129"], "DependentChan" : "188", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_12", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_12", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_13", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["136"], "DependentChan" : "189", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_13", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_13", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_14", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["143"], "DependentChan" : "190", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_14", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_14", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_15", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["150"], "DependentChan" : "191", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "9", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_15", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "43", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_15", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Parent" : "8", "Child" : ["10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42"],
		"CDFG" : "distribute_to_pe_Pipeline_VITIS_LOOP_172_1",
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
			{"Name" : "nnz_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "col_info_stream", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "col_info_stream_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "nnz_stream", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "nnz_stream_blk_n", "Type" : "RtlSignal"}]},
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
			{"Name" : "VITIS_LOOP_172_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter3", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter3", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "10", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U48", "Parent" : "9"},
	{"ID" : "11", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U49", "Parent" : "9"},
	{"ID" : "12", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U50", "Parent" : "9"},
	{"ID" : "13", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U51", "Parent" : "9"},
	{"ID" : "14", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U52", "Parent" : "9"},
	{"ID" : "15", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U53", "Parent" : "9"},
	{"ID" : "16", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U54", "Parent" : "9"},
	{"ID" : "17", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U55", "Parent" : "9"},
	{"ID" : "18", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U56", "Parent" : "9"},
	{"ID" : "19", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U57", "Parent" : "9"},
	{"ID" : "20", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U58", "Parent" : "9"},
	{"ID" : "21", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U59", "Parent" : "9"},
	{"ID" : "22", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U60", "Parent" : "9"},
	{"ID" : "23", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U61", "Parent" : "9"},
	{"ID" : "24", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U62", "Parent" : "9"},
	{"ID" : "25", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U63", "Parent" : "9"},
	{"ID" : "26", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U64", "Parent" : "9"},
	{"ID" : "27", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U65", "Parent" : "9"},
	{"ID" : "28", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U66", "Parent" : "9"},
	{"ID" : "29", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U67", "Parent" : "9"},
	{"ID" : "30", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U68", "Parent" : "9"},
	{"ID" : "31", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U69", "Parent" : "9"},
	{"ID" : "32", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U70", "Parent" : "9"},
	{"ID" : "33", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U71", "Parent" : "9"},
	{"ID" : "34", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U72", "Parent" : "9"},
	{"ID" : "35", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U73", "Parent" : "9"},
	{"ID" : "36", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U74", "Parent" : "9"},
	{"ID" : "37", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U75", "Parent" : "9"},
	{"ID" : "38", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U76", "Parent" : "9"},
	{"ID" : "39", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U77", "Parent" : "9"},
	{"ID" : "40", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U78", "Parent" : "9"},
	{"ID" : "41", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U79", "Parent" : "9"},
	{"ID" : "42", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.flow_control_loop_pipe_sequential_init_U", "Parent" : "9"},
	{"ID" : "43", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Parent" : "8", "Child" : ["44"],
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
	{"ID" : "44", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113.flow_control_loop_pipe_sequential_init_U", "Parent" : "43"},
	{"ID" : "45", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0", "Parent" : "0", "Child" : ["46", "48"],
		"CDFG" : "compute_pe",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "172", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_0", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "176", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "48", "SubInstance" : "grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_0", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "46", "SubInstance" : "grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "48", "SubInstance" : "grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "46", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "45", "Child" : ["47"],
		"CDFG" : "compute_pe_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_16", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "47", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "46"},
	{"ID" : "48", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "45", "Child" : ["49", "50", "51"],
		"CDFG" : "compute_pe_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_0", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_0_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_16", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "49", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U137", "Parent" : "48"},
	{"ID" : "50", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U138", "Parent" : "48"},
	{"ID" : "51", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "48"},
	{"ID" : "52", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0", "Parent" : "0", "Child" : ["53", "55"],
		"CDFG" : "compute_pe_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "171", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_1", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "177", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "55", "SubInstance" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_1", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "53", "SubInstance" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "55", "SubInstance" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "53", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "52", "Child" : ["54"],
		"CDFG" : "compute_pe_1_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_15", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "54", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "53"},
	{"ID" : "55", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "52", "Child" : ["56", "57", "58"],
		"CDFG" : "compute_pe_1_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_1", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_15", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "56", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U149", "Parent" : "55"},
	{"ID" : "57", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U150", "Parent" : "55"},
	{"ID" : "58", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "55"},
	{"ID" : "59", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0", "Parent" : "0", "Child" : ["60", "62"],
		"CDFG" : "compute_pe_2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "170", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_2", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "178", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_2", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "60", "SubInstance" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "62", "SubInstance" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "60", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "59", "Child" : ["61"],
		"CDFG" : "compute_pe_2_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_8", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "61", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "60"},
	{"ID" : "62", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "59", "Child" : ["63", "64", "65"],
		"CDFG" : "compute_pe_2_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_2", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_8", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "63", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U159", "Parent" : "62"},
	{"ID" : "64", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U160", "Parent" : "62"},
	{"ID" : "65", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "62"},
	{"ID" : "66", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0", "Parent" : "0", "Child" : ["67", "69"],
		"CDFG" : "compute_pe_3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "169", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_3", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "179", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "69", "SubInstance" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_3", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "67", "SubInstance" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "69", "SubInstance" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "67", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "66", "Child" : ["68"],
		"CDFG" : "compute_pe_3_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_7", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "68", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "67"},
	{"ID" : "69", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "66", "Child" : ["70", "71", "72"],
		"CDFG" : "compute_pe_3_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_3", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_7", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "70", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U169", "Parent" : "69"},
	{"ID" : "71", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U170", "Parent" : "69"},
	{"ID" : "72", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "69"},
	{"ID" : "73", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0", "Parent" : "0", "Child" : ["74", "76"],
		"CDFG" : "compute_pe_4",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "168", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_4", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "180", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "76", "SubInstance" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_4", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "74", "SubInstance" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "76", "SubInstance" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "74", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "73", "Child" : ["75"],
		"CDFG" : "compute_pe_4_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_6", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "75", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "74"},
	{"ID" : "76", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "73", "Child" : ["77", "78", "79"],
		"CDFG" : "compute_pe_4_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_4", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_4_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_6", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "77", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U179", "Parent" : "76"},
	{"ID" : "78", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U180", "Parent" : "76"},
	{"ID" : "79", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "76"},
	{"ID" : "80", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0", "Parent" : "0", "Child" : ["81", "83"],
		"CDFG" : "compute_pe_5",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "167", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_5", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "181", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "83", "SubInstance" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_5", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "81", "SubInstance" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "83", "SubInstance" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "81", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "80", "Child" : ["82"],
		"CDFG" : "compute_pe_5_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_5", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "82", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "81"},
	{"ID" : "83", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "80", "Child" : ["84", "85", "86"],
		"CDFG" : "compute_pe_5_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_5", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_5_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_5", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "84", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U189", "Parent" : "83"},
	{"ID" : "85", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U190", "Parent" : "83"},
	{"ID" : "86", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "83"},
	{"ID" : "87", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0", "Parent" : "0", "Child" : ["88", "90"],
		"CDFG" : "compute_pe_6",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "166", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_6", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "182", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "90", "SubInstance" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_6", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "88", "SubInstance" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "90", "SubInstance" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "88", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "87", "Child" : ["89"],
		"CDFG" : "compute_pe_6_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_4", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "89", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "88"},
	{"ID" : "90", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "87", "Child" : ["91", "92", "93"],
		"CDFG" : "compute_pe_6_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_6", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_6_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_4", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "91", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U199", "Parent" : "90"},
	{"ID" : "92", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U200", "Parent" : "90"},
	{"ID" : "93", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "90"},
	{"ID" : "94", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0", "Parent" : "0", "Child" : ["95", "97"],
		"CDFG" : "compute_pe_7",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "165", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_7", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "183", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "97", "SubInstance" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_7", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "95", "SubInstance" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "97", "SubInstance" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "95", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "94", "Child" : ["96"],
		"CDFG" : "compute_pe_7_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_3", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "96", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "95"},
	{"ID" : "97", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "94", "Child" : ["98", "99", "100"],
		"CDFG" : "compute_pe_7_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_7", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_7_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_3", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "98", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U209", "Parent" : "97"},
	{"ID" : "99", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U210", "Parent" : "97"},
	{"ID" : "100", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "97"},
	{"ID" : "101", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0", "Parent" : "0", "Child" : ["102", "104"],
		"CDFG" : "compute_pe_8",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "164", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_8", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "184", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "104", "SubInstance" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_8", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "102", "SubInstance" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "104", "SubInstance" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "102", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "101", "Child" : ["103"],
		"CDFG" : "compute_pe_8_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_2", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "103", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "102"},
	{"ID" : "104", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "101", "Child" : ["105", "106", "107"],
		"CDFG" : "compute_pe_8_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_8", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_8_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_2", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "105", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U219", "Parent" : "104"},
	{"ID" : "106", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U220", "Parent" : "104"},
	{"ID" : "107", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "104"},
	{"ID" : "108", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0", "Parent" : "0", "Child" : ["109", "111"],
		"CDFG" : "compute_pe_9",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "163", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_9", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "185", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "111", "SubInstance" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_9", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "109", "SubInstance" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "111", "SubInstance" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "109", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "108", "Child" : ["110"],
		"CDFG" : "compute_pe_9_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "110", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "109"},
	{"ID" : "111", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "108", "Child" : ["112", "113", "114"],
		"CDFG" : "compute_pe_9_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_9", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_9_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "112", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U229", "Parent" : "111"},
	{"ID" : "113", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U230", "Parent" : "111"},
	{"ID" : "114", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "111"},
	{"ID" : "115", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0", "Parent" : "0", "Child" : ["116", "118"],
		"CDFG" : "compute_pe_10",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "162", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_10", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "186", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "118", "SubInstance" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_10", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "116", "SubInstance" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "118", "SubInstance" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "116", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "115", "Child" : ["117"],
		"CDFG" : "compute_pe_10_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_14", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "117", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "116"},
	{"ID" : "118", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "115", "Child" : ["119", "120", "121"],
		"CDFG" : "compute_pe_10_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_10", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_10_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_14", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "119", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U239", "Parent" : "118"},
	{"ID" : "120", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U240", "Parent" : "118"},
	{"ID" : "121", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "118"},
	{"ID" : "122", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0", "Parent" : "0", "Child" : ["123", "125"],
		"CDFG" : "compute_pe_11",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "161", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_11", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "187", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "125", "SubInstance" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_11", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "123", "SubInstance" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "125", "SubInstance" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "123", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "122", "Child" : ["124"],
		"CDFG" : "compute_pe_11_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_13", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "124", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "123"},
	{"ID" : "125", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "122", "Child" : ["126", "127", "128"],
		"CDFG" : "compute_pe_11_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_11", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_11_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_13", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "126", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U249", "Parent" : "125"},
	{"ID" : "127", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U250", "Parent" : "125"},
	{"ID" : "128", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "125"},
	{"ID" : "129", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0", "Parent" : "0", "Child" : ["130", "132"],
		"CDFG" : "compute_pe_12",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "160", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_12", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "188", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "132", "SubInstance" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_12", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "130", "SubInstance" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "132", "SubInstance" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "130", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "129", "Child" : ["131"],
		"CDFG" : "compute_pe_12_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_12", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "131", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "130"},
	{"ID" : "132", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "129", "Child" : ["133", "134", "135"],
		"CDFG" : "compute_pe_12_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_12", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_12_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_12", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "133", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U259", "Parent" : "132"},
	{"ID" : "134", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U260", "Parent" : "132"},
	{"ID" : "135", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "132"},
	{"ID" : "136", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0", "Parent" : "0", "Child" : ["137", "139"],
		"CDFG" : "compute_pe_13",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "159", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_13", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "189", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "139", "SubInstance" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_13", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "137", "SubInstance" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "139", "SubInstance" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "137", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "136", "Child" : ["138"],
		"CDFG" : "compute_pe_13_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_11", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "138", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "137"},
	{"ID" : "139", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "136", "Child" : ["140", "141", "142"],
		"CDFG" : "compute_pe_13_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_13", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_13_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_11", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "140", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U269", "Parent" : "139"},
	{"ID" : "141", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U270", "Parent" : "139"},
	{"ID" : "142", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "139"},
	{"ID" : "143", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0", "Parent" : "0", "Child" : ["144", "146"],
		"CDFG" : "compute_pe_14",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "158", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_14", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "190", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "146", "SubInstance" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_14", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "144", "SubInstance" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "146", "SubInstance" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "144", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "143", "Child" : ["145"],
		"CDFG" : "compute_pe_14_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_10", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "145", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "144"},
	{"ID" : "146", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "143", "Child" : ["147", "148", "149"],
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
	{"ID" : "147", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U279", "Parent" : "146"},
	{"ID" : "148", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U280", "Parent" : "146"},
	{"ID" : "149", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "146"},
	{"ID" : "150", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0", "Parent" : "0", "Child" : ["151", "153"],
		"CDFG" : "compute_pe_15",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["1"], "DependentChan" : "157", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_15", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["8"], "DependentChan" : "191", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "153", "SubInstance" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_15", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "151", "SubInstance" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "153", "SubInstance" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "151", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "150", "Child" : ["152"],
		"CDFG" : "compute_pe_15_Pipeline_VITIS_LOOP_245_1",
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
			{"Name" : "num_rows_9", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_245_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "152", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "151"},
	{"ID" : "153", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "150", "Child" : ["154", "155", "156"],
		"CDFG" : "compute_pe_15_Pipeline_VITIS_LOOP_251_2",
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
			{"Name" : "pe_streams_15", "Type" : "Fifo", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "pe_streams_15_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_9", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_251_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "6", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage3", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage3_subdone", "QuitState" : "ap_ST_fsm_pp0_stage3", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage3_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "154", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U289", "Parent" : "153"},
	{"ID" : "155", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U290", "Parent" : "153"},
	{"ID" : "156", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "153"},
	{"ID" : "157", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c_U", "Parent" : "0"},
	{"ID" : "158", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c2_U", "Parent" : "0"},
	{"ID" : "159", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c3_U", "Parent" : "0"},
	{"ID" : "160", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c4_U", "Parent" : "0"},
	{"ID" : "161", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c5_U", "Parent" : "0"},
	{"ID" : "162", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c6_U", "Parent" : "0"},
	{"ID" : "163", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c7_U", "Parent" : "0"},
	{"ID" : "164", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c8_U", "Parent" : "0"},
	{"ID" : "165", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c9_U", "Parent" : "0"},
	{"ID" : "166", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c10_U", "Parent" : "0"},
	{"ID" : "167", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c11_U", "Parent" : "0"},
	{"ID" : "168", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c12_U", "Parent" : "0"},
	{"ID" : "169", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c13_U", "Parent" : "0"},
	{"ID" : "170", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c14_U", "Parent" : "0"},
	{"ID" : "171", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c15_U", "Parent" : "0"},
	{"ID" : "172", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.num_rows_c16_U", "Parent" : "0"},
	{"ID" : "173", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.col_info_stream_U", "Parent" : "0"},
	{"ID" : "174", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.nnz_stream_U", "Parent" : "0"},
	{"ID" : "175", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.nnz_c_U", "Parent" : "0"},
	{"ID" : "176", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_0_U", "Parent" : "0"},
	{"ID" : "177", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_1_U", "Parent" : "0"},
	{"ID" : "178", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_2_U", "Parent" : "0"},
	{"ID" : "179", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_3_U", "Parent" : "0"},
	{"ID" : "180", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_4_U", "Parent" : "0"},
	{"ID" : "181", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_5_U", "Parent" : "0"},
	{"ID" : "182", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_6_U", "Parent" : "0"},
	{"ID" : "183", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_7_U", "Parent" : "0"},
	{"ID" : "184", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_8_U", "Parent" : "0"},
	{"ID" : "185", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_9_U", "Parent" : "0"},
	{"ID" : "186", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_10_U", "Parent" : "0"},
	{"ID" : "187", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_11_U", "Parent" : "0"},
	{"ID" : "188", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_12_U", "Parent" : "0"},
	{"ID" : "189", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_13_U", "Parent" : "0"},
	{"ID" : "190", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_14_U", "Parent" : "0"},
	{"ID" : "191", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.pe_streams_15_U", "Parent" : "0"},
	{"ID" : "192", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_distribute_to_pe_U0_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	spmv_csc_dataflow {
		num_rows {Type I LastRead 3 FirstWrite -1}
		num_cols {Type I LastRead 0 FirstWrite -1}
		nnz {Type I LastRead 0 FirstWrite -1}
		gmem0 {Type I LastRead 1 FirstWrite -1}
		A_row_idx {Type I LastRead 0 FirstWrite -1}
		gmem1 {Type I LastRead 19 FirstWrite -1}
		A_col_ptr {Type I LastRead 0 FirstWrite -1}
		gmem2 {Type I LastRead 1 FirstWrite -1}
		A_values {Type I LastRead 0 FirstWrite -1}
		gmem3 {Type I LastRead 8 FirstWrite -1}
		x {Type I LastRead 0 FirstWrite -1}
		y_partial_0 {Type IO LastRead 4 FirstWrite 0}
		y_partial_1 {Type IO LastRead 4 FirstWrite 0}
		y_partial_2 {Type IO LastRead 4 FirstWrite 0}
		y_partial_3 {Type IO LastRead 4 FirstWrite 0}
		y_partial_4 {Type IO LastRead 4 FirstWrite 0}
		y_partial_5 {Type IO LastRead 4 FirstWrite 0}
		y_partial_6 {Type IO LastRead 4 FirstWrite 0}
		y_partial_7 {Type IO LastRead 4 FirstWrite 0}
		y_partial_8 {Type IO LastRead 4 FirstWrite 0}
		y_partial_9 {Type IO LastRead 4 FirstWrite 0}
		y_partial_10 {Type IO LastRead 4 FirstWrite 0}
		y_partial_11 {Type IO LastRead 4 FirstWrite 0}
		y_partial_12 {Type IO LastRead 4 FirstWrite 0}
		y_partial_13 {Type IO LastRead 4 FirstWrite 0}
		y_partial_14 {Type IO LastRead 4 FirstWrite 0}
		y_partial_15 {Type IO LastRead 4 FirstWrite 0}}
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
		num_rows_c16 {Type O LastRead -1 FirstWrite 0}}
	read_col_info {
		num_cols {Type I LastRead 0 FirstWrite -1}
		gmem1 {Type I LastRead 19 FirstWrite -1}
		A_col_ptr {Type I LastRead 0 FirstWrite -1}
		gmem3 {Type I LastRead 8 FirstWrite -1}
		x_in {Type I LastRead 0 FirstWrite -1}
		col_info_stream {Type O LastRead -1 FirstWrite 3}}
	read_col_info_Pipeline_VITIS_LOOP_46_1 {
		x_element {Type I LastRead 0 FirstWrite -1}
		prev {Type I LastRead 0 FirstWrite -1}
		sub {Type I LastRead 0 FirstWrite -1}
		gmem3 {Type I LastRead 2 FirstWrite -1}
		sext_ln46_1 {Type I LastRead 0 FirstWrite -1}
		gmem1 {Type I LastRead 1 FirstWrite -1}
		sext_ln46 {Type I LastRead 0 FirstWrite -1}
		col_info_stream {Type O LastRead -1 FirstWrite 3}
		p_out {Type O LastRead -1 FirstWrite 2}
		prev_1_out {Type O LastRead -1 FirstWrite 2}}
	read_nnz_packed {
		nnz {Type I LastRead 0 FirstWrite -1}
		gmem0 {Type I LastRead 1 FirstWrite -1}
		row_in {Type I LastRead 1 FirstWrite -1}
		gmem2 {Type I LastRead 1 FirstWrite -1}
		val_in {Type I LastRead 1 FirstWrite -1}
		nnz_stream {Type O LastRead -1 FirstWrite 2}
		nnz_c {Type O LastRead -1 FirstWrite 0}}
	read_nnz_packed_Pipeline_VITIS_LOOP_89_1 {
		words {Type I LastRead 0 FirstWrite -1}
		gmem0 {Type I LastRead 1 FirstWrite -1}
		sext_ln89 {Type I LastRead 0 FirstWrite -1}
		gmem2 {Type I LastRead 1 FirstWrite -1}
		sext_ln89_2 {Type I LastRead 0 FirstWrite -1}
		nnz {Type I LastRead 0 FirstWrite -1}
		nnz_stream {Type O LastRead -1 FirstWrite 2}}
	distribute_to_pe {
		nnz {Type I LastRead 0 FirstWrite -1}
		col_info_stream {Type I LastRead 1 FirstWrite -1}
		nnz_stream {Type I LastRead 1 FirstWrite -1}
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
		pe_streams_15 {Type O LastRead -1 FirstWrite 1}}
	distribute_to_pe_Pipeline_VITIS_LOOP_172_1 {
		nnz_1 {Type I LastRead 0 FirstWrite -1}
		col_info_stream {Type I LastRead 1 FirstWrite -1}
		nnz_stream {Type I LastRead 1 FirstWrite -1}
		pe_streams_0 {Type O LastRead -1 FirstWrite 3}
		pe_streams_1 {Type O LastRead -1 FirstWrite 3}
		pe_streams_2 {Type O LastRead -1 FirstWrite 3}
		pe_streams_3 {Type O LastRead -1 FirstWrite 3}
		pe_streams_4 {Type O LastRead -1 FirstWrite 3}
		pe_streams_5 {Type O LastRead -1 FirstWrite 3}
		pe_streams_6 {Type O LastRead -1 FirstWrite 3}
		pe_streams_7 {Type O LastRead -1 FirstWrite 3}
		pe_streams_8 {Type O LastRead -1 FirstWrite 3}
		pe_streams_9 {Type O LastRead -1 FirstWrite 3}
		pe_streams_10 {Type O LastRead -1 FirstWrite 3}
		pe_streams_11 {Type O LastRead -1 FirstWrite 3}
		pe_streams_12 {Type O LastRead -1 FirstWrite 3}
		pe_streams_13 {Type O LastRead -1 FirstWrite 3}
		pe_streams_14 {Type O LastRead -1 FirstWrite 3}
		pe_streams_15 {Type O LastRead -1 FirstWrite 3}}
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
		pe_streams_15 {Type O LastRead -1 FirstWrite 1}}
	compute_pe {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_0 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_Pipeline_VITIS_LOOP_245_1 {
		num_rows_16 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_0 {Type I LastRead 0 FirstWrite -1}
		num_rows_16 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_1 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_1 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_1_Pipeline_VITIS_LOOP_245_1 {
		num_rows_15 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_1_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_1 {Type I LastRead 0 FirstWrite -1}
		num_rows_15 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_2 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_2 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_2_Pipeline_VITIS_LOOP_245_1 {
		num_rows_8 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_2_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_2 {Type I LastRead 0 FirstWrite -1}
		num_rows_8 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_3 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_3 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_3_Pipeline_VITIS_LOOP_245_1 {
		num_rows_7 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_3_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_3 {Type I LastRead 0 FirstWrite -1}
		num_rows_7 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_4 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_4 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_4_Pipeline_VITIS_LOOP_245_1 {
		num_rows_6 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_4_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_4 {Type I LastRead 0 FirstWrite -1}
		num_rows_6 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_5 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_5 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_5_Pipeline_VITIS_LOOP_245_1 {
		num_rows_5 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_5_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_5 {Type I LastRead 0 FirstWrite -1}
		num_rows_5 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_6 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_6 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_6_Pipeline_VITIS_LOOP_245_1 {
		num_rows_4 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_6_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_6 {Type I LastRead 0 FirstWrite -1}
		num_rows_4 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_7 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_7 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_7_Pipeline_VITIS_LOOP_245_1 {
		num_rows_3 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_7_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_7 {Type I LastRead 0 FirstWrite -1}
		num_rows_3 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_8 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_8 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_8_Pipeline_VITIS_LOOP_245_1 {
		num_rows_2 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_8_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_8 {Type I LastRead 0 FirstWrite -1}
		num_rows_2 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_9 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_9 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_9_Pipeline_VITIS_LOOP_245_1 {
		num_rows_1 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_9_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_9 {Type I LastRead 0 FirstWrite -1}
		num_rows_1 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_10 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_10 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_10_Pipeline_VITIS_LOOP_245_1 {
		num_rows_14 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_10_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_10 {Type I LastRead 0 FirstWrite -1}
		num_rows_14 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_11 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_11 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_11_Pipeline_VITIS_LOOP_245_1 {
		num_rows_13 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_11_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_11 {Type I LastRead 0 FirstWrite -1}
		num_rows_13 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_12 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_12 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_12_Pipeline_VITIS_LOOP_245_1 {
		num_rows_12 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_12_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_12 {Type I LastRead 0 FirstWrite -1}
		num_rows_12 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_13 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_13 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_13_Pipeline_VITIS_LOOP_245_1 {
		num_rows_11 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_13_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_13 {Type I LastRead 0 FirstWrite -1}
		num_rows_11 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_14 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_14 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_14_Pipeline_VITIS_LOOP_245_1 {
		num_rows_10 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_14_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_14 {Type I LastRead 0 FirstWrite -1}
		num_rows_10 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}
	compute_pe_15 {
		num_rows {Type I LastRead 0 FirstWrite -1}
		pe_streams_15 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 0}}
	compute_pe_15_Pipeline_VITIS_LOOP_245_1 {
		num_rows_9 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type O LastRead -1 FirstWrite 0}}
	compute_pe_15_Pipeline_VITIS_LOOP_251_2 {
		pe_streams_15 {Type I LastRead 0 FirstWrite -1}
		num_rows_9 {Type I LastRead 0 FirstWrite -1}
		y_partial {Type IO LastRead 4 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	num_rows { ap_none {  { num_rows in_data 0 32 }  { num_rows_ap_vld in_vld 0 1 } } }
	num_cols { ap_none {  { num_cols in_data 0 32 }  { num_cols_ap_vld in_vld 0 1 } } }
	nnz { ap_none {  { nnz in_data 0 32 }  { nnz_ap_vld in_vld 0 1 } } }
	 { m_axi {  { m_axi_gmem0_0_AWVALID VALID 1 1 }  { m_axi_gmem0_0_AWREADY READY 0 1 }  { m_axi_gmem0_0_AWADDR ADDR 1 64 }  { m_axi_gmem0_0_AWID ID 1 1 }  { m_axi_gmem0_0_AWLEN SIZE 1 32 }  { m_axi_gmem0_0_AWSIZE BURST 1 3 }  { m_axi_gmem0_0_AWBURST LOCK 1 2 }  { m_axi_gmem0_0_AWLOCK CACHE 1 2 }  { m_axi_gmem0_0_AWCACHE PROT 1 4 }  { m_axi_gmem0_0_AWPROT QOS 1 3 }  { m_axi_gmem0_0_AWQOS REGION 1 4 }  { m_axi_gmem0_0_AWREGION USER 1 4 }  { m_axi_gmem0_0_AWUSER DATA 1 1 }  { m_axi_gmem0_0_WVALID VALID 1 1 }  { m_axi_gmem0_0_WREADY READY 0 1 }  { m_axi_gmem0_0_WDATA FIFONUM 1 512 }  { m_axi_gmem0_0_WSTRB STRB 1 64 }  { m_axi_gmem0_0_WLAST LAST 1 1 }  { m_axi_gmem0_0_WID ID 1 1 }  { m_axi_gmem0_0_WUSER DATA 1 1 }  { m_axi_gmem0_0_ARVALID VALID 1 1 }  { m_axi_gmem0_0_ARREADY READY 0 1 }  { m_axi_gmem0_0_ARADDR ADDR 1 64 }  { m_axi_gmem0_0_ARID ID 1 1 }  { m_axi_gmem0_0_ARLEN SIZE 1 32 }  { m_axi_gmem0_0_ARSIZE BURST 1 3 }  { m_axi_gmem0_0_ARBURST LOCK 1 2 }  { m_axi_gmem0_0_ARLOCK CACHE 1 2 }  { m_axi_gmem0_0_ARCACHE PROT 1 4 }  { m_axi_gmem0_0_ARPROT QOS 1 3 }  { m_axi_gmem0_0_ARQOS REGION 1 4 }  { m_axi_gmem0_0_ARREGION USER 1 4 }  { m_axi_gmem0_0_ARUSER DATA 1 1 }  { m_axi_gmem0_0_RVALID VALID 0 1 }  { m_axi_gmem0_0_RREADY READY 1 1 }  { m_axi_gmem0_0_RDATA FIFONUM 0 512 }  { m_axi_gmem0_0_RLAST LAST 0 1 }  { m_axi_gmem0_0_RID ID 0 1 }  { m_axi_gmem0_0_RFIFONUM LEN 0 9 }  { m_axi_gmem0_0_RUSER DATA 0 1 }  { m_axi_gmem0_0_RRESP RESP 0 2 }  { m_axi_gmem0_0_BVALID VALID 0 1 }  { m_axi_gmem0_0_BREADY READY 1 1 }  { m_axi_gmem0_0_BRESP RESP 0 2 }  { m_axi_gmem0_0_BID ID 0 1 }  { m_axi_gmem0_0_BUSER DATA 0 1 } } }
	A_row_idx { ap_none {  { A_row_idx in_data 0 64 }  { A_row_idx_ap_vld in_vld 0 1 } } }
	 { m_axi {  { m_axi_gmem1_0_AWVALID VALID 1 1 }  { m_axi_gmem1_0_AWREADY READY 0 1 }  { m_axi_gmem1_0_AWADDR ADDR 1 64 }  { m_axi_gmem1_0_AWID ID 1 1 }  { m_axi_gmem1_0_AWLEN SIZE 1 32 }  { m_axi_gmem1_0_AWSIZE BURST 1 3 }  { m_axi_gmem1_0_AWBURST LOCK 1 2 }  { m_axi_gmem1_0_AWLOCK CACHE 1 2 }  { m_axi_gmem1_0_AWCACHE PROT 1 4 }  { m_axi_gmem1_0_AWPROT QOS 1 3 }  { m_axi_gmem1_0_AWQOS REGION 1 4 }  { m_axi_gmem1_0_AWREGION USER 1 4 }  { m_axi_gmem1_0_AWUSER DATA 1 1 }  { m_axi_gmem1_0_WVALID VALID 1 1 }  { m_axi_gmem1_0_WREADY READY 0 1 }  { m_axi_gmem1_0_WDATA FIFONUM 1 32 }  { m_axi_gmem1_0_WSTRB STRB 1 4 }  { m_axi_gmem1_0_WLAST LAST 1 1 }  { m_axi_gmem1_0_WID ID 1 1 }  { m_axi_gmem1_0_WUSER DATA 1 1 }  { m_axi_gmem1_0_ARVALID VALID 1 1 }  { m_axi_gmem1_0_ARREADY READY 0 1 }  { m_axi_gmem1_0_ARADDR ADDR 1 64 }  { m_axi_gmem1_0_ARID ID 1 1 }  { m_axi_gmem1_0_ARLEN SIZE 1 32 }  { m_axi_gmem1_0_ARSIZE BURST 1 3 }  { m_axi_gmem1_0_ARBURST LOCK 1 2 }  { m_axi_gmem1_0_ARLOCK CACHE 1 2 }  { m_axi_gmem1_0_ARCACHE PROT 1 4 }  { m_axi_gmem1_0_ARPROT QOS 1 3 }  { m_axi_gmem1_0_ARQOS REGION 1 4 }  { m_axi_gmem1_0_ARREGION USER 1 4 }  { m_axi_gmem1_0_ARUSER DATA 1 1 }  { m_axi_gmem1_0_RVALID VALID 0 1 }  { m_axi_gmem1_0_RREADY READY 1 1 }  { m_axi_gmem1_0_RDATA FIFONUM 0 32 }  { m_axi_gmem1_0_RLAST LAST 0 1 }  { m_axi_gmem1_0_RID ID 0 1 }  { m_axi_gmem1_0_RFIFONUM LEN 0 9 }  { m_axi_gmem1_0_RUSER DATA 0 1 }  { m_axi_gmem1_0_RRESP RESP 0 2 }  { m_axi_gmem1_0_BVALID VALID 0 1 }  { m_axi_gmem1_0_BREADY READY 1 1 }  { m_axi_gmem1_0_BRESP RESP 0 2 }  { m_axi_gmem1_0_BID ID 0 1 }  { m_axi_gmem1_0_BUSER DATA 0 1 } } }
	A_col_ptr { ap_none {  { A_col_ptr in_data 0 64 }  { A_col_ptr_ap_vld in_vld 0 1 } } }
	 { m_axi {  { m_axi_gmem2_0_AWVALID VALID 1 1 }  { m_axi_gmem2_0_AWREADY READY 0 1 }  { m_axi_gmem2_0_AWADDR ADDR 1 64 }  { m_axi_gmem2_0_AWID ID 1 1 }  { m_axi_gmem2_0_AWLEN SIZE 1 32 }  { m_axi_gmem2_0_AWSIZE BURST 1 3 }  { m_axi_gmem2_0_AWBURST LOCK 1 2 }  { m_axi_gmem2_0_AWLOCK CACHE 1 2 }  { m_axi_gmem2_0_AWCACHE PROT 1 4 }  { m_axi_gmem2_0_AWPROT QOS 1 3 }  { m_axi_gmem2_0_AWQOS REGION 1 4 }  { m_axi_gmem2_0_AWREGION USER 1 4 }  { m_axi_gmem2_0_AWUSER DATA 1 1 }  { m_axi_gmem2_0_WVALID VALID 1 1 }  { m_axi_gmem2_0_WREADY READY 0 1 }  { m_axi_gmem2_0_WDATA FIFONUM 1 512 }  { m_axi_gmem2_0_WSTRB STRB 1 64 }  { m_axi_gmem2_0_WLAST LAST 1 1 }  { m_axi_gmem2_0_WID ID 1 1 }  { m_axi_gmem2_0_WUSER DATA 1 1 }  { m_axi_gmem2_0_ARVALID VALID 1 1 }  { m_axi_gmem2_0_ARREADY READY 0 1 }  { m_axi_gmem2_0_ARADDR ADDR 1 64 }  { m_axi_gmem2_0_ARID ID 1 1 }  { m_axi_gmem2_0_ARLEN SIZE 1 32 }  { m_axi_gmem2_0_ARSIZE BURST 1 3 }  { m_axi_gmem2_0_ARBURST LOCK 1 2 }  { m_axi_gmem2_0_ARLOCK CACHE 1 2 }  { m_axi_gmem2_0_ARCACHE PROT 1 4 }  { m_axi_gmem2_0_ARPROT QOS 1 3 }  { m_axi_gmem2_0_ARQOS REGION 1 4 }  { m_axi_gmem2_0_ARREGION USER 1 4 }  { m_axi_gmem2_0_ARUSER DATA 1 1 }  { m_axi_gmem2_0_RVALID VALID 0 1 }  { m_axi_gmem2_0_RREADY READY 1 1 }  { m_axi_gmem2_0_RDATA FIFONUM 0 512 }  { m_axi_gmem2_0_RLAST LAST 0 1 }  { m_axi_gmem2_0_RID ID 0 1 }  { m_axi_gmem2_0_RFIFONUM LEN 0 9 }  { m_axi_gmem2_0_RUSER DATA 0 1 }  { m_axi_gmem2_0_RRESP RESP 0 2 }  { m_axi_gmem2_0_BVALID VALID 0 1 }  { m_axi_gmem2_0_BREADY READY 1 1 }  { m_axi_gmem2_0_BRESP RESP 0 2 }  { m_axi_gmem2_0_BID ID 0 1 }  { m_axi_gmem2_0_BUSER DATA 0 1 } } }
	A_values { ap_none {  { A_values in_data 0 64 }  { A_values_ap_vld in_vld 0 1 } } }
	 { m_axi {  { m_axi_gmem3_0_AWVALID VALID 1 1 }  { m_axi_gmem3_0_AWREADY READY 0 1 }  { m_axi_gmem3_0_AWADDR ADDR 1 64 }  { m_axi_gmem3_0_AWID ID 1 1 }  { m_axi_gmem3_0_AWLEN SIZE 1 32 }  { m_axi_gmem3_0_AWSIZE BURST 1 3 }  { m_axi_gmem3_0_AWBURST LOCK 1 2 }  { m_axi_gmem3_0_AWLOCK CACHE 1 2 }  { m_axi_gmem3_0_AWCACHE PROT 1 4 }  { m_axi_gmem3_0_AWPROT QOS 1 3 }  { m_axi_gmem3_0_AWQOS REGION 1 4 }  { m_axi_gmem3_0_AWREGION USER 1 4 }  { m_axi_gmem3_0_AWUSER DATA 1 1 }  { m_axi_gmem3_0_WVALID VALID 1 1 }  { m_axi_gmem3_0_WREADY READY 0 1 }  { m_axi_gmem3_0_WDATA FIFONUM 1 32 }  { m_axi_gmem3_0_WSTRB STRB 1 4 }  { m_axi_gmem3_0_WLAST LAST 1 1 }  { m_axi_gmem3_0_WID ID 1 1 }  { m_axi_gmem3_0_WUSER DATA 1 1 }  { m_axi_gmem3_0_ARVALID VALID 1 1 }  { m_axi_gmem3_0_ARREADY READY 0 1 }  { m_axi_gmem3_0_ARADDR ADDR 1 64 }  { m_axi_gmem3_0_ARID ID 1 1 }  { m_axi_gmem3_0_ARLEN SIZE 1 32 }  { m_axi_gmem3_0_ARSIZE BURST 1 3 }  { m_axi_gmem3_0_ARBURST LOCK 1 2 }  { m_axi_gmem3_0_ARLOCK CACHE 1 2 }  { m_axi_gmem3_0_ARCACHE PROT 1 4 }  { m_axi_gmem3_0_ARPROT QOS 1 3 }  { m_axi_gmem3_0_ARQOS REGION 1 4 }  { m_axi_gmem3_0_ARREGION USER 1 4 }  { m_axi_gmem3_0_ARUSER DATA 1 1 }  { m_axi_gmem3_0_RVALID VALID 0 1 }  { m_axi_gmem3_0_RREADY READY 1 1 }  { m_axi_gmem3_0_RDATA FIFONUM 0 32 }  { m_axi_gmem3_0_RLAST LAST 0 1 }  { m_axi_gmem3_0_RID ID 0 1 }  { m_axi_gmem3_0_RFIFONUM LEN 0 9 }  { m_axi_gmem3_0_RUSER DATA 0 1 }  { m_axi_gmem3_0_RRESP RESP 0 2 }  { m_axi_gmem3_0_BVALID VALID 0 1 }  { m_axi_gmem3_0_BREADY READY 1 1 }  { m_axi_gmem3_0_BRESP RESP 0 2 }  { m_axi_gmem3_0_BID ID 0 1 }  { m_axi_gmem3_0_BUSER DATA 0 1 } } }
	x { ap_none {  { x in_data 0 64 }  { x_ap_vld in_vld 0 1 } } }
	y_partial_0 { ap_memory {  { y_partial_0_address0 mem_address 1 10 }  { y_partial_0_ce0 mem_ce 1 1 }  { y_partial_0_d0 mem_din 1 32 }  { y_partial_0_q0 mem_dout 0 32 }  { y_partial_0_we0 mem_we 1 1 }  { y_partial_0_address1 mem_address 1 10 }  { y_partial_0_ce1 mem_ce 1 1 }  { y_partial_0_d1 mem_din 1 32 }  { y_partial_0_q1 mem_dout 0 32 }  { y_partial_0_we1 mem_we 1 1 } } }
	y_partial_1 { ap_memory {  { y_partial_1_address0 mem_address 1 10 }  { y_partial_1_ce0 mem_ce 1 1 }  { y_partial_1_d0 mem_din 1 32 }  { y_partial_1_q0 mem_dout 0 32 }  { y_partial_1_we0 mem_we 1 1 }  { y_partial_1_address1 mem_address 1 10 }  { y_partial_1_ce1 mem_ce 1 1 }  { y_partial_1_d1 mem_din 1 32 }  { y_partial_1_q1 mem_dout 0 32 }  { y_partial_1_we1 mem_we 1 1 } } }
	y_partial_2 { ap_memory {  { y_partial_2_address0 mem_address 1 10 }  { y_partial_2_ce0 mem_ce 1 1 }  { y_partial_2_d0 mem_din 1 32 }  { y_partial_2_q0 mem_dout 0 32 }  { y_partial_2_we0 mem_we 1 1 }  { y_partial_2_address1 mem_address 1 10 }  { y_partial_2_ce1 mem_ce 1 1 }  { y_partial_2_d1 mem_din 1 32 }  { y_partial_2_q1 mem_dout 0 32 }  { y_partial_2_we1 mem_we 1 1 } } }
	y_partial_3 { ap_memory {  { y_partial_3_address0 mem_address 1 10 }  { y_partial_3_ce0 mem_ce 1 1 }  { y_partial_3_d0 mem_din 1 32 }  { y_partial_3_q0 mem_dout 0 32 }  { y_partial_3_we0 mem_we 1 1 }  { y_partial_3_address1 mem_address 1 10 }  { y_partial_3_ce1 mem_ce 1 1 }  { y_partial_3_d1 mem_din 1 32 }  { y_partial_3_q1 mem_dout 0 32 }  { y_partial_3_we1 mem_we 1 1 } } }
	y_partial_4 { ap_memory {  { y_partial_4_address0 mem_address 1 10 }  { y_partial_4_ce0 mem_ce 1 1 }  { y_partial_4_d0 mem_din 1 32 }  { y_partial_4_q0 mem_dout 0 32 }  { y_partial_4_we0 mem_we 1 1 }  { y_partial_4_address1 mem_address 1 10 }  { y_partial_4_ce1 mem_ce 1 1 }  { y_partial_4_d1 mem_din 1 32 }  { y_partial_4_q1 mem_dout 0 32 }  { y_partial_4_we1 mem_we 1 1 } } }
	y_partial_5 { ap_memory {  { y_partial_5_address0 mem_address 1 10 }  { y_partial_5_ce0 mem_ce 1 1 }  { y_partial_5_d0 mem_din 1 32 }  { y_partial_5_q0 mem_dout 0 32 }  { y_partial_5_we0 mem_we 1 1 }  { y_partial_5_address1 mem_address 1 10 }  { y_partial_5_ce1 mem_ce 1 1 }  { y_partial_5_d1 mem_din 1 32 }  { y_partial_5_q1 mem_dout 0 32 }  { y_partial_5_we1 mem_we 1 1 } } }
	y_partial_6 { ap_memory {  { y_partial_6_address0 mem_address 1 10 }  { y_partial_6_ce0 mem_ce 1 1 }  { y_partial_6_d0 mem_din 1 32 }  { y_partial_6_q0 mem_dout 0 32 }  { y_partial_6_we0 mem_we 1 1 }  { y_partial_6_address1 mem_address 1 10 }  { y_partial_6_ce1 mem_ce 1 1 }  { y_partial_6_d1 mem_din 1 32 }  { y_partial_6_q1 mem_dout 0 32 }  { y_partial_6_we1 mem_we 1 1 } } }
	y_partial_7 { ap_memory {  { y_partial_7_address0 mem_address 1 10 }  { y_partial_7_ce0 mem_ce 1 1 }  { y_partial_7_d0 mem_din 1 32 }  { y_partial_7_q0 mem_dout 0 32 }  { y_partial_7_we0 mem_we 1 1 }  { y_partial_7_address1 mem_address 1 10 }  { y_partial_7_ce1 mem_ce 1 1 }  { y_partial_7_d1 mem_din 1 32 }  { y_partial_7_q1 mem_dout 0 32 }  { y_partial_7_we1 mem_we 1 1 } } }
	y_partial_8 { ap_memory {  { y_partial_8_address0 mem_address 1 10 }  { y_partial_8_ce0 mem_ce 1 1 }  { y_partial_8_d0 mem_din 1 32 }  { y_partial_8_q0 mem_dout 0 32 }  { y_partial_8_we0 mem_we 1 1 }  { y_partial_8_address1 mem_address 1 10 }  { y_partial_8_ce1 mem_ce 1 1 }  { y_partial_8_d1 mem_din 1 32 }  { y_partial_8_q1 mem_dout 0 32 }  { y_partial_8_we1 mem_we 1 1 } } }
	y_partial_9 { ap_memory {  { y_partial_9_address0 mem_address 1 10 }  { y_partial_9_ce0 mem_ce 1 1 }  { y_partial_9_d0 mem_din 1 32 }  { y_partial_9_q0 mem_dout 0 32 }  { y_partial_9_we0 mem_we 1 1 }  { y_partial_9_address1 mem_address 1 10 }  { y_partial_9_ce1 mem_ce 1 1 }  { y_partial_9_d1 mem_din 1 32 }  { y_partial_9_q1 mem_dout 0 32 }  { y_partial_9_we1 mem_we 1 1 } } }
	y_partial_10 { ap_memory {  { y_partial_10_address0 mem_address 1 10 }  { y_partial_10_ce0 mem_ce 1 1 }  { y_partial_10_d0 mem_din 1 32 }  { y_partial_10_q0 mem_dout 0 32 }  { y_partial_10_we0 mem_we 1 1 }  { y_partial_10_address1 mem_address 1 10 }  { y_partial_10_ce1 mem_ce 1 1 }  { y_partial_10_d1 mem_din 1 32 }  { y_partial_10_q1 mem_dout 0 32 }  { y_partial_10_we1 mem_we 1 1 } } }
	y_partial_11 { ap_memory {  { y_partial_11_address0 mem_address 1 10 }  { y_partial_11_ce0 mem_ce 1 1 }  { y_partial_11_d0 mem_din 1 32 }  { y_partial_11_q0 mem_dout 0 32 }  { y_partial_11_we0 mem_we 1 1 }  { y_partial_11_address1 mem_address 1 10 }  { y_partial_11_ce1 mem_ce 1 1 }  { y_partial_11_d1 mem_din 1 32 }  { y_partial_11_q1 mem_dout 0 32 }  { y_partial_11_we1 mem_we 1 1 } } }
	y_partial_12 { ap_memory {  { y_partial_12_address0 mem_address 1 10 }  { y_partial_12_ce0 mem_ce 1 1 }  { y_partial_12_d0 mem_din 1 32 }  { y_partial_12_q0 mem_dout 0 32 }  { y_partial_12_we0 mem_we 1 1 }  { y_partial_12_address1 mem_address 1 10 }  { y_partial_12_ce1 mem_ce 1 1 }  { y_partial_12_d1 mem_din 1 32 }  { y_partial_12_q1 mem_dout 0 32 }  { y_partial_12_we1 mem_we 1 1 } } }
	y_partial_13 { ap_memory {  { y_partial_13_address0 mem_address 1 10 }  { y_partial_13_ce0 mem_ce 1 1 }  { y_partial_13_d0 mem_din 1 32 }  { y_partial_13_q0 mem_dout 0 32 }  { y_partial_13_we0 mem_we 1 1 }  { y_partial_13_address1 mem_address 1 10 }  { y_partial_13_ce1 mem_ce 1 1 }  { y_partial_13_d1 mem_din 1 32 }  { y_partial_13_q1 mem_dout 0 32 }  { y_partial_13_we1 mem_we 1 1 } } }
	y_partial_14 { ap_memory {  { y_partial_14_address0 mem_address 1 10 }  { y_partial_14_ce0 mem_ce 1 1 }  { y_partial_14_d0 mem_din 1 32 }  { y_partial_14_q0 mem_dout 0 32 }  { y_partial_14_we0 mem_we 1 1 }  { y_partial_14_address1 mem_address 1 10 }  { y_partial_14_ce1 mem_ce 1 1 }  { y_partial_14_d1 mem_din 1 32 }  { y_partial_14_q1 mem_dout 0 32 }  { y_partial_14_we1 mem_we 1 1 } } }
	y_partial_15 { ap_memory {  { y_partial_15_address0 mem_address 1 10 }  { y_partial_15_ce0 mem_ce 1 1 }  { y_partial_15_d0 mem_din 1 32 }  { y_partial_15_q0 mem_dout 0 32 }  { y_partial_15_we0 mem_we 1 1 }  { y_partial_15_address1 mem_address 1 10 }  { y_partial_15_ce1 mem_ce 1 1 }  { y_partial_15_d1 mem_din 1 32 }  { y_partial_15_q1 mem_dout 0 32 }  { y_partial_15_we1 mem_we 1 1 } } }
}
