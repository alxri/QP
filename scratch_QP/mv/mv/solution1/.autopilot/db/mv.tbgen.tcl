set moduleName mv
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
set cdfgNum 6
set C_modelName {mv}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ A_port int 32 regular {axi_master 0}  }
	{ b_port int 32 regular {axi_master 0}  }
	{ c_port int 32 regular {axi_master 1}  }
	{ A int 64 regular {axi_slave 0}  }
	{ x int 64 regular {axi_slave 0}  }
	{ y int 64 regular {axi_slave 0}  }
	{ rows int 32 regular {axi_slave 0}  }
	{ columns int 32 regular {axi_slave 0}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "A_port", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "A","offset": { "type": "dynamic","port_name": "A","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "b_port", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[ {"cElement": [{"cName": "x","offset": { "type": "dynamic","port_name": "x","bundle": "control"},"direction": "READONLY"}]}]} , 
 	{ "Name" : "c_port", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[ {"cElement": [{"cName": "y","offset": { "type": "dynamic","port_name": "y","bundle": "control"},"direction": "WRITEONLY"}]}]} , 
 	{ "Name" : "A", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "x", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "y", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":40}, "offset_end" : {"in":51}} , 
 	{ "Name" : "rows", "interface" : "axi_slave", "bundle":"control_bus","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":23}} , 
 	{ "Name" : "columns", "interface" : "axi_slave", "bundle":"control_bus","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":24}, "offset_end" : {"in":31}} ]}
# RTL Port declarations: 
set portNum 172
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_A_port_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_A_port_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_A_port_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_A_port_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_A_port_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_A_port_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_A_port_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_A_port_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_A_port_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_A_port_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_A_port_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_A_port_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_A_port_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_A_port_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_A_port_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_A_port_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_A_port_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_A_port_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_A_port_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_A_port_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_A_port_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_A_port_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_A_port_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_A_port_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_A_port_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_A_port_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_A_port_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_A_port_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_A_port_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_A_port_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_A_port_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_A_port_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_A_port_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_A_port_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_A_port_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_A_port_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_A_port_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_A_port_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_A_port_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_b_port_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_b_port_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_b_port_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_b_port_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_b_port_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_b_port_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_b_port_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_b_port_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_b_port_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_b_port_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_b_port_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_b_port_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_b_port_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_b_port_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_b_port_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_b_port_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_b_port_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_b_port_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_b_port_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_b_port_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_b_port_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_b_port_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_b_port_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_b_port_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_b_port_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_b_port_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_b_port_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_b_port_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_b_port_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_b_port_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_b_port_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_b_port_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_b_port_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_b_port_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_b_port_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_b_port_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_b_port_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_b_port_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_b_port_BUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_c_port_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_c_port_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_c_port_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_c_port_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_c_port_AWLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_c_port_AWSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_c_port_AWBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_c_port_AWLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_c_port_AWCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_AWPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_c_port_AWQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_AWREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_AWUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_c_port_WVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_c_port_WREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_c_port_WDATA sc_out sc_lv 32 signal 2 } 
	{ m_axi_c_port_WSTRB sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_WLAST sc_out sc_logic 1 signal 2 } 
	{ m_axi_c_port_WID sc_out sc_lv 1 signal 2 } 
	{ m_axi_c_port_WUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_c_port_ARVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_c_port_ARREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_c_port_ARADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_c_port_ARID sc_out sc_lv 1 signal 2 } 
	{ m_axi_c_port_ARLEN sc_out sc_lv 8 signal 2 } 
	{ m_axi_c_port_ARSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_c_port_ARBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_c_port_ARLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_c_port_ARCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_ARPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_c_port_ARQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_ARREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_c_port_ARUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_c_port_RVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_c_port_RREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_c_port_RDATA sc_in sc_lv 32 signal 2 } 
	{ m_axi_c_port_RLAST sc_in sc_logic 1 signal 2 } 
	{ m_axi_c_port_RID sc_in sc_lv 1 signal 2 } 
	{ m_axi_c_port_RUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_c_port_RRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_c_port_BVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_c_port_BREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_c_port_BRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_c_port_BID sc_in sc_lv 1 signal 2 } 
	{ m_axi_c_port_BUSER sc_in sc_lv 1 signal 2 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_bus_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_bus_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_bus_AWADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_control_bus_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_bus_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_bus_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_bus_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_bus_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_bus_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_bus_ARADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_control_bus_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_bus_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_bus_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_bus_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_bus_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_bus_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_bus_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"A","role":"data","value":"16"},{"name":"x","role":"data","value":"28"},{"name":"y","role":"data","value":"40"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "s_axi_control_bus_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "control_bus", "role": "AWADDR" },"address":[{"name":"mv","role":"start","value":"0","valid_bit":"0"},{"name":"mv","role":"continue","value":"0","valid_bit":"4"},{"name":"mv","role":"auto_start","value":"0","valid_bit":"7"},{"name":"rows","role":"data","value":"16"},{"name":"columns","role":"data","value":"24"}] },
	{ "name": "s_axi_control_bus_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "AWVALID" } },
	{ "name": "s_axi_control_bus_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "AWREADY" } },
	{ "name": "s_axi_control_bus_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "WVALID" } },
	{ "name": "s_axi_control_bus_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "WREADY" } },
	{ "name": "s_axi_control_bus_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control_bus", "role": "WDATA" } },
	{ "name": "s_axi_control_bus_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control_bus", "role": "WSTRB" } },
	{ "name": "s_axi_control_bus_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "control_bus", "role": "ARADDR" },"address":[{"name":"mv","role":"start","value":"0","valid_bit":"0"},{"name":"mv","role":"done","value":"0","valid_bit":"1"},{"name":"mv","role":"idle","value":"0","valid_bit":"2"},{"name":"mv","role":"ready","value":"0","valid_bit":"3"},{"name":"mv","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_bus_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "ARVALID" } },
	{ "name": "s_axi_control_bus_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "ARREADY" } },
	{ "name": "s_axi_control_bus_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "RVALID" } },
	{ "name": "s_axi_control_bus_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "RREADY" } },
	{ "name": "s_axi_control_bus_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control_bus", "role": "RDATA" } },
	{ "name": "s_axi_control_bus_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control_bus", "role": "RRESP" } },
	{ "name": "s_axi_control_bus_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "BVALID" } },
	{ "name": "s_axi_control_bus_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "BREADY" } },
	{ "name": "s_axi_control_bus_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control_bus", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control_bus", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_A_port_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "AWVALID" }} , 
 	{ "name": "m_axi_A_port_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "AWREADY" }} , 
 	{ "name": "m_axi_A_port_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "A_port", "role": "AWADDR" }} , 
 	{ "name": "m_axi_A_port_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "AWID" }} , 
 	{ "name": "m_axi_A_port_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "A_port", "role": "AWLEN" }} , 
 	{ "name": "m_axi_A_port_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "A_port", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_A_port_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "A_port", "role": "AWBURST" }} , 
 	{ "name": "m_axi_A_port_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "A_port", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_A_port_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_A_port_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "A_port", "role": "AWPROT" }} , 
 	{ "name": "m_axi_A_port_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "AWQOS" }} , 
 	{ "name": "m_axi_A_port_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "AWREGION" }} , 
 	{ "name": "m_axi_A_port_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "AWUSER" }} , 
 	{ "name": "m_axi_A_port_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "WVALID" }} , 
 	{ "name": "m_axi_A_port_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "WREADY" }} , 
 	{ "name": "m_axi_A_port_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_port", "role": "WDATA" }} , 
 	{ "name": "m_axi_A_port_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "WSTRB" }} , 
 	{ "name": "m_axi_A_port_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "WLAST" }} , 
 	{ "name": "m_axi_A_port_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "WID" }} , 
 	{ "name": "m_axi_A_port_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "WUSER" }} , 
 	{ "name": "m_axi_A_port_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "ARVALID" }} , 
 	{ "name": "m_axi_A_port_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "ARREADY" }} , 
 	{ "name": "m_axi_A_port_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "A_port", "role": "ARADDR" }} , 
 	{ "name": "m_axi_A_port_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "ARID" }} , 
 	{ "name": "m_axi_A_port_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "A_port", "role": "ARLEN" }} , 
 	{ "name": "m_axi_A_port_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "A_port", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_A_port_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "A_port", "role": "ARBURST" }} , 
 	{ "name": "m_axi_A_port_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "A_port", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_A_port_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_A_port_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "A_port", "role": "ARPROT" }} , 
 	{ "name": "m_axi_A_port_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "ARQOS" }} , 
 	{ "name": "m_axi_A_port_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_port", "role": "ARREGION" }} , 
 	{ "name": "m_axi_A_port_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "ARUSER" }} , 
 	{ "name": "m_axi_A_port_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "RVALID" }} , 
 	{ "name": "m_axi_A_port_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "RREADY" }} , 
 	{ "name": "m_axi_A_port_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_port", "role": "RDATA" }} , 
 	{ "name": "m_axi_A_port_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "RLAST" }} , 
 	{ "name": "m_axi_A_port_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "RID" }} , 
 	{ "name": "m_axi_A_port_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "RUSER" }} , 
 	{ "name": "m_axi_A_port_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "A_port", "role": "RRESP" }} , 
 	{ "name": "m_axi_A_port_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "BVALID" }} , 
 	{ "name": "m_axi_A_port_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "BREADY" }} , 
 	{ "name": "m_axi_A_port_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "A_port", "role": "BRESP" }} , 
 	{ "name": "m_axi_A_port_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "BID" }} , 
 	{ "name": "m_axi_A_port_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "A_port", "role": "BUSER" }} , 
 	{ "name": "m_axi_b_port_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "AWVALID" }} , 
 	{ "name": "m_axi_b_port_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "AWREADY" }} , 
 	{ "name": "m_axi_b_port_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "b_port", "role": "AWADDR" }} , 
 	{ "name": "m_axi_b_port_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "AWID" }} , 
 	{ "name": "m_axi_b_port_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "b_port", "role": "AWLEN" }} , 
 	{ "name": "m_axi_b_port_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "b_port", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_b_port_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_port", "role": "AWBURST" }} , 
 	{ "name": "m_axi_b_port_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_port", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_b_port_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_b_port_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "b_port", "role": "AWPROT" }} , 
 	{ "name": "m_axi_b_port_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "AWQOS" }} , 
 	{ "name": "m_axi_b_port_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "AWREGION" }} , 
 	{ "name": "m_axi_b_port_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "AWUSER" }} , 
 	{ "name": "m_axi_b_port_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "WVALID" }} , 
 	{ "name": "m_axi_b_port_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "WREADY" }} , 
 	{ "name": "m_axi_b_port_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_port", "role": "WDATA" }} , 
 	{ "name": "m_axi_b_port_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "WSTRB" }} , 
 	{ "name": "m_axi_b_port_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "WLAST" }} , 
 	{ "name": "m_axi_b_port_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "WID" }} , 
 	{ "name": "m_axi_b_port_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "WUSER" }} , 
 	{ "name": "m_axi_b_port_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "ARVALID" }} , 
 	{ "name": "m_axi_b_port_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "ARREADY" }} , 
 	{ "name": "m_axi_b_port_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "b_port", "role": "ARADDR" }} , 
 	{ "name": "m_axi_b_port_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "ARID" }} , 
 	{ "name": "m_axi_b_port_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "b_port", "role": "ARLEN" }} , 
 	{ "name": "m_axi_b_port_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "b_port", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_b_port_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_port", "role": "ARBURST" }} , 
 	{ "name": "m_axi_b_port_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_port", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_b_port_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_b_port_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "b_port", "role": "ARPROT" }} , 
 	{ "name": "m_axi_b_port_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "ARQOS" }} , 
 	{ "name": "m_axi_b_port_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "b_port", "role": "ARREGION" }} , 
 	{ "name": "m_axi_b_port_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "ARUSER" }} , 
 	{ "name": "m_axi_b_port_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "RVALID" }} , 
 	{ "name": "m_axi_b_port_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "RREADY" }} , 
 	{ "name": "m_axi_b_port_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "b_port", "role": "RDATA" }} , 
 	{ "name": "m_axi_b_port_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "RLAST" }} , 
 	{ "name": "m_axi_b_port_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "RID" }} , 
 	{ "name": "m_axi_b_port_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "RUSER" }} , 
 	{ "name": "m_axi_b_port_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_port", "role": "RRESP" }} , 
 	{ "name": "m_axi_b_port_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "BVALID" }} , 
 	{ "name": "m_axi_b_port_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "BREADY" }} , 
 	{ "name": "m_axi_b_port_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "b_port", "role": "BRESP" }} , 
 	{ "name": "m_axi_b_port_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "BID" }} , 
 	{ "name": "m_axi_b_port_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "b_port", "role": "BUSER" }} , 
 	{ "name": "m_axi_c_port_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "AWVALID" }} , 
 	{ "name": "m_axi_c_port_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "AWREADY" }} , 
 	{ "name": "m_axi_c_port_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "c_port", "role": "AWADDR" }} , 
 	{ "name": "m_axi_c_port_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "AWID" }} , 
 	{ "name": "m_axi_c_port_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "c_port", "role": "AWLEN" }} , 
 	{ "name": "m_axi_c_port_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "c_port", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_c_port_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_port", "role": "AWBURST" }} , 
 	{ "name": "m_axi_c_port_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_port", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_c_port_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_c_port_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "c_port", "role": "AWPROT" }} , 
 	{ "name": "m_axi_c_port_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "AWQOS" }} , 
 	{ "name": "m_axi_c_port_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "AWREGION" }} , 
 	{ "name": "m_axi_c_port_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "AWUSER" }} , 
 	{ "name": "m_axi_c_port_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "WVALID" }} , 
 	{ "name": "m_axi_c_port_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "WREADY" }} , 
 	{ "name": "m_axi_c_port_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_port", "role": "WDATA" }} , 
 	{ "name": "m_axi_c_port_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "WSTRB" }} , 
 	{ "name": "m_axi_c_port_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "WLAST" }} , 
 	{ "name": "m_axi_c_port_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "WID" }} , 
 	{ "name": "m_axi_c_port_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "WUSER" }} , 
 	{ "name": "m_axi_c_port_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "ARVALID" }} , 
 	{ "name": "m_axi_c_port_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "ARREADY" }} , 
 	{ "name": "m_axi_c_port_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "c_port", "role": "ARADDR" }} , 
 	{ "name": "m_axi_c_port_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "ARID" }} , 
 	{ "name": "m_axi_c_port_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "c_port", "role": "ARLEN" }} , 
 	{ "name": "m_axi_c_port_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "c_port", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_c_port_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_port", "role": "ARBURST" }} , 
 	{ "name": "m_axi_c_port_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_port", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_c_port_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_c_port_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "c_port", "role": "ARPROT" }} , 
 	{ "name": "m_axi_c_port_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "ARQOS" }} , 
 	{ "name": "m_axi_c_port_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "c_port", "role": "ARREGION" }} , 
 	{ "name": "m_axi_c_port_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "ARUSER" }} , 
 	{ "name": "m_axi_c_port_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "RVALID" }} , 
 	{ "name": "m_axi_c_port_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "RREADY" }} , 
 	{ "name": "m_axi_c_port_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "c_port", "role": "RDATA" }} , 
 	{ "name": "m_axi_c_port_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "RLAST" }} , 
 	{ "name": "m_axi_c_port_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "RID" }} , 
 	{ "name": "m_axi_c_port_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "RUSER" }} , 
 	{ "name": "m_axi_c_port_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_port", "role": "RRESP" }} , 
 	{ "name": "m_axi_c_port_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "BVALID" }} , 
 	{ "name": "m_axi_c_port_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "BREADY" }} , 
 	{ "name": "m_axi_c_port_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "c_port", "role": "BRESP" }} , 
 	{ "name": "m_axi_c_port_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "BID" }} , 
 	{ "name": "m_axi_c_port_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "c_port", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "19", "21", "27", "28", "29", "30", "31", "32"],
		"CDFG" : "mv",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "24", "EstimateLatencyMax" : "1057300",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "A_port", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "A_port_blk_n_AR", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "19", "SubInstance" : "grp_mv_Pipeline_col_loop_fu_264", "Port" : "A_port", "Inst_start_state" : "13", "Inst_end_state" : "14"}]},
			{"Name" : "b_port", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "b_port_blk_n_AR", "Type" : "RtlSignal"}],
				"SubConnect" : [
					{"ID" : "17", "SubInstance" : "grp_mv_Pipeline_x_buff_fu_248", "Port" : "b_port", "Inst_start_state" : "11", "Inst_end_state" : "12"}]},
			{"Name" : "c_port", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "c_port_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "c_port_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "c_port_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "A", "Type" : "None", "Direction" : "I"},
			{"Name" : "x", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "rows", "Type" : "None", "Direction" : "I"},
			{"Name" : "columns", "Type" : "None", "Direction" : "I"}],
		"Loop" : [
			{"Name" : "row_loop", "PipelineType" : "no",
				"LoopDec" : {"FSMBitwidth" : "23", "FirstState" : "ap_ST_fsm_state13", "LastState" : ["ap_ST_fsm_state18"], "QuitState" : ["ap_ST_fsm_state13"], "PreState" : ["ap_ST_fsm_state12"], "PostState" : ["ap_ST_fsm_state19"], "OneDepthLoop" : "0", "OneStateBlock": ""}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_1_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_2_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_3_U", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_4_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_5_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_6_U", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.x_buf_7_U", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_U", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_1_U", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_2_U", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_3_U", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_4_U", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_5_U", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_6_U", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.row_buf_7_U", "Parent" : "0"},
	{"ID" : "17", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_x_buff_fu_248", "Parent" : "0", "Child" : ["18"],
		"CDFG" : "mv_Pipeline_x_buff",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "4", "EstimateLatencyMax" : "515",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "b_port", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "b_port_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "columns", "Type" : "None", "Direction" : "I"},
			{"Name" : "sext_ln18", "Type" : "None", "Direction" : "I"},
			{"Name" : "x_buf_7", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf_6", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf_5", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf_4", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf_3", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf_2", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf_1", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "x_buf", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "x_buff", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "18", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_x_buff_fu_248.flow_control_loop_pipe_sequential_init_U", "Parent" : "17"},
	{"ID" : "19", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_col_loop_fu_264", "Parent" : "0", "Child" : ["20"],
		"CDFG" : "mv_Pipeline_col_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "4", "EstimateLatencyMax" : "515",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "A_port", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "A_port_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "columns", "Type" : "None", "Direction" : "I"},
			{"Name" : "sext_ln26", "Type" : "None", "Direction" : "I"},
			{"Name" : "row_buf_7", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf_6", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf_5", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf_4", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf_3", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf_2", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf_1", "Type" : "Memory", "Direction" : "O"},
			{"Name" : "row_buf", "Type" : "Memory", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "col_loop", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter2", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter2", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "20", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_col_loop_fu_264.flow_control_loop_pipe_sequential_init_U", "Parent" : "19"},
	{"ID" : "21", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_mac_loop_fu_280", "Parent" : "0", "Child" : ["22", "23", "24", "25", "26"],
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
	{"ID" : "22", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_mac_loop_fu_280.fadd_32ns_32ns_32_4_full_dsp_1_U23", "Parent" : "21"},
	{"ID" : "23", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_mac_loop_fu_280.fmul_32ns_32ns_32_3_max_dsp_1_U24", "Parent" : "21"},
	{"ID" : "24", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_mac_loop_fu_280.sparsemux_17_3_32_1_1_U25", "Parent" : "21"},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_mac_loop_fu_280.sparsemux_17_3_32_1_1_U26", "Parent" : "21"},
	{"ID" : "26", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_mv_Pipeline_mac_loop_fu_280.flow_control_loop_pipe_sequential_init_U", "Parent" : "21"},
	{"ID" : "27", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "28", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_bus_s_axi_U", "Parent" : "0"},
	{"ID" : "29", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.A_port_m_axi_U", "Parent" : "0"},
	{"ID" : "30", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.b_port_m_axi_U", "Parent" : "0"},
	{"ID" : "31", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.c_port_m_axi_U", "Parent" : "0"},
	{"ID" : "32", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32ns_32ns_63_1_1_U48", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	mv {
		A_port {Type I LastRead 2 FirstWrite -1}
		b_port {Type I LastRead 2 FirstWrite -1}
		c_port {Type O LastRead 13 FirstWrite 17}
		A {Type I LastRead 0 FirstWrite -1}
		x {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		rows {Type I LastRead 0 FirstWrite -1}
		columns {Type I LastRead 0 FirstWrite -1}}
	mv_Pipeline_x_buff {
		b_port {Type I LastRead 1 FirstWrite -1}
		columns {Type I LastRead 0 FirstWrite -1}
		sext_ln18 {Type I LastRead 0 FirstWrite -1}
		x_buf_7 {Type O LastRead -1 FirstWrite 2}
		x_buf_6 {Type O LastRead -1 FirstWrite 2}
		x_buf_5 {Type O LastRead -1 FirstWrite 2}
		x_buf_4 {Type O LastRead -1 FirstWrite 2}
		x_buf_3 {Type O LastRead -1 FirstWrite 2}
		x_buf_2 {Type O LastRead -1 FirstWrite 2}
		x_buf_1 {Type O LastRead -1 FirstWrite 2}
		x_buf {Type O LastRead -1 FirstWrite 2}}
	mv_Pipeline_col_loop {
		A_port {Type I LastRead 1 FirstWrite -1}
		columns {Type I LastRead 0 FirstWrite -1}
		sext_ln26 {Type I LastRead 0 FirstWrite -1}
		row_buf_7 {Type O LastRead -1 FirstWrite 2}
		row_buf_6 {Type O LastRead -1 FirstWrite 2}
		row_buf_5 {Type O LastRead -1 FirstWrite 2}
		row_buf_4 {Type O LastRead -1 FirstWrite 2}
		row_buf_3 {Type O LastRead -1 FirstWrite 2}
		row_buf_2 {Type O LastRead -1 FirstWrite 2}
		row_buf_1 {Type O LastRead -1 FirstWrite 2}
		row_buf {Type O LastRead -1 FirstWrite 2}}
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
	{"Name" : "Latency", "Min" : "24", "Max" : "1057300"}
	, {"Name" : "Interval", "Min" : "25", "Max" : "1057301"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	A_port { m_axi {  { m_axi_A_port_AWVALID VALID 1 1 }  { m_axi_A_port_AWREADY READY 0 1 }  { m_axi_A_port_AWADDR ADDR 1 64 }  { m_axi_A_port_AWID ID 1 1 }  { m_axi_A_port_AWLEN SIZE 1 8 }  { m_axi_A_port_AWSIZE BURST 1 3 }  { m_axi_A_port_AWBURST LOCK 1 2 }  { m_axi_A_port_AWLOCK CACHE 1 2 }  { m_axi_A_port_AWCACHE PROT 1 4 }  { m_axi_A_port_AWPROT QOS 1 3 }  { m_axi_A_port_AWQOS REGION 1 4 }  { m_axi_A_port_AWREGION USER 1 4 }  { m_axi_A_port_AWUSER DATA 1 1 }  { m_axi_A_port_WVALID VALID 1 1 }  { m_axi_A_port_WREADY READY 0 1 }  { m_axi_A_port_WDATA FIFONUM 1 32 }  { m_axi_A_port_WSTRB STRB 1 4 }  { m_axi_A_port_WLAST LAST 1 1 }  { m_axi_A_port_WID ID 1 1 }  { m_axi_A_port_WUSER DATA 1 1 }  { m_axi_A_port_ARVALID VALID 1 1 }  { m_axi_A_port_ARREADY READY 0 1 }  { m_axi_A_port_ARADDR ADDR 1 64 }  { m_axi_A_port_ARID ID 1 1 }  { m_axi_A_port_ARLEN SIZE 1 8 }  { m_axi_A_port_ARSIZE BURST 1 3 }  { m_axi_A_port_ARBURST LOCK 1 2 }  { m_axi_A_port_ARLOCK CACHE 1 2 }  { m_axi_A_port_ARCACHE PROT 1 4 }  { m_axi_A_port_ARPROT QOS 1 3 }  { m_axi_A_port_ARQOS REGION 1 4 }  { m_axi_A_port_ARREGION USER 1 4 }  { m_axi_A_port_ARUSER DATA 1 1 }  { m_axi_A_port_RVALID VALID 0 1 }  { m_axi_A_port_RREADY READY 1 1 }  { m_axi_A_port_RDATA FIFONUM 0 32 }  { m_axi_A_port_RLAST LAST 0 1 }  { m_axi_A_port_RID ID 0 1 }  { m_axi_A_port_RUSER DATA 0 1 }  { m_axi_A_port_RRESP RESP 0 2 }  { m_axi_A_port_BVALID VALID 0 1 }  { m_axi_A_port_BREADY READY 1 1 }  { m_axi_A_port_BRESP RESP 0 2 }  { m_axi_A_port_BID ID 0 1 }  { m_axi_A_port_BUSER DATA 0 1 } } }
	b_port { m_axi {  { m_axi_b_port_AWVALID VALID 1 1 }  { m_axi_b_port_AWREADY READY 0 1 }  { m_axi_b_port_AWADDR ADDR 1 64 }  { m_axi_b_port_AWID ID 1 1 }  { m_axi_b_port_AWLEN SIZE 1 8 }  { m_axi_b_port_AWSIZE BURST 1 3 }  { m_axi_b_port_AWBURST LOCK 1 2 }  { m_axi_b_port_AWLOCK CACHE 1 2 }  { m_axi_b_port_AWCACHE PROT 1 4 }  { m_axi_b_port_AWPROT QOS 1 3 }  { m_axi_b_port_AWQOS REGION 1 4 }  { m_axi_b_port_AWREGION USER 1 4 }  { m_axi_b_port_AWUSER DATA 1 1 }  { m_axi_b_port_WVALID VALID 1 1 }  { m_axi_b_port_WREADY READY 0 1 }  { m_axi_b_port_WDATA FIFONUM 1 32 }  { m_axi_b_port_WSTRB STRB 1 4 }  { m_axi_b_port_WLAST LAST 1 1 }  { m_axi_b_port_WID ID 1 1 }  { m_axi_b_port_WUSER DATA 1 1 }  { m_axi_b_port_ARVALID VALID 1 1 }  { m_axi_b_port_ARREADY READY 0 1 }  { m_axi_b_port_ARADDR ADDR 1 64 }  { m_axi_b_port_ARID ID 1 1 }  { m_axi_b_port_ARLEN SIZE 1 8 }  { m_axi_b_port_ARSIZE BURST 1 3 }  { m_axi_b_port_ARBURST LOCK 1 2 }  { m_axi_b_port_ARLOCK CACHE 1 2 }  { m_axi_b_port_ARCACHE PROT 1 4 }  { m_axi_b_port_ARPROT QOS 1 3 }  { m_axi_b_port_ARQOS REGION 1 4 }  { m_axi_b_port_ARREGION USER 1 4 }  { m_axi_b_port_ARUSER DATA 1 1 }  { m_axi_b_port_RVALID VALID 0 1 }  { m_axi_b_port_RREADY READY 1 1 }  { m_axi_b_port_RDATA FIFONUM 0 32 }  { m_axi_b_port_RLAST LAST 0 1 }  { m_axi_b_port_RID ID 0 1 }  { m_axi_b_port_RUSER DATA 0 1 }  { m_axi_b_port_RRESP RESP 0 2 }  { m_axi_b_port_BVALID VALID 0 1 }  { m_axi_b_port_BREADY READY 1 1 }  { m_axi_b_port_BRESP RESP 0 2 }  { m_axi_b_port_BID ID 0 1 }  { m_axi_b_port_BUSER DATA 0 1 } } }
	c_port { m_axi {  { m_axi_c_port_AWVALID VALID 1 1 }  { m_axi_c_port_AWREADY READY 0 1 }  { m_axi_c_port_AWADDR ADDR 1 64 }  { m_axi_c_port_AWID ID 1 1 }  { m_axi_c_port_AWLEN SIZE 1 8 }  { m_axi_c_port_AWSIZE BURST 1 3 }  { m_axi_c_port_AWBURST LOCK 1 2 }  { m_axi_c_port_AWLOCK CACHE 1 2 }  { m_axi_c_port_AWCACHE PROT 1 4 }  { m_axi_c_port_AWPROT QOS 1 3 }  { m_axi_c_port_AWQOS REGION 1 4 }  { m_axi_c_port_AWREGION USER 1 4 }  { m_axi_c_port_AWUSER DATA 1 1 }  { m_axi_c_port_WVALID VALID 1 1 }  { m_axi_c_port_WREADY READY 0 1 }  { m_axi_c_port_WDATA FIFONUM 1 32 }  { m_axi_c_port_WSTRB STRB 1 4 }  { m_axi_c_port_WLAST LAST 1 1 }  { m_axi_c_port_WID ID 1 1 }  { m_axi_c_port_WUSER DATA 1 1 }  { m_axi_c_port_ARVALID VALID 1 1 }  { m_axi_c_port_ARREADY READY 0 1 }  { m_axi_c_port_ARADDR ADDR 1 64 }  { m_axi_c_port_ARID ID 1 1 }  { m_axi_c_port_ARLEN SIZE 1 8 }  { m_axi_c_port_ARSIZE BURST 1 3 }  { m_axi_c_port_ARBURST LOCK 1 2 }  { m_axi_c_port_ARLOCK CACHE 1 2 }  { m_axi_c_port_ARCACHE PROT 1 4 }  { m_axi_c_port_ARPROT QOS 1 3 }  { m_axi_c_port_ARQOS REGION 1 4 }  { m_axi_c_port_ARREGION USER 1 4 }  { m_axi_c_port_ARUSER DATA 1 1 }  { m_axi_c_port_RVALID VALID 0 1 }  { m_axi_c_port_RREADY READY 1 1 }  { m_axi_c_port_RDATA FIFONUM 0 32 }  { m_axi_c_port_RLAST LAST 0 1 }  { m_axi_c_port_RID ID 0 1 }  { m_axi_c_port_RUSER DATA 0 1 }  { m_axi_c_port_RRESP RESP 0 2 }  { m_axi_c_port_BVALID VALID 0 1 }  { m_axi_c_port_BREADY READY 1 1 }  { m_axi_c_port_BRESP RESP 0 2 }  { m_axi_c_port_BID ID 0 1 }  { m_axi_c_port_BUSER DATA 0 1 } } }
}

set maxi_interface_dict [dict create]
dict set maxi_interface_dict A_port { CHANNEL_NUM 0 BUNDLE A_port NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict b_port { CHANNEL_NUM 0 BUNDLE b_port NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE READ_ONLY}
dict set maxi_interface_dict c_port { CHANNEL_NUM 0 BUNDLE c_port NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 READ_WRITE_MODE WRITE_ONLY}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ A_port 1 }
	{ b_port 1 }
	{ c_port 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ A_port 1 }
	{ b_port 1 }
	{ c_port 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
