// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

`timescale 1 ns / 1 ps

module AESL_axi_master_gmem4 (
    clk,
    reset,
    TRAN_gmem4_AWVALID,
    TRAN_gmem4_AWREADY,
    TRAN_gmem4_AWADDR,
    TRAN_gmem4_AWID,
    TRAN_gmem4_AWLEN,
    TRAN_gmem4_AWSIZE,
    TRAN_gmem4_AWBURST,
    TRAN_gmem4_AWLOCK,
    TRAN_gmem4_AWCACHE,
    TRAN_gmem4_AWPROT,
    TRAN_gmem4_AWQOS,
    TRAN_gmem4_AWREGION,
    TRAN_gmem4_AWUSER,
    TRAN_gmem4_WVALID,
    TRAN_gmem4_WREADY,
    TRAN_gmem4_WDATA,
    TRAN_gmem4_WSTRB,
    TRAN_gmem4_WLAST,
    TRAN_gmem4_WID,
    TRAN_gmem4_WUSER,
    TRAN_gmem4_ARVALID,
    TRAN_gmem4_ARREADY,
    TRAN_gmem4_ARADDR,
    TRAN_gmem4_ARID,
    TRAN_gmem4_ARLEN,
    TRAN_gmem4_ARSIZE,
    TRAN_gmem4_ARBURST,
    TRAN_gmem4_ARLOCK,
    TRAN_gmem4_ARCACHE,
    TRAN_gmem4_ARPROT,
    TRAN_gmem4_ARQOS,
    TRAN_gmem4_ARREGION,
    TRAN_gmem4_ARUSER,
    TRAN_gmem4_RVALID,
    TRAN_gmem4_RREADY,
    TRAN_gmem4_RDATA,
    TRAN_gmem4_RLAST,
    TRAN_gmem4_RID,
    TRAN_gmem4_RUSER,
    TRAN_gmem4_RRESP,
    TRAN_gmem4_BVALID,
    TRAN_gmem4_BREADY,
    TRAN_gmem4_BRESP,
    TRAN_gmem4_BID,
    TRAN_gmem4_BUSER,
    ready,
    done
    );

//------------------------Parameter----------------------
`define TV_IN_gmem4 "../tv/cdatafile/c.spmv_csc.autotvin_gmem4.dat"
`define TV_OUT_gmem4 "../tv/rtldatafile/rtl.spmv_csc.autotvout_gmem4.dat"
 parameter gmem4_ADDR_BITWIDTH = 32'd 64;
 parameter gmem4_AWUSER_BITWIDTH = 32'd 1;
 parameter gmem4_DATA_BITWIDTH = 32'd 512;
 parameter gmem4_WUSER_BITWIDTH = 32'd 1;
 parameter gmem4_ID_BITWIDTH = 32'd 1;
 parameter gmem4_RUSER_BITWIDTH = 32'd 1;
 parameter gmem4_BUSER_BITWIDTH = 32'd 1;
 parameter   FIFO_DEPTH            =   1 + 1;
 parameter   mem_page_num            =   32'd 4;
 parameter   FIFO_DEPTH_ADDR_WIDTH   =    32'd 32;
parameter gmem4_C_DATA_BITWIDTH = 32'd 512;
parameter gmem4_transaction_depth = 32'd 64;
parameter gmem4_mem_depth = 32'd 64;
parameter ReadReqLatency = 32'd 1;
parameter WriteReqLatency = 32'd 1;
// Input and Output
input clk;
input reset;
input  TRAN_gmem4_AWVALID;
output  TRAN_gmem4_AWREADY;
input [gmem4_ADDR_BITWIDTH - 1 : 0] TRAN_gmem4_AWADDR;
input [gmem4_ID_BITWIDTH - 1 : 0] TRAN_gmem4_AWID;
input [8 - 1 : 0] TRAN_gmem4_AWLEN;
input [3 - 1 : 0] TRAN_gmem4_AWSIZE;
input [2 - 1 : 0] TRAN_gmem4_AWBURST;
input [2 - 1 : 0] TRAN_gmem4_AWLOCK;
input [4 - 1 : 0] TRAN_gmem4_AWCACHE;
input [3 - 1 : 0] TRAN_gmem4_AWPROT;
input [4 - 1 : 0] TRAN_gmem4_AWQOS;
input [4 - 1 : 0] TRAN_gmem4_AWREGION;
input [gmem4_AWUSER_BITWIDTH - 1 : 0] TRAN_gmem4_AWUSER;
input  TRAN_gmem4_WVALID;
output  TRAN_gmem4_WREADY;
input [gmem4_DATA_BITWIDTH - 1 : 0] TRAN_gmem4_WDATA;
input [gmem4_DATA_BITWIDTH/8 - 1 : 0] TRAN_gmem4_WSTRB;
input  TRAN_gmem4_WLAST;
input  TRAN_gmem4_WID;
input [gmem4_WUSER_BITWIDTH - 1 : 0] TRAN_gmem4_WUSER;
input  TRAN_gmem4_ARVALID;
output  TRAN_gmem4_ARREADY;
input [gmem4_ADDR_BITWIDTH - 1 : 0] TRAN_gmem4_ARADDR;
input [gmem4_ID_BITWIDTH - 1 : 0] TRAN_gmem4_ARID;
input [8 - 1 : 0] TRAN_gmem4_ARLEN;
input [3 - 1 : 0] TRAN_gmem4_ARSIZE;
input [2 - 1 : 0] TRAN_gmem4_ARBURST;
input [2 - 1 : 0] TRAN_gmem4_ARLOCK;
input [4 - 1 : 0] TRAN_gmem4_ARCACHE;
input [3 - 1 : 0] TRAN_gmem4_ARPROT;
input [4 - 1 : 0] TRAN_gmem4_ARQOS;
input [4 - 1 : 0] TRAN_gmem4_ARREGION;
input  TRAN_gmem4_ARUSER;
output  TRAN_gmem4_RVALID;
input  TRAN_gmem4_RREADY;
output [gmem4_DATA_BITWIDTH - 1 : 0] TRAN_gmem4_RDATA;
output  TRAN_gmem4_RLAST;
output [gmem4_ID_BITWIDTH - 1 : 0] TRAN_gmem4_RID;
output [gmem4_RUSER_BITWIDTH - 1 : 0] TRAN_gmem4_RUSER;
output [2 - 1 : 0] TRAN_gmem4_RRESP;
output  TRAN_gmem4_BVALID;
input  TRAN_gmem4_BREADY;
output [2 - 1 : 0] TRAN_gmem4_BRESP;
output [gmem4_ID_BITWIDTH - 1 : 0] TRAN_gmem4_BID;
output [gmem4_BUSER_BITWIDTH - 1 : 0] TRAN_gmem4_BUSER;
input ready;
input done;

// Inner signals
// AW request fifo
reg    [gmem4_ADDR_BITWIDTH - 1 : 0]         FIFO_AW_req_ADDR           [0 : FIFO_DEPTH - 1]; 
reg    [gmem4_ADDR_BITWIDTH - 1 : 0]         FIFO_AW_req_ADDR_tmp; 
reg    [1 - 1 : 0]                     FIFO_AW_req_ID           [0 : FIFO_DEPTH - 1]; 
reg    [1 - 1 : 0]                     FIFO_AW_req_ID_tmp; 
reg    [8 - 1 : 0]                     FIFO_AW_req_LEN           [0 : FIFO_DEPTH - 1]; 
reg    [8 - 1 : 0]                     FIFO_AW_req_LEN_tmp; 
reg    [3 - 1 : 0]                     FIFO_AW_req_SIZE           [0 : FIFO_DEPTH - 1]; 
reg    [3 - 1 : 0]                     FIFO_AW_req_SIZE_tmp; 
reg    [2 - 1 : 0]                     FIFO_AW_req_BURST           [0 : FIFO_DEPTH - 1]; 
reg    [2 - 1 : 0]                     FIFO_AW_req_BURST_tmp; 
reg    [31  : 0]                     FIFO_AW_req_transaction_number [0 : FIFO_DEPTH - 1]; 
reg    [31  : 0]                     FIFO_AW_req_cycle_number [0 : FIFO_DEPTH - 1]; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_AW_req_ptr_r = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_AW_req_ptr_r_tmp = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_AW_req_ptr_w = 0; 
reg    FIFO_AW_req_flag    =   0;        // '0' for empty, '1' for full 
reg    FIFO_AW_req_empty = 1; 
reg    FIFO_AW_req_read = 0; 
reg    FIFO_AW_req_full = 0; 

// AR request fifo
reg    [gmem4_ADDR_BITWIDTH - 1 : 0]         FIFO_AR_req_ADDR           [0 : FIFO_DEPTH - 1]; 
reg    [gmem4_ADDR_BITWIDTH - 1 : 0]         FIFO_AR_req_ADDR_tmp; 
reg    [1 - 1 : 0]                     FIFO_AR_req_ID           [0 : FIFO_DEPTH - 1]; 
reg    [1 - 1 : 0]                     FIFO_AR_req_ID_tmp; 
reg    [8 - 1 : 0]                     FIFO_AR_req_LEN           [0 : FIFO_DEPTH - 1]; 
reg    [8 - 1 : 0]                     FIFO_AR_req_LEN_tmp; 
reg    [3 - 1 : 0]                     FIFO_AR_req_SIZE           [0 : FIFO_DEPTH - 1]; 
reg    [3 - 1 : 0]                     FIFO_AR_req_SIZE_tmp; 
reg    [2 - 1 : 0]                     FIFO_AR_req_BURST           [0 : FIFO_DEPTH - 1]; 
reg    [2 - 1 : 0]                     FIFO_AR_req_BURST_tmp; 
reg    [31  : 0]                     FIFO_AR_req_transaction_number [0 : FIFO_DEPTH - 1]; 
reg    [31  : 0]                     FIFO_AR_req_cycle_number [0 : FIFO_DEPTH - 1]; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_AR_req_ptr_r = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_AR_req_ptr_r_tmp = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_AR_req_ptr_w = 0; 
reg    FIFO_AR_req_flag    =   0;        // '0' for empty, '1' for full 
reg    FIFO_AR_req_empty = 1; 
reg    FIFO_AR_req_read = 0; 
reg    FIFO_AR_req_full = 0; 

// WDATA fifo
reg    [gmem4_DATA_BITWIDTH - 1 : 0]         FIFO_WDATA           [0 : FIFO_DEPTH - 1]; 
reg    [gmem4_DATA_BITWIDTH/8 - 1 : 0]       FIFO_WSTRB           [0 : FIFO_DEPTH - 1]; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_WDATA_req_ptr_r = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_WDATA_req_ptr_w = 0; 
reg    FIFO_WDATA_req_flag    =   0;        // '0' for empty, '1' for full 
reg    FIFO_WDATA_req_empty = 1; 
reg    FIFO_WDATA_read = 0; 
reg    FIFO_WDATA_req_full = 0; 

// WDATA size fifo
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]         FIFO_WDATA_size           [0 : FIFO_DEPTH - 1]; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_WDATA_size_ptr_r = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH - 1 : 0]    FIFO_WDATA_size_ptr_w = 0; 
reg    FIFO_WDATA_size_flag    =   0;        // '0' for empty, '1' for full 
reg    FIFO_WDATA_size_empty = 1; 
reg    FIFO_WDATA_size_read = 0; 
reg    FIFO_WDATA_size_full = 0; 
reg    [FIFO_DEPTH_ADDR_WIDTH : 0] WDATA_size = 0; 
reg    BRESP_tmp = 0;
reg    [gmem4_ID_BITWIDTH - 1 : 0] BID_tmp = 0;
reg    send_one_BRESP = 0;
reg    [31 : 0] BRESP_counter = 0;

reg [gmem4_DATA_BITWIDTH - 1:0] RDATA_tmp = 0;
reg [2 - 1:0] RRESP_tmp = 0;
reg RLAST_tmp = 0;
reg RVALID_tmp = 0;
reg [gmem4_ID_BITWIDTH - 1 : 0] RID_tmp = 0;
reg [gmem4_DATA_BITWIDTH - 1 : 0] gmem4_mem_0 [0: gmem4_mem_depth - 1] = '{default : 'h0}; 
reg [gmem4_DATA_BITWIDTH - 1 : 0] gmem4_mem_1 [0: gmem4_mem_depth - 1] = '{default : 'h0}; 
reg [gmem4_DATA_BITWIDTH - 1 : 0] gmem4_mem_2 [0: gmem4_mem_depth - 1] = '{default : 'h0}; 
reg [gmem4_DATA_BITWIDTH - 1 : 0] gmem4_mem_3 [0: gmem4_mem_depth - 1] = '{default : 'h0}; 
reg [31 : 0] clk_counter ;
reg [31 : 0] current_AW_req_transaction = 0 ;
reg [31 : 0] current_AR_req_transaction = -1 ;
reg write_processing = 0;
reg [gmem4_ADDR_BITWIDTH - 1 : 0] wr_processing_addr = 0;
reg [gmem4_ADDR_BITWIDTH - 1 : 0] rd_processing_addr = 0;
reg [31 : 0] wr_processing_trans_num = 0;
reg [gmem4_DATA_BITWIDTH - 1 : 0] wr_processing_data = 0;
assign TRAN_gmem4_AWREADY    =    !FIFO_AW_req_full; 
assign TRAN_gmem4_ARREADY    =    !FIFO_AR_req_full; 
assign TRAN_gmem4_WREADY    =     !(FIFO_WDATA_req_full || FIFO_WDATA_size_full); 
assign TRAN_gmem4_BVALID = (BRESP_counter == 0) ? 0 : 1;
assign TRAN_gmem4_BRESP = BRESP_tmp;
assign TRAN_gmem4_BID = BID_tmp;
assign TRAN_gmem4_RDATA = RDATA_tmp;
assign TRAN_gmem4_RRESP = RRESP_tmp;
assign TRAN_gmem4_RLAST = RLAST_tmp;
assign TRAN_gmem4_RID = RID_tmp;
assign TRAN_gmem4_RVALID = RVALID_tmp;

initial begin : initialize_offset
  integer DATA_byte_num; 
  integer c_bitwidth;
  DATA_byte_num = 0; 
  c_bitwidth = gmem4_C_DATA_BITWIDTH;
end

always @ (posedge clk or reset) begin 
    if(reset === 0) begin 
        clk_counter <= 0;
    end else begin
        clk_counter <= clk_counter + 1;
    end
end

// Generate "FIFO_req_empty" and "FIFO_req_full" 
always @ (FIFO_AW_req_ptr_r or FIFO_AW_req_ptr_w or FIFO_AW_req_flag) begin 
    if(FIFO_AW_req_ptr_r == FIFO_AW_req_ptr_w) begin 
        if(FIFO_AW_req_flag) begin 
            FIFO_AW_req_full   <= 1; 
            FIFO_AW_req_empty  <= 0; 
        end else begin 
            FIFO_AW_req_full   <= 0; 
            FIFO_AW_req_empty  <= 1; 
        end 
    end else begin 
        FIFO_AW_req_full     <= 0; 
        FIFO_AW_req_empty    <= 0; 
    end 
end 

always @ (done) begin 
    if (done == 1) begin
        current_AW_req_transaction <= current_AW_req_transaction + 1;
    end 
end 

always @ (FIFO_AR_req_ptr_r or FIFO_AR_req_ptr_w or FIFO_AR_req_flag) begin 
    if(FIFO_AR_req_ptr_r == FIFO_AR_req_ptr_w) begin 
        if(FIFO_AR_req_flag) begin 
            FIFO_AR_req_full   <= 1; 
            FIFO_AR_req_empty  <= 0; 
        end else begin 
            FIFO_AR_req_full   <= 0; 
            FIFO_AR_req_empty  <= 1; 
        end 
    end else begin 
        FIFO_AR_req_full     <= 0; 
        FIFO_AR_req_empty    <= 0; 
    end 
end 

always @ (ready) begin 
    if (ready == 1) begin
        current_AR_req_transaction <= current_AR_req_transaction + 1;
    end 
end 
 
always @ (FIFO_WDATA_req_ptr_r or FIFO_WDATA_req_ptr_w or FIFO_WDATA_req_flag) begin 
    if(FIFO_WDATA_req_ptr_r == FIFO_WDATA_req_ptr_w) begin 
        if(FIFO_WDATA_req_flag) begin 
            FIFO_WDATA_req_full   <= 1; 
            FIFO_WDATA_req_empty  <= 0; 
        end else begin 
            FIFO_WDATA_req_full   <= 0; 
            FIFO_WDATA_req_empty  <= 1; 
        end 
    end else begin 
        FIFO_WDATA_req_full     <= 0; 
        FIFO_WDATA_req_empty    <= 0; 
    end 
end 
 
always @ (FIFO_WDATA_size_ptr_r or FIFO_WDATA_size_ptr_w or FIFO_WDATA_size_flag) begin 
    if(FIFO_WDATA_size_ptr_r == FIFO_WDATA_size_ptr_w) begin 
        if(FIFO_WDATA_size_flag) begin 
            FIFO_WDATA_size_full   <= 1; 
            FIFO_WDATA_size_empty  <= 0; 
        end else begin 
            FIFO_WDATA_size_full   <= 0; 
            FIFO_WDATA_size_empty  <= 1; 
        end 
    end else begin 
        FIFO_WDATA_size_full     <= 0; 
        FIFO_WDATA_size_empty    <= 0; 
    end 
end 
 
// Push RTL's req into FIFO_req 
always @ (posedge clk or reset) begin 
    if(reset === 0) begin 
        FIFO_AW_req_ptr_w <= 0; 
    end else begin 
        if(TRAN_gmem4_AWREADY & TRAN_gmem4_AWVALID ) begin    // RTL is sending a AW_request to the bus         
            FIFO_AW_req_SIZE [FIFO_AW_req_ptr_w]    =   TRAN_gmem4_AWSIZE; 
            FIFO_AW_req_ADDR [FIFO_AW_req_ptr_w]    =   TRAN_gmem4_AWADDR; 
            FIFO_AW_req_LEN  [FIFO_AW_req_ptr_w]    =   TRAN_gmem4_AWLEN; 
            FIFO_AW_req_BURST[FIFO_AW_req_ptr_w]    =   TRAN_gmem4_AWBURST; 
            FIFO_AW_req_ID[FIFO_AW_req_ptr_w]    =   TRAN_gmem4_AWID; 
            FIFO_AW_req_transaction_number[FIFO_AW_req_ptr_w]    =   current_AW_req_transaction; 
            FIFO_AW_req_cycle_number[FIFO_AW_req_ptr_w]    =   clk_counter; 
            if(FIFO_AW_req_ptr_w != FIFO_DEPTH - 1) 
                FIFO_AW_req_ptr_w <= FIFO_AW_req_ptr_w + 1; 
            else 
                FIFO_AW_req_ptr_w <= 0; 
       end 
    end 
end 
 
always @ (posedge clk or reset) begin 
    if(reset === 0) begin 
        FIFO_AR_req_ptr_w <= 0; 
    end else begin 
        if(TRAN_gmem4_ARREADY & TRAN_gmem4_ARVALID ) begin    // RTL is sending a AR_request to the bus         
            FIFO_AR_req_SIZE [FIFO_AR_req_ptr_w]    =   TRAN_gmem4_ARSIZE; 
            FIFO_AR_req_ADDR [FIFO_AR_req_ptr_w]    =   TRAN_gmem4_ARADDR; 
            FIFO_AR_req_LEN  [FIFO_AR_req_ptr_w]    =   TRAN_gmem4_ARLEN; 
            FIFO_AR_req_BURST[FIFO_AR_req_ptr_w]    =   TRAN_gmem4_ARBURST; 
            FIFO_AR_req_ID[FIFO_AR_req_ptr_w]    =   TRAN_gmem4_ARID; 
            FIFO_AR_req_transaction_number[FIFO_AR_req_ptr_w]    =   current_AR_req_transaction; 
            FIFO_AR_req_cycle_number[FIFO_AR_req_ptr_w]    =   clk_counter; 
            if(FIFO_AR_req_ptr_w != FIFO_DEPTH - 1) 
                FIFO_AR_req_ptr_w <= FIFO_AR_req_ptr_w + 1; 
            else 
                FIFO_AR_req_ptr_w <= 0; 
       end 
    end 
end

always @ (posedge clk or reset) begin 
    if(reset === 0) begin 
        FIFO_WDATA_req_ptr_w <= 0; 
    end else begin 
        if(TRAN_gmem4_WREADY & TRAN_gmem4_WVALID) begin    // RTL is sending a WDATA data 
            FIFO_WDATA [FIFO_WDATA_req_ptr_w]    <=   TRAN_gmem4_WDATA; 
            FIFO_WSTRB [FIFO_WDATA_req_ptr_w]    <=   TRAN_gmem4_WSTRB; 
            if(FIFO_WDATA_req_ptr_w != FIFO_DEPTH - 1) 
                FIFO_WDATA_req_ptr_w <= FIFO_WDATA_req_ptr_w + 1; 
            else 
                FIFO_WDATA_req_ptr_w <= 0; 
            if (TRAN_gmem4_WLAST == 1 ) begin
                FIFO_WDATA_size [FIFO_WDATA_size_ptr_w] <= WDATA_size + 1;
                if(FIFO_WDATA_size_ptr_w != FIFO_DEPTH - 1) 
                    FIFO_WDATA_size_ptr_w <= FIFO_WDATA_size_ptr_w + 1; 
                else 
                    FIFO_WDATA_size_ptr_w <= 0; 
                WDATA_size <= 0;
            end else begin
                WDATA_size <= WDATA_size + 1;
            end
       end 
    end 
end

// Generate "FIFO_AW_req_flag" 
always @(posedge clk or reset) begin 
    if(reset === 0) begin 
      FIFO_AW_req_flag <= 0; 
    end else begin 
      if(TRAN_gmem4_AWVALID && TRAN_gmem4_AWREADY && ((FIFO_AW_req_ptr_w - FIFO_AW_req_ptr_r) % FIFO_DEPTH == FIFO_DEPTH - 1)) 
          FIFO_AW_req_flag <= 1; 
      # 0.4;
      if(FIFO_AW_req_read && !FIFO_AW_req_empty && (FIFO_AW_req_ptr_w - FIFO_AW_req_ptr_r == 0)) 
          FIFO_AW_req_flag <= 0; 
    end 
end 

// Generate "FIFO_AR_req_flag" 
always @(posedge clk or reset) begin 
    if(reset === 0) begin 
      FIFO_AR_req_flag <= 0; 
    end else begin 
      if(TRAN_gmem4_ARVALID && TRAN_gmem4_ARREADY && ((FIFO_AR_req_ptr_w - FIFO_AR_req_ptr_r) % FIFO_DEPTH == FIFO_DEPTH - 1)) 
          FIFO_AR_req_flag <= 1; 
      # 0.4;
      if(FIFO_AR_req_read && !FIFO_AR_req_empty && (FIFO_AR_req_ptr_w - FIFO_AR_req_ptr_r == 0)) 
          FIFO_AR_req_flag <= 0; 
    end 
end 

// Generate "FIFO_WDATA_req_flag" 
always @(posedge clk or reset) begin 
    if(reset === 0) begin 
      FIFO_WDATA_req_flag <= 0; 
    end else begin 
      if(TRAN_gmem4_WVALID && TRAN_gmem4_WREADY && ((FIFO_WDATA_req_ptr_w - FIFO_WDATA_req_ptr_r) % FIFO_DEPTH == FIFO_DEPTH - 1)) 
          FIFO_WDATA_req_flag <= 1; 
      # 0.4;
      if(FIFO_WDATA_read && !FIFO_WDATA_req_empty && (FIFO_WDATA_req_ptr_w - FIFO_WDATA_req_ptr_r == 0)) 
          FIFO_WDATA_req_flag <= 0; 
    end 
end 

// Generate "FIFO_WDATA_size_flag" 
always @(posedge clk or reset) begin 
    if(reset === 0) begin 
      FIFO_WDATA_size_flag <= 0; 
    end else begin 
      if(TRAN_gmem4_WVALID && TRAN_gmem4_WREADY && TRAN_gmem4_WLAST && ((FIFO_WDATA_size_ptr_w - FIFO_WDATA_size_ptr_r) % FIFO_DEPTH == FIFO_DEPTH - 1)) 
          FIFO_WDATA_size_flag <= 1; 
      # 0.4;
      if(FIFO_WDATA_size_read && !FIFO_WDATA_size_empty && (FIFO_WDATA_size_ptr_w - FIFO_WDATA_size_ptr_r == 0)) 
          FIFO_WDATA_size_flag <= 0; 
    end
end 

always @(posedge clk or reset) begin 
    if(reset === 0) begin 
        FIFO_AW_req_read <= 0;
        FIFO_AW_req_ptr_r <= 0;
    end else begin 
        #0.2;
        if (FIFO_AW_req_ptr_r_tmp > FIFO_AW_req_ptr_r) begin
            FIFO_AW_req_read <= 1;
            FIFO_AW_req_ptr_r <= FIFO_AW_req_ptr_r + 1;
        end else if (FIFO_AW_req_ptr_r_tmp == 0 && FIFO_AW_req_ptr_r == FIFO_DEPTH - 1) begin
            FIFO_AW_req_read <= 1;
            FIFO_AW_req_ptr_r <= 0;
        end else begin 
            FIFO_AW_req_read <= 0;
        end
    end 
end

always @(posedge clk or reset) begin 
    if(reset === 0) begin 
        BRESP_counter <= 0;
        BRESP_tmp <= 0;
    end else begin
        if ( send_one_BRESP == 'b1 && !(BRESP_counter != 32'h0 && TRAN_gmem4_BREADY) ) begin
            BRESP_counter <= BRESP_counter + 1;
        end else if (send_one_BRESP != 'b1 && (BRESP_counter != 32'h0 && TRAN_gmem4_BREADY)) begin
            BRESP_counter <= BRESP_counter - 1;
        end
    end
end

initial begin : AW_request_proc
    integer counter;
    integer i;
    integer j;
    integer data_byte_size;
    integer output_length;
    integer FIFO_AW_req_transaction_tmp;
    integer FIFO_AW_req_clk_tmp;
    integer WDATA_size_tmp;
    reg [gmem4_DATA_BITWIDTH - 1 : 0] FIFO_WDATA_tmp;
    reg [gmem4_DATA_BITWIDTH - 1 : 0] WDATA_tmp;
    reg [gmem4_DATA_BITWIDTH/8 - 1 : 0] FIFO_WSTRB_tmp;
    @(posedge clk);

    while (1) begin
        if (FIFO_AW_req_empty === 1 || BRESP_counter == 32) begin
            @(posedge clk);
        end else begin
            if(FIFO_AW_req_ptr_r_tmp != FIFO_DEPTH - 1)
                FIFO_AW_req_ptr_r_tmp = FIFO_AW_req_ptr_r_tmp + 1;
            else
                FIFO_AW_req_ptr_r_tmp = 0;

            FIFO_AW_req_ADDR_tmp    =  FIFO_AW_req_ADDR   [FIFO_AW_req_ptr_r]  ;
            FIFO_AW_req_SIZE_tmp    =  FIFO_AW_req_SIZE   [FIFO_AW_req_ptr_r]  ;
            FIFO_AW_req_LEN_tmp     =  FIFO_AW_req_LEN    [FIFO_AW_req_ptr_r]  ; 
            FIFO_AW_req_BURST_tmp   =  FIFO_AW_req_BURST  [FIFO_AW_req_ptr_r]  ;
            FIFO_AW_req_ID_tmp      =  FIFO_AW_req_ID  [FIFO_AW_req_ptr_r]  ;
            FIFO_AW_req_transaction_tmp   =  FIFO_AW_req_transaction_number[FIFO_AW_req_ptr_r]  ;
            FIFO_AW_req_clk_tmp     =  FIFO_AW_req_cycle_number[FIFO_AW_req_ptr_r]  ;
            
            while (clk_counter < FIFO_AW_req_clk_tmp + WriteReqLatency ) begin
                @(posedge clk);
            end
            
            data_byte_size = 1;
            for (i=0;i<FIFO_AW_req_SIZE_tmp; i=i+1) begin
                data_byte_size = data_byte_size * 2;
            end
            
            if (FIFO_AW_req_ADDR_tmp/data_byte_size > gmem4_mem_depth) begin
                $display ("/home/romoirib/QP/spmv_csc_tmp/spmv_csc/spmv_csc/hls/sim/verilog/AESL_axi_master_gmem4.v: Write request address %d exceed AXI master gmem4 array depth: %d",FIFO_AW_req_ADDR_tmp/data_byte_size, gmem4_mem_depth); 
                $finish;
            end
            
            if (FIFO_AW_req_BURST_tmp === 1) begin
                counter = 0;
                output_length = FIFO_AW_req_LEN_tmp;
                while (counter != output_length + 1) begin
                    if (FIFO_WDATA_req_empty != 1) begin 
                        FIFO_WDATA_read <= 1;
                        if(FIFO_WDATA_req_ptr_r != FIFO_DEPTH - 1)
                            FIFO_WDATA_req_ptr_r <= FIFO_WDATA_req_ptr_r + 1;
                        else
                            FIFO_WDATA_req_ptr_r <= 0;
                        FIFO_WDATA_tmp = FIFO_WDATA [FIFO_WDATA_req_ptr_r];
                        FIFO_WSTRB_tmp = FIFO_WSTRB [FIFO_WDATA_req_ptr_r];
                        for (i = 0 ; i < data_byte_size; i = i + 1) begin
                            if (FIFO_WSTRB_tmp[i] == 1) begin 
                                for (j=(i*8); j< (i+1)*8 ; j= j+1) begin
                                    WDATA_tmp[j] = FIFO_WDATA_tmp[j];
                                end
                            end else begin
                                for (j=(i*8); j< (i+1)*8 ; j= j+1) begin
                                    case(FIFO_AW_req_transaction_tmp % mem_page_num)
                                        0 : WDATA_tmp[j] = gmem4_mem_0[FIFO_AW_req_ADDR_tmp / data_byte_size + counter][j];
                                        1 : WDATA_tmp[j] = gmem4_mem_1[FIFO_AW_req_ADDR_tmp / data_byte_size + counter][j];
                                        2 : WDATA_tmp[j] = gmem4_mem_2[FIFO_AW_req_ADDR_tmp / data_byte_size + counter][j];
                                        3 : WDATA_tmp[j] = gmem4_mem_3[FIFO_AW_req_ADDR_tmp / data_byte_size + counter][j];
                                        default: $display("The page_num of AXI write is not valid!");
                                    endcase
                                end
                            end
                        end
                        wr_processing_trans_num = FIFO_AW_req_transaction_tmp;
                        wr_processing_addr = FIFO_AW_req_ADDR_tmp/data_byte_size + counter;
                        write_processing = 1;
                        wr_processing_data = WDATA_tmp;
                        case(FIFO_AW_req_transaction_tmp % mem_page_num)
                            0 : gmem4_mem_0[FIFO_AW_req_ADDR_tmp / data_byte_size + counter] <= WDATA_tmp;
                            1 : gmem4_mem_1[FIFO_AW_req_ADDR_tmp / data_byte_size + counter] <= WDATA_tmp;
                            2 : gmem4_mem_2[FIFO_AW_req_ADDR_tmp / data_byte_size + counter] <= WDATA_tmp;
                            3 : gmem4_mem_3[FIFO_AW_req_ADDR_tmp / data_byte_size + counter] <= WDATA_tmp;
                            default: $display("The page_num of AXI write is not valid!");
                        endcase
                        if (counter === output_length && FIFO_WDATA_size_empty != 1 ) begin
                            FIFO_WDATA_size_read <= 1;
                            if(FIFO_WDATA_size_ptr_r != FIFO_DEPTH - 1)
                                FIFO_WDATA_size_ptr_r <= FIFO_WDATA_size_ptr_r + 1;
                            else
                                FIFO_WDATA_size_ptr_r <= 0;
                            WDATA_size_tmp = FIFO_WDATA_size [FIFO_WDATA_size_ptr_r];
                            if (WDATA_size_tmp !== output_length + 1) begin
                                $display ("Burst output data size incorrect.");
                                $finish;
                            end    
                            send_one_BRESP <= 1;
                            BID_tmp <= FIFO_AW_req_ID_tmp;
                        end   
                        counter = counter + 1;
                    end 
                    @(posedge clk);
                    send_one_BRESP <= 0;
                    FIFO_WDATA_read <= 0;
                    FIFO_WDATA_size_read <= 0;
                    write_processing = 0;
                end
            end else begin
                counter = 0;
                output_length = FIFO_AW_req_LEN_tmp;
                while (counter != output_length + 1) begin
                    if (FIFO_WDATA_req_empty != 1) begin 
                        FIFO_WDATA_read <= 1;
                        if(FIFO_WDATA_req_ptr_r != FIFO_DEPTH - 1)
                            FIFO_WDATA_req_ptr_r <= FIFO_WDATA_req_ptr_r + 1;
                        else
                            FIFO_WDATA_req_ptr_r <= 0;
                        FIFO_WDATA_tmp = FIFO_WDATA [FIFO_WDATA_req_ptr_r];
                        FIFO_WSTRB_tmp = FIFO_WSTRB [FIFO_WDATA_req_ptr_r];
                        for (i = 0 ; i < data_byte_size; i = i + 1) begin
                            if (FIFO_WSTRB_tmp[i] == 1) begin 
                                for (j=(i*8); j< (i+1)*8 ; j= j+1) begin
                                    WDATA_tmp[j] = FIFO_WDATA_tmp[j];
                                end
                            end else begin
                                for (j=(i*8); j< (i+1)*8 ; j= j+1) begin
                                    case(FIFO_AW_req_transaction_tmp % mem_page_num)
                                        0 : WDATA_tmp[j] = gmem4_mem_0[FIFO_AW_req_ADDR_tmp / data_byte_size][j];
                                        1 : WDATA_tmp[j] = gmem4_mem_1[FIFO_AW_req_ADDR_tmp / data_byte_size][j];
                                        2 : WDATA_tmp[j] = gmem4_mem_2[FIFO_AW_req_ADDR_tmp / data_byte_size][j];
                                        3 : WDATA_tmp[j] = gmem4_mem_3[FIFO_AW_req_ADDR_tmp / data_byte_size][j];
                                        default: $display("The page_num of AXI write is not valid!");
                                    endcase
                                end
                            end
                        end
                        wr_processing_trans_num = FIFO_AW_req_transaction_tmp;
                        wr_processing_addr = FIFO_AW_req_ADDR_tmp/data_byte_size;
                        write_processing = 1;
                        wr_processing_data = WDATA_tmp;
                        case(FIFO_AW_req_transaction_tmp % mem_page_num)
                            0 : gmem4_mem_0[FIFO_AW_req_ADDR_tmp / data_byte_size] <= WDATA_tmp;
                            1 : gmem4_mem_1[FIFO_AW_req_ADDR_tmp / data_byte_size] <= WDATA_tmp;
                            2 : gmem4_mem_2[FIFO_AW_req_ADDR_tmp / data_byte_size] <= WDATA_tmp;
                            3 : gmem4_mem_3[FIFO_AW_req_ADDR_tmp / data_byte_size] <= WDATA_tmp;
                            default: $display("The page_num of AXI write is not valid!");
                        endcase
                        if (FIFO_WDATA_size_empty != 1 ) begin
                            FIFO_WDATA_size_read <= 1;
                            if(FIFO_WDATA_size_ptr_r != FIFO_DEPTH - 1)
                                FIFO_WDATA_size_ptr_r <= FIFO_WDATA_size_ptr_r + 1;
                            else
                                FIFO_WDATA_size_ptr_r <= 0;
                            WDATA_size_tmp = FIFO_WDATA_size [FIFO_WDATA_size_ptr_r];
                            if (WDATA_size_tmp !== output_length + 1) begin
                                $display ("Burst output data size incorrect.");
                                $finish;
                            end    
                        end    
                        send_one_BRESP <= 1;
                        counter = counter + 1;
                    end 
                    @(posedge clk);
                    send_one_BRESP <= 0;
                    FIFO_WDATA_read <= 0;
                    FIFO_WDATA_size_read <= 0;
                    write_processing = 0;
                end
            end   
        end
    end
end

always @(posedge clk or reset) begin 
    if(reset === 0) begin 
        FIFO_AR_req_read <= 0;
        FIFO_AR_req_ptr_r <= 0;
    end else begin 
        #0.2;
        if (FIFO_AR_req_ptr_r_tmp > FIFO_AR_req_ptr_r) begin
            FIFO_AR_req_read <= 1;
            FIFO_AR_req_ptr_r <= FIFO_AR_req_ptr_r + 1;
        end else if (FIFO_AR_req_ptr_r_tmp == 0 && FIFO_AR_req_ptr_r == FIFO_DEPTH - 1) begin
            FIFO_AR_req_read <= 1;
            FIFO_AR_req_ptr_r <= 0;
        end else begin 
            FIFO_AR_req_read <= 0;
        end
    end 
end

initial begin : AR_request_proc
    integer counter;
    integer i;
    integer data_byte_size;
    integer input_length;
    integer FIFO_AR_req_transaction_tmp;
    integer FIFO_AR_req_clk_tmp;
    @(posedge clk);

    while (1) begin
        RVALID_tmp <= 0;
        RID_tmp <= 0;
        if (FIFO_AR_req_empty) begin
            @(posedge clk);
        end else begin
            if(FIFO_AR_req_ptr_r_tmp != FIFO_DEPTH - 1)
                FIFO_AR_req_ptr_r_tmp = FIFO_AR_req_ptr_r_tmp + 1;
            else
                FIFO_AR_req_ptr_r_tmp = 0;

            FIFO_AR_req_ADDR_tmp    =  FIFO_AR_req_ADDR [FIFO_AR_req_ptr_r]  ;
            FIFO_AR_req_SIZE_tmp    =  FIFO_AR_req_SIZE [FIFO_AR_req_ptr_r]  ;
            FIFO_AR_req_LEN_tmp     =  FIFO_AR_req_LEN  [FIFO_AR_req_ptr_r]  ; 
            FIFO_AR_req_BURST_tmp   =  FIFO_AR_req_BURST[FIFO_AR_req_ptr_r]  ;
            FIFO_AR_req_ID_tmp      =  FIFO_AR_req_ID[FIFO_AR_req_ptr_r]  ;
            FIFO_AR_req_transaction_tmp   =  FIFO_AR_req_transaction_number[FIFO_AR_req_ptr_r]  ;
            FIFO_AR_req_clk_tmp     =  FIFO_AR_req_cycle_number[FIFO_AR_req_ptr_r]  ;
            while (clk_counter < FIFO_AR_req_clk_tmp + ReadReqLatency ) begin
                @(posedge clk);
            end

            data_byte_size = 1;
            for (i=0;i<FIFO_AR_req_SIZE_tmp; i=i+1) begin
                data_byte_size = data_byte_size * 2;
            end

            if (FIFO_AR_req_ADDR_tmp/data_byte_size > gmem4_mem_depth) begin
                $display ("/home/romoirib/QP/spmv_csc_tmp/spmv_csc/spmv_csc/hls/sim/verilog/AESL_axi_master_gmem4.v: Read request address %d exceed AXI master gmem4 array depth: %d",FIFO_AR_req_ADDR_tmp/data_byte_size, gmem4_mem_depth); 
                $finish;
            end

            if (FIFO_AR_req_BURST_tmp === 1) begin
                counter = 0;
                RLAST_tmp <= 0;
                input_length = FIFO_AR_req_LEN_tmp;
                while (counter != input_length + 1) begin
                    @(negedge clk);
                    rd_processing_addr = FIFO_AR_req_ADDR_tmp/data_byte_size + counter;
                    if ((write_processing == 1) && (wr_processing_addr == rd_processing_addr) && (wr_processing_trans_num == FIFO_AR_req_transaction_tmp))
                        RDATA_tmp <= wr_processing_data;
                    else
                        case(FIFO_AR_req_transaction_tmp % mem_page_num)
                            0 : RDATA_tmp <= gmem4_mem_0[FIFO_AR_req_ADDR_tmp / data_byte_size +   counter] ;
                            1 : RDATA_tmp <= gmem4_mem_1[FIFO_AR_req_ADDR_tmp / data_byte_size +   counter] ;
                            2 : RDATA_tmp <= gmem4_mem_2[FIFO_AR_req_ADDR_tmp / data_byte_size +   counter] ;
                            3 : RDATA_tmp <= gmem4_mem_3[FIFO_AR_req_ADDR_tmp / data_byte_size +   counter] ;
                            default: $display("The page_num of AXI read is not valid!");
                        endcase
                    RVALID_tmp <= 1;
                    RID_tmp <= FIFO_AR_req_ID_tmp;
                    RRESP_tmp <= 0;
                    if (counter === input_length ) begin
                        RLAST_tmp <= 1;
                    end else begin
                        RLAST_tmp <= 0;
                    end
                        
                    @(posedge clk);
                    if (RVALID_tmp && TRAN_gmem4_RREADY) begin
                        counter = counter + 1;
                    end 
                end
                RVALID_tmp <= 0;
                RLAST_tmp <= 0;
            end else begin
                counter = 0;
                RLAST_tmp <= 0;
                input_length = FIFO_AR_req_LEN_tmp;
                while (counter != input_length + 1) begin
                    @(negedge clk);
                    rd_processing_addr = FIFO_AR_req_ADDR_tmp/data_byte_size;
                    if ((write_processing == 1) && (wr_processing_addr == rd_processing_addr) && (wr_processing_trans_num == FIFO_AR_req_transaction_tmp))
                        RDATA_tmp <= wr_processing_data;
                    else
                        case(FIFO_AR_req_transaction_tmp % mem_page_num)
                            0 : RDATA_tmp <= gmem4_mem_0[FIFO_AR_req_ADDR_tmp / data_byte_size ] ;
                            1 : RDATA_tmp <= gmem4_mem_1[FIFO_AR_req_ADDR_tmp / data_byte_size ] ;
                            2 : RDATA_tmp <= gmem4_mem_2[FIFO_AR_req_ADDR_tmp / data_byte_size ] ;
                            3 : RDATA_tmp <= gmem4_mem_3[FIFO_AR_req_ADDR_tmp / data_byte_size ] ;
                            default: $display("The page_num of AXI read is not valid!");
                        endcase
                    RVALID_tmp <= 1;
                    RRESP_tmp <= 0;
                    RLAST_tmp <= 1;
                    @(posedge clk);
                    if (RVALID_tmp && TRAN_gmem4_RREADY) begin
                        counter = counter + 1;
                    end 
                end
                RVALID_tmp <= 0;
                RLAST_tmp <= 0;
            end    
        end
    end
end

//------------------------Task and function--------------


 function is_blank_char(input [7:0] in_char);
     if (in_char == " " || in_char == "\011" || in_char == "\012" || in_char == "\015") begin
         is_blank_char = 1;
     end else begin
         is_blank_char = 0;
     end
 endfunction

    function [1047:0] read_token(input integer fp);
        integer ret;
        begin
            read_token = "";
                    ret = 0;
                    ret = $fscanf(fp,"%s",read_token);
        end
    endfunction

 function [1047:0] rm_0x(input [1047:0] token);
     reg [1047:0] token_tmp;
     integer i;
     begin
         token_tmp = "";
         for (i = 0; token[15:0] != "0x"; token = token >> 8) begin
             token_tmp = (token[7:0] << (8 * i)) | token_tmp;
             i = i + 1;
         end
         rm_0x = token_tmp;
     end
 endfunction

task write_binary;
    input integer fp;
    input reg[512-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[512-1:0] local_in;
    integer char_num;
    integer long_num;
    integer i;
    integer j;
    begin
        long_num = (in_bw + 63) / 64;
        char_num = ((in_bw - 1) % 64 + 7) / 8;
        for(i=long_num;i>0;i=i-1) begin
             local_in = in;
             tmp_long = local_in >> ((i-1)*64);
             for(j=0;j<64;j=j+1)
                 if (tmp_long[j] === 1'bx)
                     tmp_long[j] = 1'b0;
             if (i == long_num) begin
                 case(char_num)
                     1: $fwrite(fp,"%c",tmp_long[7:0]);
                     2: $fwrite(fp,"%c%c",tmp_long[15:8],tmp_long[7:0]);
                     3: $fwrite(fp,"%c%c%c",tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
                     4: $fwrite(fp,"%c%c%c%c",tmp_long[31:24],tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
                     5: $fwrite(fp,"%c%c%c%c%c",tmp_long[39:32],tmp_long[31:24],tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
                     6: $fwrite(fp,"%c%c%c%c%c%c",tmp_long[47:40],tmp_long[39:32],tmp_long[31:24],tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
                     7: $fwrite(fp,"%c%c%c%c%c%c%c",tmp_long[55:48],tmp_long[47:40],tmp_long[39:32],tmp_long[31:24],tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
                     8: $fwrite(fp,"%c%c%c%c%c%c%c%c",tmp_long[63:56],tmp_long[55:48],tmp_long[47:40],tmp_long[39:32],tmp_long[31:24],tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
                     default: ;
                 endcase
             end
             else begin
                 $fwrite(fp,"%c%c%c%c%c%c%c%c",tmp_long[63:56],tmp_long[55:48],tmp_long[47:40],tmp_long[39:32],tmp_long[31:24],tmp_long[23:16],tmp_long[15:8],tmp_long[7:0]);
             end
        end
    end
endtask;

integer gmem4_port0_fresh_depth[0:1];
integer gmem4_port0_blank_depth[0:1];

initial begin : runtime_depth_init_process
    gmem4_port0_fresh_depth[0] = 64;
    gmem4_port0_blank_depth[0] = 0;
end
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_file_process 
  integer fp; 
  reg [ 100*8 : 1] str;
  reg [63:0] trans_depth;
  integer err; 
  integer ret; 
  integer transaction_num; 
  integer read_idx;
  integer port_idx;
  integer mem_page; 
  reg [512 - 1 : 0] token_tmp; 
  reg [gmem4_DATA_BITWIDTH - 1 : 0] mem_tmp; 
  integer i; 
  reg [1 - 1 : 0] port_read_done;
  reg [1 - 1 : 0] port_fill_done;
  transaction_num = 0;
  port_read_done = 'd0;
  port_fill_done = 'd0;
  fp = $fopen(`TV_IN_gmem4,"rb"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_gmem4); 
      $finish; 
  end 
  ret = $fread(trans_depth,fp);
  while (trans_depth != 64'h5a5aa5a50f0ff0f0)  begin
      @(posedge clk);
      # 0.2;
      while(ready !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      mem_page = transaction_num % mem_page_num ;
      mem_tmp[gmem4_DATA_BITWIDTH - 1: 0] = 0;
      read_idx = 0;
      port_idx = 0;
      for(i = 0; i < gmem4_transaction_depth; i = i + 1) begin 
              if (port_idx == 0) begin
                  if (port_read_done[port_idx] == 1'b0 && read_idx == gmem4_port0_fresh_depth[transaction_num]) begin
                      port_read_done[port_idx] = 1'b1;
                      read_idx = 0;
                  end
                  if (port_read_done[port_idx] == 1'b0 && read_idx < gmem4_port0_fresh_depth[transaction_num]) begin
          ret = $fread(token_tmp,fp);
                      read_idx = read_idx + 1;
                  end
                  if (port_fill_done[port_idx] == 1'b0 && port_read_done[port_idx] == 1'b1 && read_idx == gmem4_port0_blank_depth[transaction_num]) begin
                      port_fill_done[port_idx] = 1'b1;
                      port_idx = port_idx + 1;
                      read_idx = 0;
                  end
                  if (port_fill_done[port_idx] == 1'b0 && port_read_done[port_idx] == 1'b1 && read_idx < gmem4_port0_blank_depth[transaction_num]) begin
                      token_tmp = 'd0;
                      read_idx = read_idx + 1;
                  end
              end
          if (i%1 == 0) begin
              mem_tmp[511 : 0] = token_tmp;
          end
          if (i%1 == 0) begin
              case(mem_page)
                  0 : gmem4_mem_0[i/1] = mem_tmp;
                  1 : gmem4_mem_1[i/1] = mem_tmp;
                  2 : gmem4_mem_2[i/1] = mem_tmp;
                  3 : gmem4_mem_3[i/1] = mem_tmp;
                  default: $display("The page_num of read file is not valid!");
              endcase
              mem_tmp[gmem4_DATA_BITWIDTH - 1 : 0] = 0;
          end
      end 
      ret = $fread(trans_depth,fp);
      transaction_num = transaction_num + 1;
      port_read_done = 'd0;
      port_fill_done = 'd0;
  end 
  $fclose(fp); 
end 
 
integer gmem4_cur_trans_depth[0:1];

initial begin : out_depth_init_process
    gmem4_cur_trans_depth[0] = 64;
end
//------------------------Write file----------------------- 
 
// Write data to file 
 
initial begin : write_file_proc 
  integer fp; 
  reg [ 100*8 : 1] str;
  integer transaction_num; 
  integer i; 
  integer j; 
  integer port_idx;
  integer write_idx;
  integer mem_page; 
  reg [gmem4_C_DATA_BITWIDTH - 1 : 0] mem_tmp; 
  reg [gmem4_DATA_BITWIDTH - 1 : 0] tmp_data;
  reg write_ready;
  reg [512-1:0] bin_data;
  reg [1 - 1 : 0] port_write_done;
  reg [1 - 1 : 0] port_fill_done;
  transaction_num = 0; 
  while(1) begin 
      @(posedge clk);
      while(done !== 1) begin
          @(posedge clk);
      end
      mem_page = transaction_num % mem_page_num ;
      # 0.1;
      write_idx = 0;
      port_idx = 0;
      port_write_done = 'd0;
      port_fill_done = 'd0;
      write_ready = 1'b1;
      fp = $fopen(`TV_OUT_gmem4, "ab"); 
      if(fp == 0) begin       // Failed to open file 
          $display("Failed to open file \"%s\"!", `TV_OUT_gmem4); 
          $finish; 
      end 
      bin_data = gmem4_cur_trans_depth[transaction_num];
      write_binary(fp,bin_data,64);
      for(i = 0; i < gmem4_mem_depth; i = i + 1) begin 
          case(mem_page)
              0 : tmp_data = gmem4_mem_0[i];
              1 : tmp_data = gmem4_mem_1[i];
              2 : tmp_data = gmem4_mem_2[i];
              3 : tmp_data = gmem4_mem_3[i];
              default: $display("The page_num of write file is not valid!");
          endcase
          
          for (j=0;j<1;j=j+1) begin
              case(j%1)
                  0: mem_tmp = tmp_data[511:0];
              endcase
              if (port_idx == 0) begin
                  if (port_write_done[port_idx] == 1'b0 && write_idx == gmem4_port0_fresh_depth[transaction_num]) begin
                      port_write_done[port_idx] = 1'b1;
                      write_idx = 0;
                      write_ready = 1'b0;
                  end
                  if (port_write_done[port_idx] == 1'b0 && write_idx < gmem4_port0_fresh_depth[transaction_num]) begin
                      write_idx = write_idx + 1;
                      write_ready = 1'b1;
                  end
                  if (port_fill_done[port_idx] == 1'b0 && port_write_done[port_idx] == 1'b1 && write_idx == gmem4_port0_blank_depth[transaction_num]) begin
                      write_idx = 0;
                      port_fill_done[port_idx] = 1'b1;
                      port_idx = port_idx + 1;
                  end
                  if (port_fill_done[port_idx] == 1'b0 && port_write_done[port_idx] == 1'b1 && write_idx < gmem4_port0_blank_depth[transaction_num]) begin
                      write_idx = write_idx + 1;
                  end
              end
              if (write_ready == 1'b1) begin
              bin_data = mem_tmp;
              write_binary(fp,bin_data,512);
          end
      end
      end
      
      
      transaction_num = transaction_num + 1;
      $fclose(fp); 
  end 
end 
endmodule
