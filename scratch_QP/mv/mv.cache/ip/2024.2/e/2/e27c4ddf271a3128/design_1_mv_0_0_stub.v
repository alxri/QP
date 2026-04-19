// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Wed Apr  8 11:14:32 2026
// Host        : eslpc53 running 64-bit Ubuntu 20.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_mv_0_0_stub.v
// Design      : design_1_mv_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_mv_0_0,mv,{}" *) (* CORE_GENERATION_INFO = "design_1_mv_0_0,mv,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=mv,x_ipVersion=1.0,x_ipCoreRevision=2114556464,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_S_AXI_CONTROL_ADDR_WIDTH=6,C_S_AXI_CONTROL_DATA_WIDTH=32,C_S_AXI_CONTROL_BUS_ADDR_WIDTH=5,C_S_AXI_CONTROL_BUS_DATA_WIDTH=32,C_M_AXI_A_PORT_ID_WIDTH=1,C_M_AXI_A_PORT_ADDR_WIDTH=64,C_M_AXI_A_PORT_DATA_WIDTH=32,C_M_AXI_A_PORT_AWUSER_WIDTH=1,C_M_AXI_A_PORT_ARUSER_WIDTH=1,C_M_AXI_A_PORT_WUSER_WIDTH=1,C_M_AXI_A_PORT_RUSER_WIDTH=1,C_M_AXI_A_PORT_BUSER_WIDTH=1,C_M_AXI_A_PORT_USER_VALUE=0x00000000,C_M_AXI_A_PORT_PROT_VALUE=000,C_M_AXI_A_PORT_CACHE_VALUE=0011,C_M_AXI_B_PORT_ID_WIDTH=1,C_M_AXI_B_PORT_ADDR_WIDTH=64,C_M_AXI_B_PORT_DATA_WIDTH=32,C_M_AXI_B_PORT_AWUSER_WIDTH=1,C_M_AXI_B_PORT_ARUSER_WIDTH=1,C_M_AXI_B_PORT_WUSER_WIDTH=1,C_M_AXI_B_PORT_RUSER_WIDTH=1,C_M_AXI_B_PORT_BUSER_WIDTH=1,C_M_AXI_B_PORT_USER_VALUE=0x00000000,C_M_AXI_B_PORT_PROT_VALUE=000,C_M_AXI_B_PORT_CACHE_VALUE=0011,C_M_AXI_C_PORT_ID_WIDTH=1,C_M_AXI_C_PORT_ADDR_WIDTH=64,C_M_AXI_C_PORT_DATA_WIDTH=32,C_M_AXI_C_PORT_AWUSER_WIDTH=1,C_M_AXI_C_PORT_ARUSER_WIDTH=1,C_M_AXI_C_PORT_WUSER_WIDTH=1,C_M_AXI_C_PORT_RUSER_WIDTH=1,C_M_AXI_C_PORT_BUSER_WIDTH=1,C_M_AXI_C_PORT_USER_VALUE=0x00000000,C_M_AXI_C_PORT_PROT_VALUE=000,C_M_AXI_C_PORT_CACHE_VALUE=0011}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "HLS" *) (* X_CORE_INFO = "mv,Vivado 2024.2" *) (* hls_module = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_control_ARADDR, 
  s_axi_control_ARREADY, s_axi_control_ARVALID, s_axi_control_AWADDR, 
  s_axi_control_AWREADY, s_axi_control_AWVALID, s_axi_control_BREADY, 
  s_axi_control_BRESP, s_axi_control_BVALID, s_axi_control_RDATA, s_axi_control_RREADY, 
  s_axi_control_RRESP, s_axi_control_RVALID, s_axi_control_WDATA, s_axi_control_WREADY, 
  s_axi_control_WSTRB, s_axi_control_WVALID, s_axi_control_bus_ARADDR, 
  s_axi_control_bus_ARREADY, s_axi_control_bus_ARVALID, s_axi_control_bus_AWADDR, 
  s_axi_control_bus_AWREADY, s_axi_control_bus_AWVALID, s_axi_control_bus_BREADY, 
  s_axi_control_bus_BRESP, s_axi_control_bus_BVALID, s_axi_control_bus_RDATA, 
  s_axi_control_bus_RREADY, s_axi_control_bus_RRESP, s_axi_control_bus_RVALID, 
  s_axi_control_bus_WDATA, s_axi_control_bus_WREADY, s_axi_control_bus_WSTRB, 
  s_axi_control_bus_WVALID, ap_clk, ap_rst_n, interrupt, m_axi_A_port_ARADDR, 
  m_axi_A_port_ARBURST, m_axi_A_port_ARCACHE, m_axi_A_port_ARID, m_axi_A_port_ARLEN, 
  m_axi_A_port_ARLOCK, m_axi_A_port_ARPROT, m_axi_A_port_ARQOS, m_axi_A_port_ARREADY, 
  m_axi_A_port_ARREGION, m_axi_A_port_ARSIZE, m_axi_A_port_ARVALID, m_axi_A_port_AWADDR, 
  m_axi_A_port_AWBURST, m_axi_A_port_AWCACHE, m_axi_A_port_AWID, m_axi_A_port_AWLEN, 
  m_axi_A_port_AWLOCK, m_axi_A_port_AWPROT, m_axi_A_port_AWQOS, m_axi_A_port_AWREADY, 
  m_axi_A_port_AWREGION, m_axi_A_port_AWSIZE, m_axi_A_port_AWVALID, m_axi_A_port_BID, 
  m_axi_A_port_BREADY, m_axi_A_port_BRESP, m_axi_A_port_BVALID, m_axi_A_port_RDATA, 
  m_axi_A_port_RID, m_axi_A_port_RLAST, m_axi_A_port_RREADY, m_axi_A_port_RRESP, 
  m_axi_A_port_RVALID, m_axi_A_port_WDATA, m_axi_A_port_WID, m_axi_A_port_WLAST, 
  m_axi_A_port_WREADY, m_axi_A_port_WSTRB, m_axi_A_port_WVALID, m_axi_b_port_ARADDR, 
  m_axi_b_port_ARBURST, m_axi_b_port_ARCACHE, m_axi_b_port_ARID, m_axi_b_port_ARLEN, 
  m_axi_b_port_ARLOCK, m_axi_b_port_ARPROT, m_axi_b_port_ARQOS, m_axi_b_port_ARREADY, 
  m_axi_b_port_ARREGION, m_axi_b_port_ARSIZE, m_axi_b_port_ARVALID, m_axi_b_port_AWADDR, 
  m_axi_b_port_AWBURST, m_axi_b_port_AWCACHE, m_axi_b_port_AWID, m_axi_b_port_AWLEN, 
  m_axi_b_port_AWLOCK, m_axi_b_port_AWPROT, m_axi_b_port_AWQOS, m_axi_b_port_AWREADY, 
  m_axi_b_port_AWREGION, m_axi_b_port_AWSIZE, m_axi_b_port_AWVALID, m_axi_b_port_BID, 
  m_axi_b_port_BREADY, m_axi_b_port_BRESP, m_axi_b_port_BVALID, m_axi_b_port_RDATA, 
  m_axi_b_port_RID, m_axi_b_port_RLAST, m_axi_b_port_RREADY, m_axi_b_port_RRESP, 
  m_axi_b_port_RVALID, m_axi_b_port_WDATA, m_axi_b_port_WID, m_axi_b_port_WLAST, 
  m_axi_b_port_WREADY, m_axi_b_port_WSTRB, m_axi_b_port_WVALID, m_axi_c_port_ARADDR, 
  m_axi_c_port_ARBURST, m_axi_c_port_ARCACHE, m_axi_c_port_ARID, m_axi_c_port_ARLEN, 
  m_axi_c_port_ARLOCK, m_axi_c_port_ARPROT, m_axi_c_port_ARQOS, m_axi_c_port_ARREADY, 
  m_axi_c_port_ARREGION, m_axi_c_port_ARSIZE, m_axi_c_port_ARVALID, m_axi_c_port_AWADDR, 
  m_axi_c_port_AWBURST, m_axi_c_port_AWCACHE, m_axi_c_port_AWID, m_axi_c_port_AWLEN, 
  m_axi_c_port_AWLOCK, m_axi_c_port_AWPROT, m_axi_c_port_AWQOS, m_axi_c_port_AWREADY, 
  m_axi_c_port_AWREGION, m_axi_c_port_AWSIZE, m_axi_c_port_AWVALID, m_axi_c_port_BID, 
  m_axi_c_port_BREADY, m_axi_c_port_BRESP, m_axi_c_port_BVALID, m_axi_c_port_RDATA, 
  m_axi_c_port_RID, m_axi_c_port_RLAST, m_axi_c_port_RREADY, m_axi_c_port_RRESP, 
  m_axi_c_port_RVALID, m_axi_c_port_WDATA, m_axi_c_port_WID, m_axi_c_port_WLAST, 
  m_axi_c_port_WREADY, m_axi_c_port_WSTRB, m_axi_c_port_WVALID)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_ARADDR[5:0],s_axi_control_ARREADY,s_axi_control_ARVALID,s_axi_control_AWADDR[5:0],s_axi_control_AWREADY,s_axi_control_AWVALID,s_axi_control_BREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_RDATA[31:0],s_axi_control_RREADY,s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_WDATA[31:0],s_axi_control_WREADY,s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_bus_ARADDR[4:0],s_axi_control_bus_ARREADY,s_axi_control_bus_ARVALID,s_axi_control_bus_AWADDR[4:0],s_axi_control_bus_AWREADY,s_axi_control_bus_AWVALID,s_axi_control_bus_BREADY,s_axi_control_bus_BRESP[1:0],s_axi_control_bus_BVALID,s_axi_control_bus_RDATA[31:0],s_axi_control_bus_RREADY,s_axi_control_bus_RRESP[1:0],s_axi_control_bus_RVALID,s_axi_control_bus_WDATA[31:0],s_axi_control_bus_WREADY,s_axi_control_bus_WSTRB[3:0],s_axi_control_bus_WVALID,ap_rst_n,interrupt,m_axi_A_port_ARADDR[63:0],m_axi_A_port_ARBURST[1:0],m_axi_A_port_ARCACHE[3:0],m_axi_A_port_ARID[0:0],m_axi_A_port_ARLEN[7:0],m_axi_A_port_ARLOCK[1:0],m_axi_A_port_ARPROT[2:0],m_axi_A_port_ARQOS[3:0],m_axi_A_port_ARREADY,m_axi_A_port_ARREGION[3:0],m_axi_A_port_ARSIZE[2:0],m_axi_A_port_ARVALID,m_axi_A_port_AWADDR[63:0],m_axi_A_port_AWBURST[1:0],m_axi_A_port_AWCACHE[3:0],m_axi_A_port_AWID[0:0],m_axi_A_port_AWLEN[7:0],m_axi_A_port_AWLOCK[1:0],m_axi_A_port_AWPROT[2:0],m_axi_A_port_AWQOS[3:0],m_axi_A_port_AWREADY,m_axi_A_port_AWREGION[3:0],m_axi_A_port_AWSIZE[2:0],m_axi_A_port_AWVALID,m_axi_A_port_BID[0:0],m_axi_A_port_BREADY,m_axi_A_port_BRESP[1:0],m_axi_A_port_BVALID,m_axi_A_port_RDATA[31:0],m_axi_A_port_RID[0:0],m_axi_A_port_RLAST,m_axi_A_port_RREADY,m_axi_A_port_RRESP[1:0],m_axi_A_port_RVALID,m_axi_A_port_WDATA[31:0],m_axi_A_port_WID[0:0],m_axi_A_port_WLAST,m_axi_A_port_WREADY,m_axi_A_port_WSTRB[3:0],m_axi_A_port_WVALID,m_axi_b_port_ARADDR[63:0],m_axi_b_port_ARBURST[1:0],m_axi_b_port_ARCACHE[3:0],m_axi_b_port_ARID[0:0],m_axi_b_port_ARLEN[7:0],m_axi_b_port_ARLOCK[1:0],m_axi_b_port_ARPROT[2:0],m_axi_b_port_ARQOS[3:0],m_axi_b_port_ARREADY,m_axi_b_port_ARREGION[3:0],m_axi_b_port_ARSIZE[2:0],m_axi_b_port_ARVALID,m_axi_b_port_AWADDR[63:0],m_axi_b_port_AWBURST[1:0],m_axi_b_port_AWCACHE[3:0],m_axi_b_port_AWID[0:0],m_axi_b_port_AWLEN[7:0],m_axi_b_port_AWLOCK[1:0],m_axi_b_port_AWPROT[2:0],m_axi_b_port_AWQOS[3:0],m_axi_b_port_AWREADY,m_axi_b_port_AWREGION[3:0],m_axi_b_port_AWSIZE[2:0],m_axi_b_port_AWVALID,m_axi_b_port_BID[0:0],m_axi_b_port_BREADY,m_axi_b_port_BRESP[1:0],m_axi_b_port_BVALID,m_axi_b_port_RDATA[31:0],m_axi_b_port_RID[0:0],m_axi_b_port_RLAST,m_axi_b_port_RREADY,m_axi_b_port_RRESP[1:0],m_axi_b_port_RVALID,m_axi_b_port_WDATA[31:0],m_axi_b_port_WID[0:0],m_axi_b_port_WLAST,m_axi_b_port_WREADY,m_axi_b_port_WSTRB[3:0],m_axi_b_port_WVALID,m_axi_c_port_ARADDR[63:0],m_axi_c_port_ARBURST[1:0],m_axi_c_port_ARCACHE[3:0],m_axi_c_port_ARID[0:0],m_axi_c_port_ARLEN[7:0],m_axi_c_port_ARLOCK[1:0],m_axi_c_port_ARPROT[2:0],m_axi_c_port_ARQOS[3:0],m_axi_c_port_ARREADY,m_axi_c_port_ARREGION[3:0],m_axi_c_port_ARSIZE[2:0],m_axi_c_port_ARVALID,m_axi_c_port_AWADDR[63:0],m_axi_c_port_AWBURST[1:0],m_axi_c_port_AWCACHE[3:0],m_axi_c_port_AWID[0:0],m_axi_c_port_AWLEN[7:0],m_axi_c_port_AWLOCK[1:0],m_axi_c_port_AWPROT[2:0],m_axi_c_port_AWQOS[3:0],m_axi_c_port_AWREADY,m_axi_c_port_AWREGION[3:0],m_axi_c_port_AWSIZE[2:0],m_axi_c_port_AWVALID,m_axi_c_port_BID[0:0],m_axi_c_port_BREADY,m_axi_c_port_BRESP[1:0],m_axi_c_port_BVALID,m_axi_c_port_RDATA[31:0],m_axi_c_port_RID[0:0],m_axi_c_port_RLAST,m_axi_c_port_RREADY,m_axi_c_port_RRESP[1:0],m_axi_c_port_RVALID,m_axi_c_port_WDATA[31:0],m_axi_c_port_WID[0:0],m_axi_c_port_WLAST,m_axi_c_port_WREADY,m_axi_c_port_WSTRB[3:0],m_axi_c_port_WVALID" */
/* synthesis syn_force_seq_prim="ap_clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [5:0]s_axi_control_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY" *) output s_axi_control_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID" *) input s_axi_control_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR" *) input [5:0]s_axi_control_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY" *) output s_axi_control_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID" *) input s_axi_control_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BREADY" *) input s_axi_control_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BRESP" *) output [1:0]s_axi_control_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BVALID" *) output s_axi_control_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RDATA" *) output [31:0]s_axi_control_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RREADY" *) input s_axi_control_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RRESP" *) output [1:0]s_axi_control_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RVALID" *) output s_axi_control_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WDATA" *) input [31:0]s_axi_control_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WREADY" *) output s_axi_control_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB" *) input [3:0]s_axi_control_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WVALID" *) input s_axi_control_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus ARADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control_bus, ADDR_WIDTH 5, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [4:0]s_axi_control_bus_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus ARREADY" *) output s_axi_control_bus_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus ARVALID" *) input s_axi_control_bus_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus AWADDR" *) input [4:0]s_axi_control_bus_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus AWREADY" *) output s_axi_control_bus_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus AWVALID" *) input s_axi_control_bus_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus BREADY" *) input s_axi_control_bus_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus BRESP" *) output [1:0]s_axi_control_bus_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus BVALID" *) output s_axi_control_bus_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus RDATA" *) output [31:0]s_axi_control_bus_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus RREADY" *) input s_axi_control_bus_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus RRESP" *) output [1:0]s_axi_control_bus_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus RVALID" *) output s_axi_control_bus_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus WDATA" *) input [31:0]s_axi_control_bus_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus WREADY" *) output s_axi_control_bus_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus WSTRB" *) input [3:0]s_axi_control_bus_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control_bus WVALID" *) input s_axi_control_bus_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:s_axi_control_bus:m_axi_A_port:m_axi_b_port:m_axi_c_port, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *) input ap_clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output interrupt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_A_port, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_A_port_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARBURST" *) output [1:0]m_axi_A_port_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARCACHE" *) output [3:0]m_axi_A_port_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARID" *) output [0:0]m_axi_A_port_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARLEN" *) output [7:0]m_axi_A_port_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARLOCK" *) output [1:0]m_axi_A_port_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARPROT" *) output [2:0]m_axi_A_port_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARQOS" *) output [3:0]m_axi_A_port_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARREADY" *) input m_axi_A_port_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARREGION" *) output [3:0]m_axi_A_port_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARSIZE" *) output [2:0]m_axi_A_port_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port ARVALID" *) output m_axi_A_port_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWADDR" *) output [63:0]m_axi_A_port_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWBURST" *) output [1:0]m_axi_A_port_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWCACHE" *) output [3:0]m_axi_A_port_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWID" *) output [0:0]m_axi_A_port_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWLEN" *) output [7:0]m_axi_A_port_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWLOCK" *) output [1:0]m_axi_A_port_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWPROT" *) output [2:0]m_axi_A_port_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWQOS" *) output [3:0]m_axi_A_port_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWREADY" *) input m_axi_A_port_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWREGION" *) output [3:0]m_axi_A_port_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWSIZE" *) output [2:0]m_axi_A_port_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port AWVALID" *) output m_axi_A_port_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port BID" *) input [0:0]m_axi_A_port_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port BREADY" *) output m_axi_A_port_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port BRESP" *) input [1:0]m_axi_A_port_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port BVALID" *) input m_axi_A_port_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port RDATA" *) input [31:0]m_axi_A_port_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port RID" *) input [0:0]m_axi_A_port_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port RLAST" *) input m_axi_A_port_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port RREADY" *) output m_axi_A_port_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port RRESP" *) input [1:0]m_axi_A_port_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port RVALID" *) input m_axi_A_port_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port WDATA" *) output [31:0]m_axi_A_port_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port WID" *) output [0:0]m_axi_A_port_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port WLAST" *) output m_axi_A_port_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port WREADY" *) input m_axi_A_port_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port WSTRB" *) output [3:0]m_axi_A_port_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_A_port WVALID" *) output m_axi_A_port_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_b_port, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_b_port_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARBURST" *) output [1:0]m_axi_b_port_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARCACHE" *) output [3:0]m_axi_b_port_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARID" *) output [0:0]m_axi_b_port_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARLEN" *) output [7:0]m_axi_b_port_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARLOCK" *) output [1:0]m_axi_b_port_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARPROT" *) output [2:0]m_axi_b_port_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARQOS" *) output [3:0]m_axi_b_port_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARREADY" *) input m_axi_b_port_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARREGION" *) output [3:0]m_axi_b_port_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARSIZE" *) output [2:0]m_axi_b_port_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port ARVALID" *) output m_axi_b_port_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWADDR" *) output [63:0]m_axi_b_port_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWBURST" *) output [1:0]m_axi_b_port_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWCACHE" *) output [3:0]m_axi_b_port_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWID" *) output [0:0]m_axi_b_port_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWLEN" *) output [7:0]m_axi_b_port_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWLOCK" *) output [1:0]m_axi_b_port_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWPROT" *) output [2:0]m_axi_b_port_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWQOS" *) output [3:0]m_axi_b_port_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWREADY" *) input m_axi_b_port_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWREGION" *) output [3:0]m_axi_b_port_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWSIZE" *) output [2:0]m_axi_b_port_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port AWVALID" *) output m_axi_b_port_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port BID" *) input [0:0]m_axi_b_port_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port BREADY" *) output m_axi_b_port_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port BRESP" *) input [1:0]m_axi_b_port_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port BVALID" *) input m_axi_b_port_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port RDATA" *) input [31:0]m_axi_b_port_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port RID" *) input [0:0]m_axi_b_port_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port RLAST" *) input m_axi_b_port_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port RREADY" *) output m_axi_b_port_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port RRESP" *) input [1:0]m_axi_b_port_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port RVALID" *) input m_axi_b_port_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port WDATA" *) output [31:0]m_axi_b_port_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port WID" *) output [0:0]m_axi_b_port_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port WLAST" *) output m_axi_b_port_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port WREADY" *) input m_axi_b_port_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port WSTRB" *) output [3:0]m_axi_b_port_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_b_port WVALID" *) output m_axi_b_port_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_c_port, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE WRITE_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_c_port_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARBURST" *) output [1:0]m_axi_c_port_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARCACHE" *) output [3:0]m_axi_c_port_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARID" *) output [0:0]m_axi_c_port_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARLEN" *) output [7:0]m_axi_c_port_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARLOCK" *) output [1:0]m_axi_c_port_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARPROT" *) output [2:0]m_axi_c_port_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARQOS" *) output [3:0]m_axi_c_port_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARREADY" *) input m_axi_c_port_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARREGION" *) output [3:0]m_axi_c_port_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARSIZE" *) output [2:0]m_axi_c_port_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port ARVALID" *) output m_axi_c_port_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWADDR" *) output [63:0]m_axi_c_port_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWBURST" *) output [1:0]m_axi_c_port_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWCACHE" *) output [3:0]m_axi_c_port_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWID" *) output [0:0]m_axi_c_port_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWLEN" *) output [7:0]m_axi_c_port_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWLOCK" *) output [1:0]m_axi_c_port_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWPROT" *) output [2:0]m_axi_c_port_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWQOS" *) output [3:0]m_axi_c_port_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWREADY" *) input m_axi_c_port_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWREGION" *) output [3:0]m_axi_c_port_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWSIZE" *) output [2:0]m_axi_c_port_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port AWVALID" *) output m_axi_c_port_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port BID" *) input [0:0]m_axi_c_port_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port BREADY" *) output m_axi_c_port_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port BRESP" *) input [1:0]m_axi_c_port_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port BVALID" *) input m_axi_c_port_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port RDATA" *) input [31:0]m_axi_c_port_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port RID" *) input [0:0]m_axi_c_port_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port RLAST" *) input m_axi_c_port_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port RREADY" *) output m_axi_c_port_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port RRESP" *) input [1:0]m_axi_c_port_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port RVALID" *) input m_axi_c_port_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port WDATA" *) output [31:0]m_axi_c_port_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port WID" *) output [0:0]m_axi_c_port_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port WLAST" *) output m_axi_c_port_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port WREADY" *) input m_axi_c_port_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port WSTRB" *) output [3:0]m_axi_c_port_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_c_port WVALID" *) output m_axi_c_port_WVALID;
endmodule
