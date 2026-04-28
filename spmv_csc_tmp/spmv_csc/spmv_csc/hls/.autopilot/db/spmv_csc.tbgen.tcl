set moduleName spmv_csc
set isTopModule 1
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
set C_modelName {spmv_csc}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ gmem0 int 512 regular {axi_master 0}  }
	{ gmem1 int 32 regular {axi_master 0}  }
	{ gmem2 int 512 regular {axi_master 0}  }
	{ gmem3 int 32 regular {axi_master 0}  }
	{ gmem4 int 512 regular {axi_master 1}  }
	{ num_rows int 32 regular {axi_slave 0}  }
	{ num_cols int 32 regular {axi_slave 0}  }
	{ nnz int 32 regular {axi_slave 0}  }
	{ A_row_idx int 64 regular {axi_slave 0}  }
	{ A_col_ptr int 64 regular {axi_slave 0}  }
	{ A_values int 64 regular {axi_slave 0}  }
	{ x int 64 regular {axi_slave 0}  }
	{ y int 64 regular {axi_slave 0}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "gmem0", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A_row_idx","offset": { "type": "dynamic","port_name": "A_row_idx","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem1", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A_col_ptr","offset": { "type": "dynamic","port_name": "A_col_ptr","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem2", "interface" : "axi_master", "bitwidth" : 512, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A_values","offset": { "type": "dynamic","port_name": "A_values","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem3", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "x","offset": { "type": "dynamic","port_name": "x","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "gmem4", "interface" : "axi_master", "bitwidth" : 512, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "y","offset": { "type": "dynamic","port_name": "y","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "num_rows", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":23}} , 
 	{ "Name" : "num_cols", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":24}, "offset_end" : {"in":31}} , 
 	{ "Name" : "nnz", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":32}, "offset_end" : {"in":39}} , 
 	{ "Name" : "A_row_idx", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":40}, "offset_end" : {"in":51}} , 
 	{ "Name" : "A_col_ptr", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":52}, "offset_end" : {"in":63}} , 
 	{ "Name" : "A_values", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":64}, "offset_end" : {"in":75}} , 
 	{ "Name" : "x", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":76}, "offset_end" : {"in":87}} , 
 	{ "Name" : "y", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":88}, "offset_end" : {"in":99}} ]}
# RTL Port declarations: 
set portNum 245
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_gmem0_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem0_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem0_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_WDATA sc_out sc_lv 512 signal 0 } 
	{ m_axi_gmem0_WSTRB sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem0_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_gmem0_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_gmem0_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_gmem0_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_gmem0_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_gmem0_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_gmem0_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_RDATA sc_in sc_lv 512 signal 0 } 
	{ m_axi_gmem0_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem0_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem0_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem0_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_gmem0_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_gmem0_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_gmem0_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem0_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_gmem1_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem1_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem1_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem1_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem1_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_gmem1_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem1_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem1_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem1_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem1_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem1_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem1_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem1_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_gmem1_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem1_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem1_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem1_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem1_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem1_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_gmem1_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem1_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_gmem1_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem1_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem1_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_gmem1_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_gmem1_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_gmem1_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_gmem1_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem1_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem1_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_gmem1_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem1_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem1_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem1_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem1_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_gmem1_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_gmem1_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_gmem1_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem1_BUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_gmem2_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem2_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem2_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem2_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem2_AWLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_gmem2_AWSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem2_AWBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem2_AWLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem2_AWCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem2_AWPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem2_AWQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem2_AWREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem2_AWUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem2_WVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem2_WREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem2_WDATA sc_out sc_lv 512 signal 2 } 
	{ m_axi_gmem2_WSTRB sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem2_WLAST sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem2_WID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem2_WUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem2_ARVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem2_ARREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem2_ARADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_gmem2_ARID sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem2_ARLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_gmem2_ARSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem2_ARBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem2_ARLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_gmem2_ARCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem2_ARPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_gmem2_ARQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem2_ARREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_gmem2_ARUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_gmem2_RVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem2_RREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem2_RDATA sc_in sc_lv 512 signal 2 } 
	{ m_axi_gmem2_RLAST sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem2_RID sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem2_RUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem2_RRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_gmem2_BVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_gmem2_BREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_gmem2_BRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_gmem2_BID sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem2_BUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_gmem3_AWVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem3_AWREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem3_AWADDR sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem3_AWID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem3_AWLEN sc_out sc_lv 8 signal 3 } 
	{ m_axi_gmem3_AWSIZE sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem3_AWBURST sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem3_AWLOCK sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem3_AWCACHE sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_AWPROT sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem3_AWQOS sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_AWREGION sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_AWUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem3_WVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem3_WREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem3_WDATA sc_out sc_lv 32 signal 3 } 
	{ m_axi_gmem3_WSTRB sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_WLAST sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem3_WID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem3_WUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem3_ARVALID sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem3_ARREADY sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem3_ARADDR sc_out sc_lv 64 signal 3 } 
	{ m_axi_gmem3_ARID sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem3_ARLEN sc_out sc_lv 8 signal 3 } 
	{ m_axi_gmem3_ARSIZE sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem3_ARBURST sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem3_ARLOCK sc_out sc_lv 2 signal 3 } 
	{ m_axi_gmem3_ARCACHE sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_ARPROT sc_out sc_lv 3 signal 3 } 
	{ m_axi_gmem3_ARQOS sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_ARREGION sc_out sc_lv 4 signal 3 } 
	{ m_axi_gmem3_ARUSER sc_out sc_lv 1 signal 3 } 
	{ m_axi_gmem3_RVALID sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem3_RREADY sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem3_RDATA sc_in sc_lv 32 signal 3 } 
	{ m_axi_gmem3_RLAST sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem3_RID sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem3_RUSER sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem3_RRESP sc_in sc_lv 2 signal 3 } 
	{ m_axi_gmem3_BVALID sc_in sc_logic 1 signal 3 } 
	{ m_axi_gmem3_BREADY sc_out sc_logic 1 signal 3 } 
	{ m_axi_gmem3_BRESP sc_in sc_lv 2 signal 3 } 
	{ m_axi_gmem3_BID sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem3_BUSER sc_in sc_lv 1 signal 3 } 
	{ m_axi_gmem4_AWVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_gmem4_AWREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_gmem4_AWADDR sc_out sc_lv 64 signal 4 } 
	{ m_axi_gmem4_AWID sc_out sc_lv 1 signal 4 } 
	{ m_axi_gmem4_AWLEN sc_out sc_lv 8 signal 4 } 
	{ m_axi_gmem4_AWSIZE sc_out sc_lv 3 signal 4 } 
	{ m_axi_gmem4_AWBURST sc_out sc_lv 2 signal 4 } 
	{ m_axi_gmem4_AWLOCK sc_out sc_lv 2 signal 4 } 
	{ m_axi_gmem4_AWCACHE sc_out sc_lv 4 signal 4 } 
	{ m_axi_gmem4_AWPROT sc_out sc_lv 3 signal 4 } 
	{ m_axi_gmem4_AWQOS sc_out sc_lv 4 signal 4 } 
	{ m_axi_gmem4_AWREGION sc_out sc_lv 4 signal 4 } 
	{ m_axi_gmem4_AWUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_gmem4_WVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_gmem4_WREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_gmem4_WDATA sc_out sc_lv 512 signal 4 } 
	{ m_axi_gmem4_WSTRB sc_out sc_lv 64 signal 4 } 
	{ m_axi_gmem4_WLAST sc_out sc_logic 1 signal 4 } 
	{ m_axi_gmem4_WID sc_out sc_lv 1 signal 4 } 
	{ m_axi_gmem4_WUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_gmem4_ARVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_gmem4_ARREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_gmem4_ARADDR sc_out sc_lv 64 signal 4 } 
	{ m_axi_gmem4_ARID sc_out sc_lv 1 signal 4 } 
	{ m_axi_gmem4_ARLEN sc_out sc_lv 8 signal 4 } 
	{ m_axi_gmem4_ARSIZE sc_out sc_lv 3 signal 4 } 
	{ m_axi_gmem4_ARBURST sc_out sc_lv 2 signal 4 } 
	{ m_axi_gmem4_ARLOCK sc_out sc_lv 2 signal 4 } 
	{ m_axi_gmem4_ARCACHE sc_out sc_lv 4 signal 4 } 
	{ m_axi_gmem4_ARPROT sc_out sc_lv 3 signal 4 } 
	{ m_axi_gmem4_ARQOS sc_out sc_lv 4 signal 4 } 
	{ m_axi_gmem4_ARREGION sc_out sc_lv 4 signal 4 } 
	{ m_axi_gmem4_ARUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_gmem4_RVALID sc_in sc_logic 1 signal 4 } 
	{ m_axi_gmem4_RREADY sc_out sc_logic 1 signal 4 } 
	{ m_axi_gmem4_RDATA sc_in sc_lv 512 signal 4 } 
	{ m_axi_gmem4_RLAST sc_in sc_logic 1 signal 4 } 
	{ m_axi_gmem4_RID sc_in sc_lv 1 signal 4 } 
	{ m_axi_gmem4_RUSER sc_in sc_lv 1 signal 4 } 
	{ m_axi_gmem4_RRESP sc_in sc_lv 2 signal 4 } 
	{ m_axi_gmem4_BVALID sc_in sc_logic 1 signal 4 } 
	{ m_axi_gmem4_BREADY sc_out sc_logic 1 signal 4 } 
	{ m_axi_gmem4_BRESP sc_in sc_lv 2 signal 4 } 
	{ m_axi_gmem4_BID sc_in sc_lv 1 signal 4 } 
	{ m_axi_gmem4_BUSER sc_in sc_lv 1 signal 4 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 7 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 7 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"spmv_csc","role":"start","value":"0","valid_bit":"0"},{"name":"spmv_csc","role":"continue","value":"0","valid_bit":"4"},{"name":"spmv_csc","role":"auto_start","value":"0","valid_bit":"7"},{"name":"num_rows","role":"data","value":"16"},{"name":"num_cols","role":"data","value":"24"},{"name":"nnz","role":"data","value":"32"},{"name":"A_row_idx","role":"data","value":"40"},{"name":"A_col_ptr","role":"data","value":"52"},{"name":"A_values","role":"data","value":"64"},{"name":"x","role":"data","value":"76"},{"name":"y","role":"data","value":"88"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"spmv_csc","role":"start","value":"0","valid_bit":"0"},{"name":"spmv_csc","role":"done","value":"0","valid_bit":"1"},{"name":"spmv_csc","role":"idle","value":"0","valid_bit":"2"},{"name":"spmv_csc","role":"ready","value":"0","valid_bit":"3"},{"name":"spmv_csc","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_gmem0_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem0_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem0_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem0_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem0_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem0", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem0_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem0_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem0_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem0_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem0_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem0_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem0_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem0_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem0_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem0_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem0_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem0", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem0_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem0_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem0_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WID" }} , 
 	{ "name": "m_axi_gmem0_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem0_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem0_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem0_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem0", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem0_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem0_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem0", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem0_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem0_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem0_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem0_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem0_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem0", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem0_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem0_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem0", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem0_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem0_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem0_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem0_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem0", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem0_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem0_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RID" }} , 
 	{ "name": "m_axi_gmem0_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem0_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem0_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem0_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem0_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem0", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem0_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BID" }} , 
 	{ "name": "m_axi_gmem0_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem0", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem1_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem1_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem1_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem1_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem1_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem1", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem1_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem1_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem1_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem1_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem1_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem1_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem1_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem1_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem1_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem1_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem1_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem1_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem1_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem1_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "WID" }} , 
 	{ "name": "m_axi_gmem1_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem1_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem1_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem1_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem1", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem1_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem1_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem1", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem1_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem1_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem1_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem1_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem1_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem1", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem1_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem1_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem1", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem1_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem1_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem1_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem1_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem1", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem1_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem1_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "RID" }} , 
 	{ "name": "m_axi_gmem1_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem1_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem1_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem1_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem1_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem1", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem1_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "BID" }} , 
 	{ "name": "m_axi_gmem1_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem1", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem2_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem2_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem2_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem2_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem2_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem2", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem2_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem2_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem2_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem2_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem2_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem2_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem2_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem2_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem2_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem2_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem2_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem2", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem2_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem2_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem2_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WID" }} , 
 	{ "name": "m_axi_gmem2_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem2_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem2_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem2_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem2", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem2_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem2_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem2", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem2_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem2_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem2_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem2_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem2_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem2", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem2_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem2_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem2", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem2_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem2_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem2_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem2_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem2", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem2_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem2_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RID" }} , 
 	{ "name": "m_axi_gmem2_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem2_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem2_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem2_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem2_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem2", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem2_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BID" }} , 
 	{ "name": "m_axi_gmem2_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem2", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem3_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem3_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem3_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem3", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem3_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem3_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem3", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem3_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem3_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem3_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem3_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem3_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem3_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem3_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem3_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem3_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem3_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem3_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem3", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem3_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem3_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem3_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "WID" }} , 
 	{ "name": "m_axi_gmem3_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem3_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem3_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem3_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem3", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem3_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem3_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem3", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem3_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem3_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem3_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem3_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem3_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem3", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem3_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem3_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem3", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem3_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem3_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem3_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem3_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "gmem3", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem3_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem3_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "RID" }} , 
 	{ "name": "m_axi_gmem3_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem3_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem3_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem3_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem3_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem3", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem3_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "BID" }} , 
 	{ "name": "m_axi_gmem3_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem3", "role": "BUSER" }} , 
 	{ "name": "m_axi_gmem4_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "AWVALID" }} , 
 	{ "name": "m_axi_gmem4_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "AWREADY" }} , 
 	{ "name": "m_axi_gmem4_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem4", "role": "AWADDR" }} , 
 	{ "name": "m_axi_gmem4_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "AWID" }} , 
 	{ "name": "m_axi_gmem4_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem4", "role": "AWLEN" }} , 
 	{ "name": "m_axi_gmem4_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_gmem4_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "AWBURST" }} , 
 	{ "name": "m_axi_gmem4_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_gmem4_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_gmem4_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "AWPROT" }} , 
 	{ "name": "m_axi_gmem4_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "AWQOS" }} , 
 	{ "name": "m_axi_gmem4_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "AWREGION" }} , 
 	{ "name": "m_axi_gmem4_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "AWUSER" }} , 
 	{ "name": "m_axi_gmem4_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "WVALID" }} , 
 	{ "name": "m_axi_gmem4_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "WREADY" }} , 
 	{ "name": "m_axi_gmem4_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem4", "role": "WDATA" }} , 
 	{ "name": "m_axi_gmem4_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem4", "role": "WSTRB" }} , 
 	{ "name": "m_axi_gmem4_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "WLAST" }} , 
 	{ "name": "m_axi_gmem4_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "WID" }} , 
 	{ "name": "m_axi_gmem4_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "WUSER" }} , 
 	{ "name": "m_axi_gmem4_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "ARVALID" }} , 
 	{ "name": "m_axi_gmem4_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "ARREADY" }} , 
 	{ "name": "m_axi_gmem4_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "gmem4", "role": "ARADDR" }} , 
 	{ "name": "m_axi_gmem4_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "ARID" }} , 
 	{ "name": "m_axi_gmem4_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "gmem4", "role": "ARLEN" }} , 
 	{ "name": "m_axi_gmem4_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_gmem4_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "ARBURST" }} , 
 	{ "name": "m_axi_gmem4_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_gmem4_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_gmem4_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "gmem4", "role": "ARPROT" }} , 
 	{ "name": "m_axi_gmem4_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "ARQOS" }} , 
 	{ "name": "m_axi_gmem4_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "gmem4", "role": "ARREGION" }} , 
 	{ "name": "m_axi_gmem4_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "ARUSER" }} , 
 	{ "name": "m_axi_gmem4_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "RVALID" }} , 
 	{ "name": "m_axi_gmem4_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "RREADY" }} , 
 	{ "name": "m_axi_gmem4_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":512, "type": "signal", "bundle":{"name": "gmem4", "role": "RDATA" }} , 
 	{ "name": "m_axi_gmem4_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "RLAST" }} , 
 	{ "name": "m_axi_gmem4_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "RID" }} , 
 	{ "name": "m_axi_gmem4_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "RUSER" }} , 
 	{ "name": "m_axi_gmem4_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "RRESP" }} , 
 	{ "name": "m_axi_gmem4_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "BVALID" }} , 
 	{ "name": "m_axi_gmem4_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "BREADY" }} , 
 	{ "name": "m_axi_gmem4_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "gmem4", "role": "BRESP" }} , 
 	{ "name": "m_axi_gmem4_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "BID" }} , 
 	{ "name": "m_axi_gmem4_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "gmem4", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "210", "229", "230", "231", "232", "233", "234"],
		"CDFG" : "spmv_csc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "gmem0", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "grp_spmv_csc_dataflow_fu_220", "Port" : "gmem0", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "gmem1", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "grp_spmv_csc_dataflow_fu_220", "Port" : "gmem1", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "grp_spmv_csc_dataflow_fu_220", "Port" : "gmem2", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "gmem3", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "grp_spmv_csc_dataflow_fu_220", "Port" : "gmem3", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "gmem4", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "210", "SubInstance" : "grp_reduce_and_write_packed_fu_255", "Port" : "gmem4", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "num_rows", "Type" : "None", "Direction" : "I"},
			{"Name" : "num_cols", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz", "Type" : "None", "Direction" : "I"},
			{"Name" : "A_row_idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "A_col_ptr", "Type" : "None", "Direction" : "I"},
			{"Name" : "A_values", "Type" : "None", "Direction" : "I"},
			{"Name" : "x", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_1_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_2_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_3_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_4_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_5_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_6_U", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_7_U", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_8_U", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_9_U", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_10_U", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_11_U", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_12_U", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_13_U", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_14_U", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.y_partial_15_U", "Parent" : "0"},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220", "Parent" : "0", "Child" : ["18", "19", "22", "25", "62", "69", "76", "83", "90", "97", "104", "111", "118", "125", "132", "139", "146", "153", "160", "167", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209"],
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
			{"ID" : "18", "Name" : "entry_proc_U0"},
			{"ID" : "19", "Name" : "read_col_info_U0"},
			{"ID" : "22", "Name" : "read_nnz_packed_U0"},
			{"ID" : "62", "Name" : "compute_pe_U0"},
			{"ID" : "69", "Name" : "compute_pe_1_U0"},
			{"ID" : "76", "Name" : "compute_pe_2_U0"},
			{"ID" : "83", "Name" : "compute_pe_3_U0"},
			{"ID" : "90", "Name" : "compute_pe_4_U0"},
			{"ID" : "97", "Name" : "compute_pe_5_U0"},
			{"ID" : "104", "Name" : "compute_pe_6_U0"},
			{"ID" : "111", "Name" : "compute_pe_7_U0"},
			{"ID" : "118", "Name" : "compute_pe_8_U0"},
			{"ID" : "125", "Name" : "compute_pe_9_U0"},
			{"ID" : "132", "Name" : "compute_pe_10_U0"},
			{"ID" : "139", "Name" : "compute_pe_11_U0"},
			{"ID" : "146", "Name" : "compute_pe_12_U0"},
			{"ID" : "153", "Name" : "compute_pe_13_U0"},
			{"ID" : "160", "Name" : "compute_pe_14_U0"},
			{"ID" : "167", "Name" : "compute_pe_15_U0"}],
		"OutputProcess" : [
			{"ID" : "62", "Name" : "compute_pe_U0"},
			{"ID" : "69", "Name" : "compute_pe_1_U0"},
			{"ID" : "76", "Name" : "compute_pe_2_U0"},
			{"ID" : "83", "Name" : "compute_pe_3_U0"},
			{"ID" : "90", "Name" : "compute_pe_4_U0"},
			{"ID" : "97", "Name" : "compute_pe_5_U0"},
			{"ID" : "104", "Name" : "compute_pe_6_U0"},
			{"ID" : "111", "Name" : "compute_pe_7_U0"},
			{"ID" : "118", "Name" : "compute_pe_8_U0"},
			{"ID" : "125", "Name" : "compute_pe_9_U0"},
			{"ID" : "132", "Name" : "compute_pe_10_U0"},
			{"ID" : "139", "Name" : "compute_pe_11_U0"},
			{"ID" : "146", "Name" : "compute_pe_12_U0"},
			{"ID" : "153", "Name" : "compute_pe_13_U0"},
			{"ID" : "160", "Name" : "compute_pe_14_U0"},
			{"ID" : "167", "Name" : "compute_pe_15_U0"}],
		"Port" : [
			{"Name" : "num_rows", "Type" : "None", "Direction" : "I"},
			{"Name" : "num_cols", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem0", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "22", "SubInstance" : "read_nnz_packed_U0", "Port" : "gmem0"}]},
			{"Name" : "A_row_idx", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem1", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "19", "SubInstance" : "read_col_info_U0", "Port" : "gmem1"}]},
			{"Name" : "A_col_ptr", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "22", "SubInstance" : "read_nnz_packed_U0", "Port" : "gmem2"}]},
			{"Name" : "A_values", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem3", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "19", "SubInstance" : "read_col_info_U0", "Port" : "gmem3"}]},
			{"Name" : "x", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_partial_0", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "62", "SubInstance" : "compute_pe_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_1", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "69", "SubInstance" : "compute_pe_1_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_2", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "76", "SubInstance" : "compute_pe_2_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_3", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "83", "SubInstance" : "compute_pe_3_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_4", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "90", "SubInstance" : "compute_pe_4_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_5", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "97", "SubInstance" : "compute_pe_5_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_6", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "104", "SubInstance" : "compute_pe_6_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_7", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "111", "SubInstance" : "compute_pe_7_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_8", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "118", "SubInstance" : "compute_pe_8_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_9", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "125", "SubInstance" : "compute_pe_9_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_10", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "132", "SubInstance" : "compute_pe_10_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_11", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "139", "SubInstance" : "compute_pe_11_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_12", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "146", "SubInstance" : "compute_pe_12_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_13", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "153", "SubInstance" : "compute_pe_13_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_14", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "160", "SubInstance" : "compute_pe_14_U0", "Port" : "y_partial"}]},
			{"Name" : "y_partial_15", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "167", "SubInstance" : "compute_pe_15_U0", "Port" : "y_partial"}]}]},
	{"ID" : "18", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.entry_proc_U0", "Parent" : "17",
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
			{"Name" : "num_rows_c", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["167"], "DependentChan" : "174", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["160"], "DependentChan" : "175", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["153"], "DependentChan" : "176", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c4", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["146"], "DependentChan" : "177", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c4_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c5", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["139"], "DependentChan" : "178", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c5_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c6", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["132"], "DependentChan" : "179", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c6_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c7", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["125"], "DependentChan" : "180", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c7_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c8", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["118"], "DependentChan" : "181", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c8_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c9", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["111"], "DependentChan" : "182", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c9_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c10", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["104"], "DependentChan" : "183", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c10_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c11", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["97"], "DependentChan" : "184", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c11_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c12", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["90"], "DependentChan" : "185", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c12_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c13", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["83"], "DependentChan" : "186", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c13_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c14", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["76"], "DependentChan" : "187", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c14_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c15", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["69"], "DependentChan" : "188", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c15_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "num_rows_c16", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["62"], "DependentChan" : "189", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_c16_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "19", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.read_col_info_U0", "Parent" : "17", "Child" : ["20"],
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
					{"ID" : "20", "SubInstance" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Port" : "gmem1", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "A_col_ptr", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem3", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem3_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "gmem3_blk_n_R", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "20", "SubInstance" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Port" : "gmem3", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "x_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "col_info_stream", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["25"], "DependentChan" : "190", "DependentChanDepth" : "64", "DependentChanType" : "0",
				"BlockSignal" : [
					{"Name" : "col_info_stream_blk_n", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "20", "SubInstance" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Port" : "col_info_stream", "Inst_start_state" : "10", "Inst_end_state" : "11"}]}]},
	{"ID" : "20", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149", "Parent" : "19", "Child" : ["21"],
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
	{"ID" : "21", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149.flow_control_loop_pipe_sequential_init_U", "Parent" : "20"},
	{"ID" : "22", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0", "Parent" : "17", "Child" : ["23"],
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
					{"ID" : "23", "SubInstance" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Port" : "gmem0", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "row_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "gmem2", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "gmem2_blk_n_AR", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "23", "SubInstance" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Port" : "gmem2", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "val_in", "Type" : "None", "Direction" : "I"},
			{"Name" : "nnz_stream", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["25"], "DependentChan" : "191", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "23", "SubInstance" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Port" : "nnz_stream", "Inst_start_state" : "10", "Inst_end_state" : "11"}]},
			{"Name" : "nnz_c", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["25"], "DependentChan" : "192", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "nnz_c_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "23", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114", "Parent" : "22", "Child" : ["24"],
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
	{"ID" : "24", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114.flow_control_loop_pipe_sequential_init_U", "Parent" : "23"},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0", "Parent" : "17", "Child" : ["26", "60"],
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
		"StartSource" : "19",
		"StartFifo" : "start_for_distribute_to_pe_U0_U",
		"Port" : [
			{"Name" : "nnz", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["22"], "DependentChan" : "192", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "nnz_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "col_info_stream", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["19"], "DependentChan" : "190", "DependentChanDepth" : "64", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "col_info_stream", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "nnz_stream", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["22"], "DependentChan" : "191", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "nnz_stream", "Inst_start_state" : "2", "Inst_end_state" : "3"}]},
			{"Name" : "pe_streams_0", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["62"], "DependentChan" : "193", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_0", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_0", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["69"], "DependentChan" : "194", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_1", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_1", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["76"], "DependentChan" : "195", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_2", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_2", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["83"], "DependentChan" : "196", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_3", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_3", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_4", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["90"], "DependentChan" : "197", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_4", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_4", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_5", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["97"], "DependentChan" : "198", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_5", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_5", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_6", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["104"], "DependentChan" : "199", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_6", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_6", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_7", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["111"], "DependentChan" : "200", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_7", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_7", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_8", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["118"], "DependentChan" : "201", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_8", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_8", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_9", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["125"], "DependentChan" : "202", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_9", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_9", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_10", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["132"], "DependentChan" : "203", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_10", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_10", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_11", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["139"], "DependentChan" : "204", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_11", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_11", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_12", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["146"], "DependentChan" : "205", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_12", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_12", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_13", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["153"], "DependentChan" : "206", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_13", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_13", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_14", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["160"], "DependentChan" : "207", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_14", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_14", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "pe_streams_15", "Type" : "Fifo", "Direction" : "O", "DependentProc" : ["167"], "DependentChan" : "208", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "26", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Port" : "pe_streams_15", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "60", "SubInstance" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Port" : "pe_streams_15", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "26", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72", "Parent" : "25", "Child" : ["27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
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
	{"ID" : "27", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U48", "Parent" : "26"},
	{"ID" : "28", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U49", "Parent" : "26"},
	{"ID" : "29", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U50", "Parent" : "26"},
	{"ID" : "30", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U51", "Parent" : "26"},
	{"ID" : "31", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U52", "Parent" : "26"},
	{"ID" : "32", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U53", "Parent" : "26"},
	{"ID" : "33", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U54", "Parent" : "26"},
	{"ID" : "34", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U55", "Parent" : "26"},
	{"ID" : "35", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U56", "Parent" : "26"},
	{"ID" : "36", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U57", "Parent" : "26"},
	{"ID" : "37", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U58", "Parent" : "26"},
	{"ID" : "38", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U59", "Parent" : "26"},
	{"ID" : "39", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U60", "Parent" : "26"},
	{"ID" : "40", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U61", "Parent" : "26"},
	{"ID" : "41", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U62", "Parent" : "26"},
	{"ID" : "42", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U63", "Parent" : "26"},
	{"ID" : "43", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U64", "Parent" : "26"},
	{"ID" : "44", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U65", "Parent" : "26"},
	{"ID" : "45", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U66", "Parent" : "26"},
	{"ID" : "46", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U67", "Parent" : "26"},
	{"ID" : "47", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U68", "Parent" : "26"},
	{"ID" : "48", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U69", "Parent" : "26"},
	{"ID" : "49", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U70", "Parent" : "26"},
	{"ID" : "50", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U71", "Parent" : "26"},
	{"ID" : "51", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U72", "Parent" : "26"},
	{"ID" : "52", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U73", "Parent" : "26"},
	{"ID" : "53", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U74", "Parent" : "26"},
	{"ID" : "54", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U75", "Parent" : "26"},
	{"ID" : "55", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U76", "Parent" : "26"},
	{"ID" : "56", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U77", "Parent" : "26"},
	{"ID" : "57", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U78", "Parent" : "26"},
	{"ID" : "58", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.sparsemux_33_4_32_1_1_U79", "Parent" : "26"},
	{"ID" : "59", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.flow_control_loop_pipe_sequential_init_U", "Parent" : "26"},
	{"ID" : "60", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113", "Parent" : "25", "Child" : ["61"],
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
	{"ID" : "61", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113.flow_control_loop_pipe_sequential_init_U", "Parent" : "60"},
	{"ID" : "62", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0", "Parent" : "17", "Child" : ["63", "65"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "189", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_0", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "193", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "65", "SubInstance" : "grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_0", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "63", "SubInstance" : "grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "65", "SubInstance" : "grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "63", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "62", "Child" : ["64"],
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
	{"ID" : "64", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "63"},
	{"ID" : "65", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "62", "Child" : ["66", "67", "68"],
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
	{"ID" : "66", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U137", "Parent" : "65"},
	{"ID" : "67", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U138", "Parent" : "65"},
	{"ID" : "68", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "65"},
	{"ID" : "69", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0", "Parent" : "17", "Child" : ["70", "72"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "188", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_1", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "194", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "72", "SubInstance" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_1", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "70", "SubInstance" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "72", "SubInstance" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "70", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "69", "Child" : ["71"],
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
	{"ID" : "71", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "70"},
	{"ID" : "72", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "69", "Child" : ["73", "74", "75"],
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
	{"ID" : "73", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U149", "Parent" : "72"},
	{"ID" : "74", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U150", "Parent" : "72"},
	{"ID" : "75", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "72"},
	{"ID" : "76", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0", "Parent" : "17", "Child" : ["77", "79"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "187", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_2", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "195", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "79", "SubInstance" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_2", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "77", "SubInstance" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "79", "SubInstance" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "77", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "76", "Child" : ["78"],
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
	{"ID" : "78", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "77"},
	{"ID" : "79", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "76", "Child" : ["80", "81", "82"],
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
	{"ID" : "80", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U159", "Parent" : "79"},
	{"ID" : "81", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U160", "Parent" : "79"},
	{"ID" : "82", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "79"},
	{"ID" : "83", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0", "Parent" : "17", "Child" : ["84", "86"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "186", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_3", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "196", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "86", "SubInstance" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_3", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "84", "SubInstance" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "86", "SubInstance" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "84", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "83", "Child" : ["85"],
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
	{"ID" : "85", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "84"},
	{"ID" : "86", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "83", "Child" : ["87", "88", "89"],
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
	{"ID" : "87", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U169", "Parent" : "86"},
	{"ID" : "88", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U170", "Parent" : "86"},
	{"ID" : "89", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "86"},
	{"ID" : "90", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0", "Parent" : "17", "Child" : ["91", "93"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "185", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_4", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "197", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "93", "SubInstance" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_4", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "91", "SubInstance" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "93", "SubInstance" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "91", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "90", "Child" : ["92"],
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
	{"ID" : "92", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "91"},
	{"ID" : "93", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "90", "Child" : ["94", "95", "96"],
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
	{"ID" : "94", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U179", "Parent" : "93"},
	{"ID" : "95", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U180", "Parent" : "93"},
	{"ID" : "96", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "93"},
	{"ID" : "97", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0", "Parent" : "17", "Child" : ["98", "100"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "184", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_5", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "198", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "100", "SubInstance" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_5", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "98", "SubInstance" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "100", "SubInstance" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "98", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "97", "Child" : ["99"],
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
	{"ID" : "99", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "98"},
	{"ID" : "100", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "97", "Child" : ["101", "102", "103"],
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
	{"ID" : "101", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U189", "Parent" : "100"},
	{"ID" : "102", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U190", "Parent" : "100"},
	{"ID" : "103", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "100"},
	{"ID" : "104", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0", "Parent" : "17", "Child" : ["105", "107"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "183", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_6", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "199", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "107", "SubInstance" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_6", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "105", "SubInstance" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "107", "SubInstance" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "105", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "104", "Child" : ["106"],
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
	{"ID" : "106", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "105"},
	{"ID" : "107", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "104", "Child" : ["108", "109", "110"],
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
	{"ID" : "108", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U199", "Parent" : "107"},
	{"ID" : "109", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U200", "Parent" : "107"},
	{"ID" : "110", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "107"},
	{"ID" : "111", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0", "Parent" : "17", "Child" : ["112", "114"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "182", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_7", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "200", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "114", "SubInstance" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_7", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "112", "SubInstance" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "114", "SubInstance" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "112", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "111", "Child" : ["113"],
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
	{"ID" : "113", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "112"},
	{"ID" : "114", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "111", "Child" : ["115", "116", "117"],
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
	{"ID" : "115", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U209", "Parent" : "114"},
	{"ID" : "116", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U210", "Parent" : "114"},
	{"ID" : "117", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "114"},
	{"ID" : "118", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0", "Parent" : "17", "Child" : ["119", "121"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "181", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_8", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "201", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "121", "SubInstance" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_8", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "119", "SubInstance" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "121", "SubInstance" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "119", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "118", "Child" : ["120"],
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
	{"ID" : "120", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "119"},
	{"ID" : "121", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "118", "Child" : ["122", "123", "124"],
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
	{"ID" : "122", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U219", "Parent" : "121"},
	{"ID" : "123", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U220", "Parent" : "121"},
	{"ID" : "124", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "121"},
	{"ID" : "125", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0", "Parent" : "17", "Child" : ["126", "128"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "180", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_9", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "202", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "128", "SubInstance" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_9", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "126", "SubInstance" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "128", "SubInstance" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "126", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "125", "Child" : ["127"],
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
	{"ID" : "127", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "126"},
	{"ID" : "128", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "125", "Child" : ["129", "130", "131"],
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
	{"ID" : "129", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U229", "Parent" : "128"},
	{"ID" : "130", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U230", "Parent" : "128"},
	{"ID" : "131", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "128"},
	{"ID" : "132", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0", "Parent" : "17", "Child" : ["133", "135"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "179", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_10", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "203", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "135", "SubInstance" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_10", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "133", "SubInstance" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "135", "SubInstance" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "133", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "132", "Child" : ["134"],
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
	{"ID" : "134", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "133"},
	{"ID" : "135", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "132", "Child" : ["136", "137", "138"],
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
	{"ID" : "136", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U239", "Parent" : "135"},
	{"ID" : "137", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U240", "Parent" : "135"},
	{"ID" : "138", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "135"},
	{"ID" : "139", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0", "Parent" : "17", "Child" : ["140", "142"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "178", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_11", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "204", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "142", "SubInstance" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_11", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "140", "SubInstance" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "142", "SubInstance" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "140", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "139", "Child" : ["141"],
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
	{"ID" : "141", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "140"},
	{"ID" : "142", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "139", "Child" : ["143", "144", "145"],
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
	{"ID" : "143", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U249", "Parent" : "142"},
	{"ID" : "144", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U250", "Parent" : "142"},
	{"ID" : "145", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "142"},
	{"ID" : "146", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0", "Parent" : "17", "Child" : ["147", "149"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "177", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_12", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "205", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "149", "SubInstance" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_12", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "147", "SubInstance" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "149", "SubInstance" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "147", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "146", "Child" : ["148"],
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
	{"ID" : "148", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "147"},
	{"ID" : "149", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "146", "Child" : ["150", "151", "152"],
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
	{"ID" : "150", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U259", "Parent" : "149"},
	{"ID" : "151", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U260", "Parent" : "149"},
	{"ID" : "152", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "149"},
	{"ID" : "153", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0", "Parent" : "17", "Child" : ["154", "156"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "176", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_13", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "206", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "156", "SubInstance" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_13", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "154", "SubInstance" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "156", "SubInstance" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "154", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "153", "Child" : ["155"],
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
	{"ID" : "155", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "154"},
	{"ID" : "156", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "153", "Child" : ["157", "158", "159"],
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
	{"ID" : "157", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U269", "Parent" : "156"},
	{"ID" : "158", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U270", "Parent" : "156"},
	{"ID" : "159", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "156"},
	{"ID" : "160", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0", "Parent" : "17", "Child" : ["161", "163"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "175", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_14", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "207", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "163", "SubInstance" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_14", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "161", "SubInstance" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "163", "SubInstance" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "161", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "160", "Child" : ["162"],
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
	{"ID" : "162", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "161"},
	{"ID" : "163", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "160", "Child" : ["164", "165", "166"],
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
	{"ID" : "164", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U279", "Parent" : "163"},
	{"ID" : "165", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U280", "Parent" : "163"},
	{"ID" : "166", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "163"},
	{"ID" : "167", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0", "Parent" : "17", "Child" : ["168", "170"],
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
			{"Name" : "num_rows", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["18"], "DependentChan" : "174", "DependentChanDepth" : "4", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "num_rows_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "pe_streams_15", "Type" : "Fifo", "Direction" : "I", "DependentProc" : ["25"], "DependentChan" : "208", "DependentChanDepth" : "256", "DependentChanType" : "0",
				"SubConnect" : [
					{"ID" : "170", "SubInstance" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "pe_streams_15", "Inst_start_state" : "4", "Inst_end_state" : "5"}]},
			{"Name" : "y_partial", "Type" : "Memory", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "168", "SubInstance" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48", "Port" : "y_partial", "Inst_start_state" : "2", "Inst_end_state" : "3"},
					{"ID" : "170", "SubInstance" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55", "Port" : "y_partial", "Inst_start_state" : "4", "Inst_end_state" : "5"}]}]},
	{"ID" : "168", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48", "Parent" : "167", "Child" : ["169"],
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
	{"ID" : "169", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48.flow_control_loop_pipe_sequential_init_U", "Parent" : "168"},
	{"ID" : "170", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55", "Parent" : "167", "Child" : ["171", "172", "173"],
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
	{"ID" : "171", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.fadd_32ns_32ns_32_5_no_dsp_1_U289", "Parent" : "170"},
	{"ID" : "172", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.fmul_32ns_32ns_32_4_max_dsp_1_U290", "Parent" : "170"},
	{"ID" : "173", "Level" : "4", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.flow_control_loop_pipe_sequential_init_U", "Parent" : "170"},
	{"ID" : "174", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c_U", "Parent" : "17"},
	{"ID" : "175", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U", "Parent" : "17"},
	{"ID" : "176", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U", "Parent" : "17"},
	{"ID" : "177", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U", "Parent" : "17"},
	{"ID" : "178", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U", "Parent" : "17"},
	{"ID" : "179", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U", "Parent" : "17"},
	{"ID" : "180", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U", "Parent" : "17"},
	{"ID" : "181", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U", "Parent" : "17"},
	{"ID" : "182", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U", "Parent" : "17"},
	{"ID" : "183", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U", "Parent" : "17"},
	{"ID" : "184", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U", "Parent" : "17"},
	{"ID" : "185", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U", "Parent" : "17"},
	{"ID" : "186", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U", "Parent" : "17"},
	{"ID" : "187", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U", "Parent" : "17"},
	{"ID" : "188", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U", "Parent" : "17"},
	{"ID" : "189", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U", "Parent" : "17"},
	{"ID" : "190", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.col_info_stream_U", "Parent" : "17"},
	{"ID" : "191", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.nnz_stream_U", "Parent" : "17"},
	{"ID" : "192", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.nnz_c_U", "Parent" : "17"},
	{"ID" : "193", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U", "Parent" : "17"},
	{"ID" : "194", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U", "Parent" : "17"},
	{"ID" : "195", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U", "Parent" : "17"},
	{"ID" : "196", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U", "Parent" : "17"},
	{"ID" : "197", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U", "Parent" : "17"},
	{"ID" : "198", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U", "Parent" : "17"},
	{"ID" : "199", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U", "Parent" : "17"},
	{"ID" : "200", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U", "Parent" : "17"},
	{"ID" : "201", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U", "Parent" : "17"},
	{"ID" : "202", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U", "Parent" : "17"},
	{"ID" : "203", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U", "Parent" : "17"},
	{"ID" : "204", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U", "Parent" : "17"},
	{"ID" : "205", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U", "Parent" : "17"},
	{"ID" : "206", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U", "Parent" : "17"},
	{"ID" : "207", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U", "Parent" : "17"},
	{"ID" : "208", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U", "Parent" : "17"},
	{"ID" : "209", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U", "Parent" : "17"},
	{"ID" : "210", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255", "Parent" : "0", "Child" : ["211"],
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
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_0", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_1", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_1", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_2", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_2", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_3", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_3", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_4", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_4", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_5", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_5", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_6", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_6", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_7", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_7", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_8", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_8", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_9", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_9", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_10", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_10", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_11", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_11", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_12", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_12", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_13", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_13", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_14", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_14", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_partial_15", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "y_partial_15", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "gmem4", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "gmem4_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "gmem4_blk_n_B", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "211", "SubInstance" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Port" : "gmem4", "Inst_start_state" : "3", "Inst_end_state" : "4"}]},
			{"Name" : "y_out", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "211", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121", "Parent" : "210", "Child" : ["212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228"],
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
	{"ID" : "212", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U360", "Parent" : "211"},
	{"ID" : "213", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U361", "Parent" : "211"},
	{"ID" : "214", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U362", "Parent" : "211"},
	{"ID" : "215", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U363", "Parent" : "211"},
	{"ID" : "216", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U364", "Parent" : "211"},
	{"ID" : "217", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U365", "Parent" : "211"},
	{"ID" : "218", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U366", "Parent" : "211"},
	{"ID" : "219", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U367", "Parent" : "211"},
	{"ID" : "220", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U368", "Parent" : "211"},
	{"ID" : "221", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U369", "Parent" : "211"},
	{"ID" : "222", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U370", "Parent" : "211"},
	{"ID" : "223", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U371", "Parent" : "211"},
	{"ID" : "224", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U372", "Parent" : "211"},
	{"ID" : "225", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U373", "Parent" : "211"},
	{"ID" : "226", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U374", "Parent" : "211"},
	{"ID" : "227", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.fadd_32ns_32ns_32_8_full_dsp_1_U375", "Parent" : "211"},
	{"ID" : "228", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_reduce_and_write_packed_fu_255.grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121.flow_control_loop_pipe_sequential_init_U", "Parent" : "211"},
	{"ID" : "229", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "230", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.gmem0_m_axi_U", "Parent" : "0"},
	{"ID" : "231", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.gmem1_m_axi_U", "Parent" : "0"},
	{"ID" : "232", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.gmem2_m_axi_U", "Parent" : "0"},
	{"ID" : "233", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.gmem3_m_axi_U", "Parent" : "0"},
	{"ID" : "234", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.gmem4_m_axi_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	spmv_csc {
		gmem0 {Type I LastRead 1 FirstWrite -1}
		gmem1 {Type I LastRead 19 FirstWrite -1}
		gmem2 {Type I LastRead 1 FirstWrite -1}
		gmem3 {Type I LastRead 8 FirstWrite -1}
		gmem4 {Type O LastRead 4 FirstWrite 132}
		num_rows {Type I LastRead 0 FirstWrite -1}
		num_cols {Type I LastRead 0 FirstWrite -1}
		nnz {Type I LastRead 0 FirstWrite -1}
		A_row_idx {Type I LastRead 0 FirstWrite -1}
		A_col_ptr {Type I LastRead 0 FirstWrite -1}
		A_values {Type I LastRead 0 FirstWrite -1}
		x {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}}
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
		y_partial {Type IO LastRead 4 FirstWrite 9}}
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
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	gmem0 { m_axi {  { m_axi_gmem0_AWVALID VALID 1 1 }  { m_axi_gmem0_AWREADY READY 0 1 }  { m_axi_gmem0_AWADDR ADDR 1 64 }  { m_axi_gmem0_AWID ID 1 1 }  { m_axi_gmem0_AWLEN SIZE 1 8 }  { m_axi_gmem0_AWSIZE BURST 1 3 }  { m_axi_gmem0_AWBURST LOCK 1 2 }  { m_axi_gmem0_AWLOCK CACHE 1 2 }  { m_axi_gmem0_AWCACHE PROT 1 4 }  { m_axi_gmem0_AWPROT QOS 1 3 }  { m_axi_gmem0_AWQOS REGION 1 4 }  { m_axi_gmem0_AWREGION USER 1 4 }  { m_axi_gmem0_AWUSER DATA 1 1 }  { m_axi_gmem0_WVALID VALID 1 1 }  { m_axi_gmem0_WREADY READY 0 1 }  { m_axi_gmem0_WDATA FIFONUM 1 512 }  { m_axi_gmem0_WSTRB STRB 1 64 }  { m_axi_gmem0_WLAST LAST 1 1 }  { m_axi_gmem0_WID ID 1 1 }  { m_axi_gmem0_WUSER DATA 1 1 }  { m_axi_gmem0_ARVALID VALID 1 1 }  { m_axi_gmem0_ARREADY READY 0 1 }  { m_axi_gmem0_ARADDR ADDR 1 64 }  { m_axi_gmem0_ARID ID 1 1 }  { m_axi_gmem0_ARLEN SIZE 1 8 }  { m_axi_gmem0_ARSIZE BURST 1 3 }  { m_axi_gmem0_ARBURST LOCK 1 2 }  { m_axi_gmem0_ARLOCK CACHE 1 2 }  { m_axi_gmem0_ARCACHE PROT 1 4 }  { m_axi_gmem0_ARPROT QOS 1 3 }  { m_axi_gmem0_ARQOS REGION 1 4 }  { m_axi_gmem0_ARREGION USER 1 4 }  { m_axi_gmem0_ARUSER DATA 1 1 }  { m_axi_gmem0_RVALID VALID 0 1 }  { m_axi_gmem0_RREADY READY 1 1 }  { m_axi_gmem0_RDATA FIFONUM 0 512 }  { m_axi_gmem0_RLAST LAST 0 1 }  { m_axi_gmem0_RID ID 0 1 }  { m_axi_gmem0_RUSER DATA 0 1 }  { m_axi_gmem0_RRESP RESP 0 2 }  { m_axi_gmem0_BVALID VALID 0 1 }  { m_axi_gmem0_BREADY READY 1 1 }  { m_axi_gmem0_BRESP RESP 0 2 }  { m_axi_gmem0_BID ID 0 1 }  { m_axi_gmem0_BUSER DATA 0 1 } } }
	gmem1 { m_axi {  { m_axi_gmem1_AWVALID VALID 1 1 }  { m_axi_gmem1_AWREADY READY 0 1 }  { m_axi_gmem1_AWADDR ADDR 1 64 }  { m_axi_gmem1_AWID ID 1 1 }  { m_axi_gmem1_AWLEN SIZE 1 8 }  { m_axi_gmem1_AWSIZE BURST 1 3 }  { m_axi_gmem1_AWBURST LOCK 1 2 }  { m_axi_gmem1_AWLOCK CACHE 1 2 }  { m_axi_gmem1_AWCACHE PROT 1 4 }  { m_axi_gmem1_AWPROT QOS 1 3 }  { m_axi_gmem1_AWQOS REGION 1 4 }  { m_axi_gmem1_AWREGION USER 1 4 }  { m_axi_gmem1_AWUSER DATA 1 1 }  { m_axi_gmem1_WVALID VALID 1 1 }  { m_axi_gmem1_WREADY READY 0 1 }  { m_axi_gmem1_WDATA FIFONUM 1 32 }  { m_axi_gmem1_WSTRB STRB 1 4 }  { m_axi_gmem1_WLAST LAST 1 1 }  { m_axi_gmem1_WID ID 1 1 }  { m_axi_gmem1_WUSER DATA 1 1 }  { m_axi_gmem1_ARVALID VALID 1 1 }  { m_axi_gmem1_ARREADY READY 0 1 }  { m_axi_gmem1_ARADDR ADDR 1 64 }  { m_axi_gmem1_ARID ID 1 1 }  { m_axi_gmem1_ARLEN SIZE 1 8 }  { m_axi_gmem1_ARSIZE BURST 1 3 }  { m_axi_gmem1_ARBURST LOCK 1 2 }  { m_axi_gmem1_ARLOCK CACHE 1 2 }  { m_axi_gmem1_ARCACHE PROT 1 4 }  { m_axi_gmem1_ARPROT QOS 1 3 }  { m_axi_gmem1_ARQOS REGION 1 4 }  { m_axi_gmem1_ARREGION USER 1 4 }  { m_axi_gmem1_ARUSER DATA 1 1 }  { m_axi_gmem1_RVALID VALID 0 1 }  { m_axi_gmem1_RREADY READY 1 1 }  { m_axi_gmem1_RDATA FIFONUM 0 32 }  { m_axi_gmem1_RLAST LAST 0 1 }  { m_axi_gmem1_RID ID 0 1 }  { m_axi_gmem1_RUSER DATA 0 1 }  { m_axi_gmem1_RRESP RESP 0 2 }  { m_axi_gmem1_BVALID VALID 0 1 }  { m_axi_gmem1_BREADY READY 1 1 }  { m_axi_gmem1_BRESP RESP 0 2 }  { m_axi_gmem1_BID ID 0 1 }  { m_axi_gmem1_BUSER DATA 0 1 } } }
	gmem2 { m_axi {  { m_axi_gmem2_AWVALID VALID 1 1 }  { m_axi_gmem2_AWREADY READY 0 1 }  { m_axi_gmem2_AWADDR ADDR 1 64 }  { m_axi_gmem2_AWID ID 1 1 }  { m_axi_gmem2_AWLEN SIZE 1 8 }  { m_axi_gmem2_AWSIZE BURST 1 3 }  { m_axi_gmem2_AWBURST LOCK 1 2 }  { m_axi_gmem2_AWLOCK CACHE 1 2 }  { m_axi_gmem2_AWCACHE PROT 1 4 }  { m_axi_gmem2_AWPROT QOS 1 3 }  { m_axi_gmem2_AWQOS REGION 1 4 }  { m_axi_gmem2_AWREGION USER 1 4 }  { m_axi_gmem2_AWUSER DATA 1 1 }  { m_axi_gmem2_WVALID VALID 1 1 }  { m_axi_gmem2_WREADY READY 0 1 }  { m_axi_gmem2_WDATA FIFONUM 1 512 }  { m_axi_gmem2_WSTRB STRB 1 64 }  { m_axi_gmem2_WLAST LAST 1 1 }  { m_axi_gmem2_WID ID 1 1 }  { m_axi_gmem2_WUSER DATA 1 1 }  { m_axi_gmem2_ARVALID VALID 1 1 }  { m_axi_gmem2_ARREADY READY 0 1 }  { m_axi_gmem2_ARADDR ADDR 1 64 }  { m_axi_gmem2_ARID ID 1 1 }  { m_axi_gmem2_ARLEN SIZE 1 8 }  { m_axi_gmem2_ARSIZE BURST 1 3 }  { m_axi_gmem2_ARBURST LOCK 1 2 }  { m_axi_gmem2_ARLOCK CACHE 1 2 }  { m_axi_gmem2_ARCACHE PROT 1 4 }  { m_axi_gmem2_ARPROT QOS 1 3 }  { m_axi_gmem2_ARQOS REGION 1 4 }  { m_axi_gmem2_ARREGION USER 1 4 }  { m_axi_gmem2_ARUSER DATA 1 1 }  { m_axi_gmem2_RVALID VALID 0 1 }  { m_axi_gmem2_RREADY READY 1 1 }  { m_axi_gmem2_RDATA FIFONUM 0 512 }  { m_axi_gmem2_RLAST LAST 0 1 }  { m_axi_gmem2_RID ID 0 1 }  { m_axi_gmem2_RUSER DATA 0 1 }  { m_axi_gmem2_RRESP RESP 0 2 }  { m_axi_gmem2_BVALID VALID 0 1 }  { m_axi_gmem2_BREADY READY 1 1 }  { m_axi_gmem2_BRESP RESP 0 2 }  { m_axi_gmem2_BID ID 0 1 }  { m_axi_gmem2_BUSER DATA 0 1 } } }
	gmem3 { m_axi {  { m_axi_gmem3_AWVALID VALID 1 1 }  { m_axi_gmem3_AWREADY READY 0 1 }  { m_axi_gmem3_AWADDR ADDR 1 64 }  { m_axi_gmem3_AWID ID 1 1 }  { m_axi_gmem3_AWLEN SIZE 1 8 }  { m_axi_gmem3_AWSIZE BURST 1 3 }  { m_axi_gmem3_AWBURST LOCK 1 2 }  { m_axi_gmem3_AWLOCK CACHE 1 2 }  { m_axi_gmem3_AWCACHE PROT 1 4 }  { m_axi_gmem3_AWPROT QOS 1 3 }  { m_axi_gmem3_AWQOS REGION 1 4 }  { m_axi_gmem3_AWREGION USER 1 4 }  { m_axi_gmem3_AWUSER DATA 1 1 }  { m_axi_gmem3_WVALID VALID 1 1 }  { m_axi_gmem3_WREADY READY 0 1 }  { m_axi_gmem3_WDATA FIFONUM 1 32 }  { m_axi_gmem3_WSTRB STRB 1 4 }  { m_axi_gmem3_WLAST LAST 1 1 }  { m_axi_gmem3_WID ID 1 1 }  { m_axi_gmem3_WUSER DATA 1 1 }  { m_axi_gmem3_ARVALID VALID 1 1 }  { m_axi_gmem3_ARREADY READY 0 1 }  { m_axi_gmem3_ARADDR ADDR 1 64 }  { m_axi_gmem3_ARID ID 1 1 }  { m_axi_gmem3_ARLEN SIZE 1 8 }  { m_axi_gmem3_ARSIZE BURST 1 3 }  { m_axi_gmem3_ARBURST LOCK 1 2 }  { m_axi_gmem3_ARLOCK CACHE 1 2 }  { m_axi_gmem3_ARCACHE PROT 1 4 }  { m_axi_gmem3_ARPROT QOS 1 3 }  { m_axi_gmem3_ARQOS REGION 1 4 }  { m_axi_gmem3_ARREGION USER 1 4 }  { m_axi_gmem3_ARUSER DATA 1 1 }  { m_axi_gmem3_RVALID VALID 0 1 }  { m_axi_gmem3_RREADY READY 1 1 }  { m_axi_gmem3_RDATA FIFONUM 0 32 }  { m_axi_gmem3_RLAST LAST 0 1 }  { m_axi_gmem3_RID ID 0 1 }  { m_axi_gmem3_RUSER DATA 0 1 }  { m_axi_gmem3_RRESP RESP 0 2 }  { m_axi_gmem3_BVALID VALID 0 1 }  { m_axi_gmem3_BREADY READY 1 1 }  { m_axi_gmem3_BRESP RESP 0 2 }  { m_axi_gmem3_BID ID 0 1 }  { m_axi_gmem3_BUSER DATA 0 1 } } }
	gmem4 { m_axi {  { m_axi_gmem4_AWVALID VALID 1 1 }  { m_axi_gmem4_AWREADY READY 0 1 }  { m_axi_gmem4_AWADDR ADDR 1 64 }  { m_axi_gmem4_AWID ID 1 1 }  { m_axi_gmem4_AWLEN SIZE 1 8 }  { m_axi_gmem4_AWSIZE BURST 1 3 }  { m_axi_gmem4_AWBURST LOCK 1 2 }  { m_axi_gmem4_AWLOCK CACHE 1 2 }  { m_axi_gmem4_AWCACHE PROT 1 4 }  { m_axi_gmem4_AWPROT QOS 1 3 }  { m_axi_gmem4_AWQOS REGION 1 4 }  { m_axi_gmem4_AWREGION USER 1 4 }  { m_axi_gmem4_AWUSER DATA 1 1 }  { m_axi_gmem4_WVALID VALID 1 1 }  { m_axi_gmem4_WREADY READY 0 1 }  { m_axi_gmem4_WDATA FIFONUM 1 512 }  { m_axi_gmem4_WSTRB STRB 1 64 }  { m_axi_gmem4_WLAST LAST 1 1 }  { m_axi_gmem4_WID ID 1 1 }  { m_axi_gmem4_WUSER DATA 1 1 }  { m_axi_gmem4_ARVALID VALID 1 1 }  { m_axi_gmem4_ARREADY READY 0 1 }  { m_axi_gmem4_ARADDR ADDR 1 64 }  { m_axi_gmem4_ARID ID 1 1 }  { m_axi_gmem4_ARLEN SIZE 1 8 }  { m_axi_gmem4_ARSIZE BURST 1 3 }  { m_axi_gmem4_ARBURST LOCK 1 2 }  { m_axi_gmem4_ARLOCK CACHE 1 2 }  { m_axi_gmem4_ARCACHE PROT 1 4 }  { m_axi_gmem4_ARPROT QOS 1 3 }  { m_axi_gmem4_ARQOS REGION 1 4 }  { m_axi_gmem4_ARREGION USER 1 4 }  { m_axi_gmem4_ARUSER DATA 1 1 }  { m_axi_gmem4_RVALID VALID 0 1 }  { m_axi_gmem4_RREADY READY 1 1 }  { m_axi_gmem4_RDATA FIFONUM 0 512 }  { m_axi_gmem4_RLAST LAST 0 1 }  { m_axi_gmem4_RID ID 0 1 }  { m_axi_gmem4_RUSER DATA 0 1 }  { m_axi_gmem4_RRESP RESP 0 2 }  { m_axi_gmem4_BVALID VALID 0 1 }  { m_axi_gmem4_BREADY READY 1 1 }  { m_axi_gmem4_BRESP RESP 0 2 }  { m_axi_gmem4_BID ID 0 1 }  { m_axi_gmem4_BUSER DATA 0 1 } } }
}

set maxi_interface_dict [dict create]
dict set maxi_interface_dict gmem0 { CHANNEL_NUM 0 BUNDLE gmem0 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem1 { CHANNEL_NUM 0 BUNDLE gmem1 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem2 { CHANNEL_NUM 0 BUNDLE gmem2 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem3 { CHANNEL_NUM 0 BUNDLE gmem3 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict gmem4 { CHANNEL_NUM 0 BUNDLE gmem4 NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE WRITE_ONLY}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ gmem0 1 }
	{ gmem1 1 }
	{ gmem2 1 }
	{ gmem3 1 }
	{ gmem4 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ gmem0 1 }
	{ gmem1 1 }
	{ gmem2 1 }
	{ gmem3 1 }
	{ gmem4 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
