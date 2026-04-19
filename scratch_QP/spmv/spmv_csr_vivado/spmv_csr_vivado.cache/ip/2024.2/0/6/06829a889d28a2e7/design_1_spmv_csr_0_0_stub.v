// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Thu Apr  9 12:25:03 2026
// Host        : eslpc53 running 64-bit Ubuntu 20.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_spmv_csr_0_0_stub.v
// Design      : design_1_spmv_csr_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_spmv_csr_0_0,spmv_csr,{}" *) (* CORE_GENERATION_INFO = "design_1_spmv_csr_0_0,spmv_csr,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=spmv_csr,x_ipVersion=1.0,x_ipCoreRevision=2114557919,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_S_AXI_CONTROL_ADDR_WIDTH=7,C_S_AXI_CONTROL_DATA_WIDTH=32,C_M_AXI_GMEM0_ID_WIDTH=1,C_M_AXI_GMEM0_ADDR_WIDTH=64,C_M_AXI_GMEM0_DATA_WIDTH=32,C_M_AXI_GMEM0_AWUSER_WIDTH=1,C_M_AXI_GMEM0_ARUSER_WIDTH=1,C_M_AXI_GMEM0_WUSER_WIDTH=1,C_M_AXI_GMEM0_RUSER_WIDTH=1,C_M_AXI_GMEM0_BUSER_WIDTH=1,C_M_AXI_GMEM0_USER_VALUE=0x00000000,C_M_AXI_GMEM0_PROT_VALUE=000,C_M_AXI_GMEM0_CACHE_VALUE=0011,C_M_AXI_GMEM1_ID_WIDTH=1,C_M_AXI_GMEM1_ADDR_WIDTH=64,C_M_AXI_GMEM1_DATA_WIDTH=32,C_M_AXI_GMEM1_AWUSER_WIDTH=1,C_M_AXI_GMEM1_ARUSER_WIDTH=1,C_M_AXI_GMEM1_WUSER_WIDTH=1,C_M_AXI_GMEM1_RUSER_WIDTH=1,C_M_AXI_GMEM1_BUSER_WIDTH=1,C_M_AXI_GMEM1_USER_VALUE=0x00000000,C_M_AXI_GMEM1_PROT_VALUE=000,C_M_AXI_GMEM1_CACHE_VALUE=0011,C_M_AXI_GMEM2_ID_WIDTH=1,C_M_AXI_GMEM2_ADDR_WIDTH=64,C_M_AXI_GMEM2_DATA_WIDTH=32,C_M_AXI_GMEM2_AWUSER_WIDTH=1,C_M_AXI_GMEM2_ARUSER_WIDTH=1,C_M_AXI_GMEM2_WUSER_WIDTH=1,C_M_AXI_GMEM2_RUSER_WIDTH=1,C_M_AXI_GMEM2_BUSER_WIDTH=1,C_M_AXI_GMEM2_USER_VALUE=0x00000000,C_M_AXI_GMEM2_PROT_VALUE=000,C_M_AXI_GMEM2_CACHE_VALUE=0011,C_M_AXI_GMEM3_ID_WIDTH=1,C_M_AXI_GMEM3_ADDR_WIDTH=64,C_M_AXI_GMEM3_DATA_WIDTH=32,C_M_AXI_GMEM3_AWUSER_WIDTH=1,C_M_AXI_GMEM3_ARUSER_WIDTH=1,C_M_AXI_GMEM3_WUSER_WIDTH=1,C_M_AXI_GMEM3_RUSER_WIDTH=1,C_M_AXI_GMEM3_BUSER_WIDTH=1,C_M_AXI_GMEM3_USER_VALUE=0x00000000,C_M_AXI_GMEM3_PROT_VALUE=000,C_M_AXI_GMEM3_CACHE_VALUE=0011,C_M_AXI_GMEM4_ID_WIDTH=1,C_M_AXI_GMEM4_ADDR_WIDTH=64,C_M_AXI_GMEM4_DATA_WIDTH=32,C_M_AXI_GMEM4_AWUSER_WIDTH=1,C_M_AXI_GMEM4_ARUSER_WIDTH=1,C_M_AXI_GMEM4_WUSER_WIDTH=1,C_M_AXI_GMEM4_RUSER_WIDTH=1,C_M_AXI_GMEM4_BUSER_WIDTH=1,C_M_AXI_GMEM4_USER_VALUE=0x00000000,C_M_AXI_GMEM4_PROT_VALUE=000,C_M_AXI_GMEM4_CACHE_VALUE=0011}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "HLS" *) (* X_CORE_INFO = "spmv_csr,Vivado 2024.2" *) (* hls_module = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_control_ARADDR, 
  s_axi_control_ARREADY, s_axi_control_ARVALID, s_axi_control_AWADDR, 
  s_axi_control_AWREADY, s_axi_control_AWVALID, s_axi_control_BREADY, 
  s_axi_control_BRESP, s_axi_control_BVALID, s_axi_control_RDATA, s_axi_control_RREADY, 
  s_axi_control_RRESP, s_axi_control_RVALID, s_axi_control_WDATA, s_axi_control_WREADY, 
  s_axi_control_WSTRB, s_axi_control_WVALID, ap_clk, ap_rst_n, interrupt, m_axi_gmem0_ARADDR, 
  m_axi_gmem0_ARBURST, m_axi_gmem0_ARCACHE, m_axi_gmem0_ARID, m_axi_gmem0_ARLEN, 
  m_axi_gmem0_ARLOCK, m_axi_gmem0_ARPROT, m_axi_gmem0_ARQOS, m_axi_gmem0_ARREADY, 
  m_axi_gmem0_ARREGION, m_axi_gmem0_ARSIZE, m_axi_gmem0_ARVALID, m_axi_gmem0_AWADDR, 
  m_axi_gmem0_AWBURST, m_axi_gmem0_AWCACHE, m_axi_gmem0_AWID, m_axi_gmem0_AWLEN, 
  m_axi_gmem0_AWLOCK, m_axi_gmem0_AWPROT, m_axi_gmem0_AWQOS, m_axi_gmem0_AWREADY, 
  m_axi_gmem0_AWREGION, m_axi_gmem0_AWSIZE, m_axi_gmem0_AWVALID, m_axi_gmem0_BID, 
  m_axi_gmem0_BREADY, m_axi_gmem0_BRESP, m_axi_gmem0_BVALID, m_axi_gmem0_RDATA, 
  m_axi_gmem0_RID, m_axi_gmem0_RLAST, m_axi_gmem0_RREADY, m_axi_gmem0_RRESP, 
  m_axi_gmem0_RVALID, m_axi_gmem0_WDATA, m_axi_gmem0_WID, m_axi_gmem0_WLAST, 
  m_axi_gmem0_WREADY, m_axi_gmem0_WSTRB, m_axi_gmem0_WVALID, m_axi_gmem1_ARADDR, 
  m_axi_gmem1_ARBURST, m_axi_gmem1_ARCACHE, m_axi_gmem1_ARID, m_axi_gmem1_ARLEN, 
  m_axi_gmem1_ARLOCK, m_axi_gmem1_ARPROT, m_axi_gmem1_ARQOS, m_axi_gmem1_ARREADY, 
  m_axi_gmem1_ARREGION, m_axi_gmem1_ARSIZE, m_axi_gmem1_ARVALID, m_axi_gmem1_AWADDR, 
  m_axi_gmem1_AWBURST, m_axi_gmem1_AWCACHE, m_axi_gmem1_AWID, m_axi_gmem1_AWLEN, 
  m_axi_gmem1_AWLOCK, m_axi_gmem1_AWPROT, m_axi_gmem1_AWQOS, m_axi_gmem1_AWREADY, 
  m_axi_gmem1_AWREGION, m_axi_gmem1_AWSIZE, m_axi_gmem1_AWVALID, m_axi_gmem1_BID, 
  m_axi_gmem1_BREADY, m_axi_gmem1_BRESP, m_axi_gmem1_BVALID, m_axi_gmem1_RDATA, 
  m_axi_gmem1_RID, m_axi_gmem1_RLAST, m_axi_gmem1_RREADY, m_axi_gmem1_RRESP, 
  m_axi_gmem1_RVALID, m_axi_gmem1_WDATA, m_axi_gmem1_WID, m_axi_gmem1_WLAST, 
  m_axi_gmem1_WREADY, m_axi_gmem1_WSTRB, m_axi_gmem1_WVALID, m_axi_gmem2_ARADDR, 
  m_axi_gmem2_ARBURST, m_axi_gmem2_ARCACHE, m_axi_gmem2_ARID, m_axi_gmem2_ARLEN, 
  m_axi_gmem2_ARLOCK, m_axi_gmem2_ARPROT, m_axi_gmem2_ARQOS, m_axi_gmem2_ARREADY, 
  m_axi_gmem2_ARREGION, m_axi_gmem2_ARSIZE, m_axi_gmem2_ARVALID, m_axi_gmem2_AWADDR, 
  m_axi_gmem2_AWBURST, m_axi_gmem2_AWCACHE, m_axi_gmem2_AWID, m_axi_gmem2_AWLEN, 
  m_axi_gmem2_AWLOCK, m_axi_gmem2_AWPROT, m_axi_gmem2_AWQOS, m_axi_gmem2_AWREADY, 
  m_axi_gmem2_AWREGION, m_axi_gmem2_AWSIZE, m_axi_gmem2_AWVALID, m_axi_gmem2_BID, 
  m_axi_gmem2_BREADY, m_axi_gmem2_BRESP, m_axi_gmem2_BVALID, m_axi_gmem2_RDATA, 
  m_axi_gmem2_RID, m_axi_gmem2_RLAST, m_axi_gmem2_RREADY, m_axi_gmem2_RRESP, 
  m_axi_gmem2_RVALID, m_axi_gmem2_WDATA, m_axi_gmem2_WID, m_axi_gmem2_WLAST, 
  m_axi_gmem2_WREADY, m_axi_gmem2_WSTRB, m_axi_gmem2_WVALID, m_axi_gmem3_ARADDR, 
  m_axi_gmem3_ARBURST, m_axi_gmem3_ARCACHE, m_axi_gmem3_ARID, m_axi_gmem3_ARLEN, 
  m_axi_gmem3_ARLOCK, m_axi_gmem3_ARPROT, m_axi_gmem3_ARQOS, m_axi_gmem3_ARREADY, 
  m_axi_gmem3_ARREGION, m_axi_gmem3_ARSIZE, m_axi_gmem3_ARVALID, m_axi_gmem3_AWADDR, 
  m_axi_gmem3_AWBURST, m_axi_gmem3_AWCACHE, m_axi_gmem3_AWID, m_axi_gmem3_AWLEN, 
  m_axi_gmem3_AWLOCK, m_axi_gmem3_AWPROT, m_axi_gmem3_AWQOS, m_axi_gmem3_AWREADY, 
  m_axi_gmem3_AWREGION, m_axi_gmem3_AWSIZE, m_axi_gmem3_AWVALID, m_axi_gmem3_BID, 
  m_axi_gmem3_BREADY, m_axi_gmem3_BRESP, m_axi_gmem3_BVALID, m_axi_gmem3_RDATA, 
  m_axi_gmem3_RID, m_axi_gmem3_RLAST, m_axi_gmem3_RREADY, m_axi_gmem3_RRESP, 
  m_axi_gmem3_RVALID, m_axi_gmem3_WDATA, m_axi_gmem3_WID, m_axi_gmem3_WLAST, 
  m_axi_gmem3_WREADY, m_axi_gmem3_WSTRB, m_axi_gmem3_WVALID, m_axi_gmem4_ARADDR, 
  m_axi_gmem4_ARBURST, m_axi_gmem4_ARCACHE, m_axi_gmem4_ARID, m_axi_gmem4_ARLEN, 
  m_axi_gmem4_ARLOCK, m_axi_gmem4_ARPROT, m_axi_gmem4_ARQOS, m_axi_gmem4_ARREADY, 
  m_axi_gmem4_ARREGION, m_axi_gmem4_ARSIZE, m_axi_gmem4_ARVALID, m_axi_gmem4_AWADDR, 
  m_axi_gmem4_AWBURST, m_axi_gmem4_AWCACHE, m_axi_gmem4_AWID, m_axi_gmem4_AWLEN, 
  m_axi_gmem4_AWLOCK, m_axi_gmem4_AWPROT, m_axi_gmem4_AWQOS, m_axi_gmem4_AWREADY, 
  m_axi_gmem4_AWREGION, m_axi_gmem4_AWSIZE, m_axi_gmem4_AWVALID, m_axi_gmem4_BID, 
  m_axi_gmem4_BREADY, m_axi_gmem4_BRESP, m_axi_gmem4_BVALID, m_axi_gmem4_RDATA, 
  m_axi_gmem4_RID, m_axi_gmem4_RLAST, m_axi_gmem4_RREADY, m_axi_gmem4_RRESP, 
  m_axi_gmem4_RVALID, m_axi_gmem4_WDATA, m_axi_gmem4_WID, m_axi_gmem4_WLAST, 
  m_axi_gmem4_WREADY, m_axi_gmem4_WSTRB, m_axi_gmem4_WVALID)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_ARADDR[6:0],s_axi_control_ARREADY,s_axi_control_ARVALID,s_axi_control_AWADDR[6:0],s_axi_control_AWREADY,s_axi_control_AWVALID,s_axi_control_BREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_RDATA[31:0],s_axi_control_RREADY,s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_WDATA[31:0],s_axi_control_WREADY,s_axi_control_WSTRB[3:0],s_axi_control_WVALID,ap_rst_n,interrupt,m_axi_gmem0_ARADDR[63:0],m_axi_gmem0_ARBURST[1:0],m_axi_gmem0_ARCACHE[3:0],m_axi_gmem0_ARID[0:0],m_axi_gmem0_ARLEN[7:0],m_axi_gmem0_ARLOCK[1:0],m_axi_gmem0_ARPROT[2:0],m_axi_gmem0_ARQOS[3:0],m_axi_gmem0_ARREADY,m_axi_gmem0_ARREGION[3:0],m_axi_gmem0_ARSIZE[2:0],m_axi_gmem0_ARVALID,m_axi_gmem0_AWADDR[63:0],m_axi_gmem0_AWBURST[1:0],m_axi_gmem0_AWCACHE[3:0],m_axi_gmem0_AWID[0:0],m_axi_gmem0_AWLEN[7:0],m_axi_gmem0_AWLOCK[1:0],m_axi_gmem0_AWPROT[2:0],m_axi_gmem0_AWQOS[3:0],m_axi_gmem0_AWREADY,m_axi_gmem0_AWREGION[3:0],m_axi_gmem0_AWSIZE[2:0],m_axi_gmem0_AWVALID,m_axi_gmem0_BID[0:0],m_axi_gmem0_BREADY,m_axi_gmem0_BRESP[1:0],m_axi_gmem0_BVALID,m_axi_gmem0_RDATA[31:0],m_axi_gmem0_RID[0:0],m_axi_gmem0_RLAST,m_axi_gmem0_RREADY,m_axi_gmem0_RRESP[1:0],m_axi_gmem0_RVALID,m_axi_gmem0_WDATA[31:0],m_axi_gmem0_WID[0:0],m_axi_gmem0_WLAST,m_axi_gmem0_WREADY,m_axi_gmem0_WSTRB[3:0],m_axi_gmem0_WVALID,m_axi_gmem1_ARADDR[63:0],m_axi_gmem1_ARBURST[1:0],m_axi_gmem1_ARCACHE[3:0],m_axi_gmem1_ARID[0:0],m_axi_gmem1_ARLEN[7:0],m_axi_gmem1_ARLOCK[1:0],m_axi_gmem1_ARPROT[2:0],m_axi_gmem1_ARQOS[3:0],m_axi_gmem1_ARREADY,m_axi_gmem1_ARREGION[3:0],m_axi_gmem1_ARSIZE[2:0],m_axi_gmem1_ARVALID,m_axi_gmem1_AWADDR[63:0],m_axi_gmem1_AWBURST[1:0],m_axi_gmem1_AWCACHE[3:0],m_axi_gmem1_AWID[0:0],m_axi_gmem1_AWLEN[7:0],m_axi_gmem1_AWLOCK[1:0],m_axi_gmem1_AWPROT[2:0],m_axi_gmem1_AWQOS[3:0],m_axi_gmem1_AWREADY,m_axi_gmem1_AWREGION[3:0],m_axi_gmem1_AWSIZE[2:0],m_axi_gmem1_AWVALID,m_axi_gmem1_BID[0:0],m_axi_gmem1_BREADY,m_axi_gmem1_BRESP[1:0],m_axi_gmem1_BVALID,m_axi_gmem1_RDATA[31:0],m_axi_gmem1_RID[0:0],m_axi_gmem1_RLAST,m_axi_gmem1_RREADY,m_axi_gmem1_RRESP[1:0],m_axi_gmem1_RVALID,m_axi_gmem1_WDATA[31:0],m_axi_gmem1_WID[0:0],m_axi_gmem1_WLAST,m_axi_gmem1_WREADY,m_axi_gmem1_WSTRB[3:0],m_axi_gmem1_WVALID,m_axi_gmem2_ARADDR[63:0],m_axi_gmem2_ARBURST[1:0],m_axi_gmem2_ARCACHE[3:0],m_axi_gmem2_ARID[0:0],m_axi_gmem2_ARLEN[7:0],m_axi_gmem2_ARLOCK[1:0],m_axi_gmem2_ARPROT[2:0],m_axi_gmem2_ARQOS[3:0],m_axi_gmem2_ARREADY,m_axi_gmem2_ARREGION[3:0],m_axi_gmem2_ARSIZE[2:0],m_axi_gmem2_ARVALID,m_axi_gmem2_AWADDR[63:0],m_axi_gmem2_AWBURST[1:0],m_axi_gmem2_AWCACHE[3:0],m_axi_gmem2_AWID[0:0],m_axi_gmem2_AWLEN[7:0],m_axi_gmem2_AWLOCK[1:0],m_axi_gmem2_AWPROT[2:0],m_axi_gmem2_AWQOS[3:0],m_axi_gmem2_AWREADY,m_axi_gmem2_AWREGION[3:0],m_axi_gmem2_AWSIZE[2:0],m_axi_gmem2_AWVALID,m_axi_gmem2_BID[0:0],m_axi_gmem2_BREADY,m_axi_gmem2_BRESP[1:0],m_axi_gmem2_BVALID,m_axi_gmem2_RDATA[31:0],m_axi_gmem2_RID[0:0],m_axi_gmem2_RLAST,m_axi_gmem2_RREADY,m_axi_gmem2_RRESP[1:0],m_axi_gmem2_RVALID,m_axi_gmem2_WDATA[31:0],m_axi_gmem2_WID[0:0],m_axi_gmem2_WLAST,m_axi_gmem2_WREADY,m_axi_gmem2_WSTRB[3:0],m_axi_gmem2_WVALID,m_axi_gmem3_ARADDR[63:0],m_axi_gmem3_ARBURST[1:0],m_axi_gmem3_ARCACHE[3:0],m_axi_gmem3_ARID[0:0],m_axi_gmem3_ARLEN[7:0],m_axi_gmem3_ARLOCK[1:0],m_axi_gmem3_ARPROT[2:0],m_axi_gmem3_ARQOS[3:0],m_axi_gmem3_ARREADY,m_axi_gmem3_ARREGION[3:0],m_axi_gmem3_ARSIZE[2:0],m_axi_gmem3_ARVALID,m_axi_gmem3_AWADDR[63:0],m_axi_gmem3_AWBURST[1:0],m_axi_gmem3_AWCACHE[3:0],m_axi_gmem3_AWID[0:0],m_axi_gmem3_AWLEN[7:0],m_axi_gmem3_AWLOCK[1:0],m_axi_gmem3_AWPROT[2:0],m_axi_gmem3_AWQOS[3:0],m_axi_gmem3_AWREADY,m_axi_gmem3_AWREGION[3:0],m_axi_gmem3_AWSIZE[2:0],m_axi_gmem3_AWVALID,m_axi_gmem3_BID[0:0],m_axi_gmem3_BREADY,m_axi_gmem3_BRESP[1:0],m_axi_gmem3_BVALID,m_axi_gmem3_RDATA[31:0],m_axi_gmem3_RID[0:0],m_axi_gmem3_RLAST,m_axi_gmem3_RREADY,m_axi_gmem3_RRESP[1:0],m_axi_gmem3_RVALID,m_axi_gmem3_WDATA[31:0],m_axi_gmem3_WID[0:0],m_axi_gmem3_WLAST,m_axi_gmem3_WREADY,m_axi_gmem3_WSTRB[3:0],m_axi_gmem3_WVALID,m_axi_gmem4_ARADDR[63:0],m_axi_gmem4_ARBURST[1:0],m_axi_gmem4_ARCACHE[3:0],m_axi_gmem4_ARID[0:0],m_axi_gmem4_ARLEN[7:0],m_axi_gmem4_ARLOCK[1:0],m_axi_gmem4_ARPROT[2:0],m_axi_gmem4_ARQOS[3:0],m_axi_gmem4_ARREADY,m_axi_gmem4_ARREGION[3:0],m_axi_gmem4_ARSIZE[2:0],m_axi_gmem4_ARVALID,m_axi_gmem4_AWADDR[63:0],m_axi_gmem4_AWBURST[1:0],m_axi_gmem4_AWCACHE[3:0],m_axi_gmem4_AWID[0:0],m_axi_gmem4_AWLEN[7:0],m_axi_gmem4_AWLOCK[1:0],m_axi_gmem4_AWPROT[2:0],m_axi_gmem4_AWQOS[3:0],m_axi_gmem4_AWREADY,m_axi_gmem4_AWREGION[3:0],m_axi_gmem4_AWSIZE[2:0],m_axi_gmem4_AWVALID,m_axi_gmem4_BID[0:0],m_axi_gmem4_BREADY,m_axi_gmem4_BRESP[1:0],m_axi_gmem4_BVALID,m_axi_gmem4_RDATA[31:0],m_axi_gmem4_RID[0:0],m_axi_gmem4_RLAST,m_axi_gmem4_RREADY,m_axi_gmem4_RRESP[1:0],m_axi_gmem4_RVALID,m_axi_gmem4_WDATA[31:0],m_axi_gmem4_WID[0:0],m_axi_gmem4_WLAST,m_axi_gmem4_WREADY,m_axi_gmem4_WSTRB[3:0],m_axi_gmem4_WVALID" */
/* synthesis syn_force_seq_prim="ap_clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 7, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [6:0]s_axi_control_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY" *) output s_axi_control_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID" *) input s_axi_control_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR" *) input [6:0]s_axi_control_AWADDR;
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:m_axi_gmem0:m_axi_gmem1:m_axi_gmem2:m_axi_gmem3:m_axi_gmem4, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *) input ap_clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output interrupt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem0, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_gmem0_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARBURST" *) output [1:0]m_axi_gmem0_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARCACHE" *) output [3:0]m_axi_gmem0_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARID" *) output [0:0]m_axi_gmem0_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARLEN" *) output [7:0]m_axi_gmem0_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARLOCK" *) output [1:0]m_axi_gmem0_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARPROT" *) output [2:0]m_axi_gmem0_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARQOS" *) output [3:0]m_axi_gmem0_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARREADY" *) input m_axi_gmem0_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARREGION" *) output [3:0]m_axi_gmem0_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARSIZE" *) output [2:0]m_axi_gmem0_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 ARVALID" *) output m_axi_gmem0_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWADDR" *) output [63:0]m_axi_gmem0_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWBURST" *) output [1:0]m_axi_gmem0_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWCACHE" *) output [3:0]m_axi_gmem0_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWID" *) output [0:0]m_axi_gmem0_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWLEN" *) output [7:0]m_axi_gmem0_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWLOCK" *) output [1:0]m_axi_gmem0_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWPROT" *) output [2:0]m_axi_gmem0_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWQOS" *) output [3:0]m_axi_gmem0_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWREADY" *) input m_axi_gmem0_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWREGION" *) output [3:0]m_axi_gmem0_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWSIZE" *) output [2:0]m_axi_gmem0_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 AWVALID" *) output m_axi_gmem0_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 BID" *) input [0:0]m_axi_gmem0_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 BREADY" *) output m_axi_gmem0_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 BRESP" *) input [1:0]m_axi_gmem0_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 BVALID" *) input m_axi_gmem0_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 RDATA" *) input [31:0]m_axi_gmem0_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 RID" *) input [0:0]m_axi_gmem0_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 RLAST" *) input m_axi_gmem0_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 RREADY" *) output m_axi_gmem0_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 RRESP" *) input [1:0]m_axi_gmem0_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 RVALID" *) input m_axi_gmem0_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 WDATA" *) output [31:0]m_axi_gmem0_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 WID" *) output [0:0]m_axi_gmem0_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 WLAST" *) output m_axi_gmem0_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 WREADY" *) input m_axi_gmem0_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 WSTRB" *) output [3:0]m_axi_gmem0_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem0 WVALID" *) output m_axi_gmem0_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem1, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_gmem1_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARBURST" *) output [1:0]m_axi_gmem1_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARCACHE" *) output [3:0]m_axi_gmem1_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARID" *) output [0:0]m_axi_gmem1_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARLEN" *) output [7:0]m_axi_gmem1_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARLOCK" *) output [1:0]m_axi_gmem1_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARPROT" *) output [2:0]m_axi_gmem1_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARQOS" *) output [3:0]m_axi_gmem1_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARREADY" *) input m_axi_gmem1_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARREGION" *) output [3:0]m_axi_gmem1_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARSIZE" *) output [2:0]m_axi_gmem1_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 ARVALID" *) output m_axi_gmem1_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWADDR" *) output [63:0]m_axi_gmem1_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWBURST" *) output [1:0]m_axi_gmem1_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWCACHE" *) output [3:0]m_axi_gmem1_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWID" *) output [0:0]m_axi_gmem1_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWLEN" *) output [7:0]m_axi_gmem1_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWLOCK" *) output [1:0]m_axi_gmem1_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWPROT" *) output [2:0]m_axi_gmem1_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWQOS" *) output [3:0]m_axi_gmem1_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWREADY" *) input m_axi_gmem1_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWREGION" *) output [3:0]m_axi_gmem1_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWSIZE" *) output [2:0]m_axi_gmem1_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 AWVALID" *) output m_axi_gmem1_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 BID" *) input [0:0]m_axi_gmem1_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 BREADY" *) output m_axi_gmem1_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 BRESP" *) input [1:0]m_axi_gmem1_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 BVALID" *) input m_axi_gmem1_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 RDATA" *) input [31:0]m_axi_gmem1_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 RID" *) input [0:0]m_axi_gmem1_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 RLAST" *) input m_axi_gmem1_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 RREADY" *) output m_axi_gmem1_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 RRESP" *) input [1:0]m_axi_gmem1_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 RVALID" *) input m_axi_gmem1_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 WDATA" *) output [31:0]m_axi_gmem1_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 WID" *) output [0:0]m_axi_gmem1_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 WLAST" *) output m_axi_gmem1_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 WREADY" *) input m_axi_gmem1_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 WSTRB" *) output [3:0]m_axi_gmem1_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem1 WVALID" *) output m_axi_gmem1_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem2, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_gmem2_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARBURST" *) output [1:0]m_axi_gmem2_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARCACHE" *) output [3:0]m_axi_gmem2_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARID" *) output [0:0]m_axi_gmem2_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARLEN" *) output [7:0]m_axi_gmem2_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARLOCK" *) output [1:0]m_axi_gmem2_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARPROT" *) output [2:0]m_axi_gmem2_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARQOS" *) output [3:0]m_axi_gmem2_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARREADY" *) input m_axi_gmem2_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARREGION" *) output [3:0]m_axi_gmem2_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARSIZE" *) output [2:0]m_axi_gmem2_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 ARVALID" *) output m_axi_gmem2_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWADDR" *) output [63:0]m_axi_gmem2_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWBURST" *) output [1:0]m_axi_gmem2_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWCACHE" *) output [3:0]m_axi_gmem2_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWID" *) output [0:0]m_axi_gmem2_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWLEN" *) output [7:0]m_axi_gmem2_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWLOCK" *) output [1:0]m_axi_gmem2_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWPROT" *) output [2:0]m_axi_gmem2_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWQOS" *) output [3:0]m_axi_gmem2_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWREADY" *) input m_axi_gmem2_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWREGION" *) output [3:0]m_axi_gmem2_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWSIZE" *) output [2:0]m_axi_gmem2_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 AWVALID" *) output m_axi_gmem2_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 BID" *) input [0:0]m_axi_gmem2_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 BREADY" *) output m_axi_gmem2_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 BRESP" *) input [1:0]m_axi_gmem2_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 BVALID" *) input m_axi_gmem2_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 RDATA" *) input [31:0]m_axi_gmem2_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 RID" *) input [0:0]m_axi_gmem2_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 RLAST" *) input m_axi_gmem2_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 RREADY" *) output m_axi_gmem2_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 RRESP" *) input [1:0]m_axi_gmem2_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 RVALID" *) input m_axi_gmem2_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 WDATA" *) output [31:0]m_axi_gmem2_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 WID" *) output [0:0]m_axi_gmem2_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 WLAST" *) output m_axi_gmem2_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 WREADY" *) input m_axi_gmem2_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 WSTRB" *) output [3:0]m_axi_gmem2_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem2 WVALID" *) output m_axi_gmem2_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem3, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_gmem3_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARBURST" *) output [1:0]m_axi_gmem3_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARCACHE" *) output [3:0]m_axi_gmem3_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARID" *) output [0:0]m_axi_gmem3_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARLEN" *) output [7:0]m_axi_gmem3_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARLOCK" *) output [1:0]m_axi_gmem3_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARPROT" *) output [2:0]m_axi_gmem3_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARQOS" *) output [3:0]m_axi_gmem3_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARREADY" *) input m_axi_gmem3_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARREGION" *) output [3:0]m_axi_gmem3_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARSIZE" *) output [2:0]m_axi_gmem3_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 ARVALID" *) output m_axi_gmem3_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWADDR" *) output [63:0]m_axi_gmem3_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWBURST" *) output [1:0]m_axi_gmem3_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWCACHE" *) output [3:0]m_axi_gmem3_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWID" *) output [0:0]m_axi_gmem3_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWLEN" *) output [7:0]m_axi_gmem3_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWLOCK" *) output [1:0]m_axi_gmem3_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWPROT" *) output [2:0]m_axi_gmem3_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWQOS" *) output [3:0]m_axi_gmem3_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWREADY" *) input m_axi_gmem3_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWREGION" *) output [3:0]m_axi_gmem3_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWSIZE" *) output [2:0]m_axi_gmem3_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 AWVALID" *) output m_axi_gmem3_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 BID" *) input [0:0]m_axi_gmem3_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 BREADY" *) output m_axi_gmem3_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 BRESP" *) input [1:0]m_axi_gmem3_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 BVALID" *) input m_axi_gmem3_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 RDATA" *) input [31:0]m_axi_gmem3_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 RID" *) input [0:0]m_axi_gmem3_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 RLAST" *) input m_axi_gmem3_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 RREADY" *) output m_axi_gmem3_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 RRESP" *) input [1:0]m_axi_gmem3_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 RVALID" *) input m_axi_gmem3_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 WDATA" *) output [31:0]m_axi_gmem3_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 WID" *) output [0:0]m_axi_gmem3_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 WLAST" *) output m_axi_gmem3_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 WREADY" *) input m_axi_gmem3_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 WSTRB" *) output [3:0]m_axi_gmem3_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem3 WVALID" *) output m_axi_gmem3_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARADDR" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_gmem4, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, MAX_BURST_LENGTH 256, PROTOCOL AXI4, READ_WRITE_MODE WRITE_ONLY, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, ADDR_WIDTH 64, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output [63:0]m_axi_gmem4_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARBURST" *) output [1:0]m_axi_gmem4_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARCACHE" *) output [3:0]m_axi_gmem4_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARID" *) output [0:0]m_axi_gmem4_ARID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARLEN" *) output [7:0]m_axi_gmem4_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARLOCK" *) output [1:0]m_axi_gmem4_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARPROT" *) output [2:0]m_axi_gmem4_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARQOS" *) output [3:0]m_axi_gmem4_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARREADY" *) input m_axi_gmem4_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARREGION" *) output [3:0]m_axi_gmem4_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARSIZE" *) output [2:0]m_axi_gmem4_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 ARVALID" *) output m_axi_gmem4_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWADDR" *) output [63:0]m_axi_gmem4_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWBURST" *) output [1:0]m_axi_gmem4_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWCACHE" *) output [3:0]m_axi_gmem4_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWID" *) output [0:0]m_axi_gmem4_AWID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWLEN" *) output [7:0]m_axi_gmem4_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWLOCK" *) output [1:0]m_axi_gmem4_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWPROT" *) output [2:0]m_axi_gmem4_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWQOS" *) output [3:0]m_axi_gmem4_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWREADY" *) input m_axi_gmem4_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWREGION" *) output [3:0]m_axi_gmem4_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWSIZE" *) output [2:0]m_axi_gmem4_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 AWVALID" *) output m_axi_gmem4_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 BID" *) input [0:0]m_axi_gmem4_BID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 BREADY" *) output m_axi_gmem4_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 BRESP" *) input [1:0]m_axi_gmem4_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 BVALID" *) input m_axi_gmem4_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 RDATA" *) input [31:0]m_axi_gmem4_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 RID" *) input [0:0]m_axi_gmem4_RID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 RLAST" *) input m_axi_gmem4_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 RREADY" *) output m_axi_gmem4_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 RRESP" *) input [1:0]m_axi_gmem4_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 RVALID" *) input m_axi_gmem4_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 WDATA" *) output [31:0]m_axi_gmem4_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 WID" *) output [0:0]m_axi_gmem4_WID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 WLAST" *) output m_axi_gmem4_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 WREADY" *) input m_axi_gmem4_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 WSTRB" *) output [3:0]m_axi_gmem4_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_gmem4 WVALID" *) output m_axi_gmem4_WVALID;
endmodule
