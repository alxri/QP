// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

`timescale 1 ns / 1 ps

module AESL_axi_slave_control (
    clk,
    reset,
    TRAN_s_axi_control_AWADDR,
    TRAN_s_axi_control_AWVALID,
    TRAN_s_axi_control_AWREADY,
    TRAN_s_axi_control_WVALID,
    TRAN_s_axi_control_WREADY,
    TRAN_s_axi_control_WDATA,
    TRAN_s_axi_control_WSTRB,
    TRAN_s_axi_control_ARADDR,
    TRAN_s_axi_control_ARVALID,
    TRAN_s_axi_control_ARREADY,
    TRAN_s_axi_control_RVALID,
    TRAN_s_axi_control_RREADY,
    TRAN_s_axi_control_RDATA,
    TRAN_s_axi_control_RRESP,
    TRAN_s_axi_control_BVALID,
    TRAN_s_axi_control_BREADY,
    TRAN_s_axi_control_BRESP,
    TRAN_control_write_data_finish,
    TRAN_control_start_in,
    TRAN_control_idle_out,
    TRAN_control_ready_out,
    TRAN_control_ready_in,
    TRAN_control_done_out,
    TRAN_control_write_start_in   ,
    TRAN_control_write_start_finish,
    TRAN_control_interrupt,
    TRAN_control_transaction_done_in
    );

//------------------------Parameter----------------------
`define TV_IN_num_rows "../tv/cdatafile/c.spmv_csc.autotvin_num_rows.dat"
`define TV_IN_num_cols "../tv/cdatafile/c.spmv_csc.autotvin_num_cols.dat"
`define TV_IN_nnz "../tv/cdatafile/c.spmv_csc.autotvin_nnz.dat"
`define TV_IN_A_row_idx "../tv/cdatafile/c.spmv_csc.autotvin_A_row_idx.dat"
`define TV_IN_A_col_ptr "../tv/cdatafile/c.spmv_csc.autotvin_A_col_ptr.dat"
`define TV_IN_A_values "../tv/cdatafile/c.spmv_csc.autotvin_A_values.dat"
`define TV_IN_x "../tv/cdatafile/c.spmv_csc.autotvin_x.dat"
`define TV_IN_y "../tv/cdatafile/c.spmv_csc.autotvin_y.dat"
parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 32;
parameter num_rows_DEPTH = 1;
reg [31 : 0] num_rows_OPERATE_DEPTH = 0;
parameter num_rows_c_bitwidth = 32;
parameter num_cols_DEPTH = 1;
reg [31 : 0] num_cols_OPERATE_DEPTH = 0;
parameter num_cols_c_bitwidth = 32;
parameter nnz_DEPTH = 1;
reg [31 : 0] nnz_OPERATE_DEPTH = 0;
parameter nnz_c_bitwidth = 32;
parameter A_row_idx_DEPTH = 1;
reg [31 : 0] A_row_idx_OPERATE_DEPTH = 0;
parameter A_row_idx_c_bitwidth = 64;
parameter A_col_ptr_DEPTH = 1;
reg [31 : 0] A_col_ptr_OPERATE_DEPTH = 0;
parameter A_col_ptr_c_bitwidth = 64;
parameter A_values_DEPTH = 1;
reg [31 : 0] A_values_OPERATE_DEPTH = 0;
parameter A_values_c_bitwidth = 64;
parameter x_DEPTH = 1;
reg [31 : 0] x_OPERATE_DEPTH = 0;
parameter x_c_bitwidth = 64;
parameter y_DEPTH = 1;
reg [31 : 0] y_OPERATE_DEPTH = 0;
parameter y_c_bitwidth = 64;
parameter START_ADDR = 0;
parameter spmv_csc_continue_addr = 0;
parameter spmv_csc_auto_start_addr = 0;
parameter num_rows_data_in_addr = 16;
parameter num_cols_data_in_addr = 24;
parameter nnz_data_in_addr = 32;
parameter A_row_idx_data_in_addr = 40;
parameter A_col_ptr_data_in_addr = 52;
parameter A_values_data_in_addr = 64;
parameter x_data_in_addr = 76;
parameter y_data_in_addr = 88;
parameter STATUS_ADDR = 0;

output [ADDR_WIDTH - 1 : 0] TRAN_s_axi_control_AWADDR;
output  TRAN_s_axi_control_AWVALID;
input  TRAN_s_axi_control_AWREADY;
output  TRAN_s_axi_control_WVALID;
input  TRAN_s_axi_control_WREADY;
output [DATA_WIDTH - 1 : 0] TRAN_s_axi_control_WDATA;
output [DATA_WIDTH/8 - 1 : 0] TRAN_s_axi_control_WSTRB;
output [ADDR_WIDTH - 1 : 0] TRAN_s_axi_control_ARADDR;
output  TRAN_s_axi_control_ARVALID;
input  TRAN_s_axi_control_ARREADY;
input  TRAN_s_axi_control_RVALID;
output  TRAN_s_axi_control_RREADY;
input [DATA_WIDTH - 1 : 0] TRAN_s_axi_control_RDATA;
input [2 - 1 : 0] TRAN_s_axi_control_RRESP;
input  TRAN_s_axi_control_BVALID;
output  TRAN_s_axi_control_BREADY;
input [2 - 1 : 0] TRAN_s_axi_control_BRESP;
output TRAN_control_write_data_finish;
input     clk;
input     reset;
input     TRAN_control_start_in;
output    TRAN_control_done_out;
output    TRAN_control_ready_out;
input     TRAN_control_ready_in;
output    TRAN_control_idle_out;
input  TRAN_control_write_start_in   ;
output TRAN_control_write_start_finish;
input     TRAN_control_interrupt;
input     TRAN_control_transaction_done_in;

reg [ADDR_WIDTH - 1 : 0] AWADDR_reg = 0;
reg  AWVALID_reg = 0;
reg  WVALID_reg = 0;
reg [DATA_WIDTH - 1 : 0] WDATA_reg = 0;
reg [DATA_WIDTH/8 - 1 : 0] WSTRB_reg = 0;
reg [ADDR_WIDTH - 1 : 0] ARADDR_reg = 0;
reg  ARVALID_reg = 0;
reg  RREADY_reg = 0;
reg [DATA_WIDTH - 1 : 0] RDATA_reg = 0;
reg  BREADY_reg = 0;
reg [DATA_WIDTH - 1 : 0] mem_num_rows [num_rows_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_num_rows [ (num_rows_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * num_rows_DEPTH -1 : 0] = '{default : 'hz};
reg num_rows_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_num_cols [num_cols_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_num_cols [ (num_cols_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * num_cols_DEPTH -1 : 0] = '{default : 'hz};
reg num_cols_write_data_finish;
reg [DATA_WIDTH - 1 : 0] mem_nnz [nnz_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_nnz [ (nnz_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * nnz_DEPTH -1 : 0] = '{default : 'hz};
reg nnz_write_data_finish;
reg [A_row_idx_c_bitwidth - 1 : 0] mem_A_row_idx [A_row_idx_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_A_row_idx [ (A_row_idx_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * A_row_idx_DEPTH -1 : 0] = '{default : 'hz};
reg A_row_idx_write_data_finish;
reg [A_col_ptr_c_bitwidth - 1 : 0] mem_A_col_ptr [A_col_ptr_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_A_col_ptr [ (A_col_ptr_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * A_col_ptr_DEPTH -1 : 0] = '{default : 'hz};
reg A_col_ptr_write_data_finish;
reg [A_values_c_bitwidth - 1 : 0] mem_A_values [A_values_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_A_values [ (A_values_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * A_values_DEPTH -1 : 0] = '{default : 'hz};
reg A_values_write_data_finish;
reg [x_c_bitwidth - 1 : 0] mem_x [x_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_x [ (x_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * x_DEPTH -1 : 0] = '{default : 'hz};
reg x_write_data_finish;
reg [y_c_bitwidth - 1 : 0] mem_y [y_DEPTH - 1 : 0] = '{default : 'h0};
reg [DATA_WIDTH-1 : 0] image_mem_y [ (y_c_bitwidth+DATA_WIDTH-1)/DATA_WIDTH * y_DEPTH -1 : 0] = '{default : 'hz};
reg y_write_data_finish;
reg AESL_ready_out_index_reg = 0;
reg AESL_write_start_finish = 0;
reg AESL_ready_reg;
reg ready_initial;
reg AESL_done_index_reg = 0;
reg AESL_idle_index_reg = 0;
reg AESL_auto_restart_index_reg;
reg process_0_finish = 0;
reg process_1_finish = 0;
reg process_2_finish = 0;
reg process_3_finish = 0;
reg process_4_finish = 0;
reg process_5_finish = 0;
reg process_6_finish = 0;
reg process_7_finish = 0;
reg process_8_finish = 0;
reg process_9_finish = 0;
//write num_rows reg
reg [31 : 0] write_num_rows_count = 0;
reg [31 : 0] num_rows_diff_count = 0;
reg write_num_rows_run_flag = 0;
reg write_one_num_rows_data_done = 0;
//write num_cols reg
reg [31 : 0] write_num_cols_count = 0;
reg [31 : 0] num_cols_diff_count = 0;
reg write_num_cols_run_flag = 0;
reg write_one_num_cols_data_done = 0;
//write nnz reg
reg [31 : 0] write_nnz_count = 0;
reg [31 : 0] nnz_diff_count = 0;
reg write_nnz_run_flag = 0;
reg write_one_nnz_data_done = 0;
//write A_row_idx reg
reg [31 : 0] write_A_row_idx_count = 0;
reg [31 : 0] A_row_idx_diff_count = 0;
reg write_A_row_idx_run_flag = 0;
reg write_one_A_row_idx_data_done = 0;
//write A_col_ptr reg
reg [31 : 0] write_A_col_ptr_count = 0;
reg [31 : 0] A_col_ptr_diff_count = 0;
reg write_A_col_ptr_run_flag = 0;
reg write_one_A_col_ptr_data_done = 0;
//write A_values reg
reg [31 : 0] write_A_values_count = 0;
reg [31 : 0] A_values_diff_count = 0;
reg write_A_values_run_flag = 0;
reg write_one_A_values_data_done = 0;
//write x reg
reg [31 : 0] write_x_count = 0;
reg [31 : 0] x_diff_count = 0;
reg write_x_run_flag = 0;
reg write_one_x_data_done = 0;
//write y reg
reg [31 : 0] write_y_count = 0;
reg [31 : 0] y_diff_count = 0;
reg write_y_run_flag = 0;
reg write_one_y_data_done = 0;
reg [31 : 0] write_start_count = 0;
reg write_start_run_flag = 0;

//===================process control=================
reg [31 : 0] ongoing_process_number = 0;
//process number depends on how much processes needed.
reg process_busy = 0;

//=================== signal connection ==============
assign TRAN_s_axi_control_AWADDR = AWADDR_reg;
assign TRAN_s_axi_control_AWVALID = AWVALID_reg;
assign TRAN_s_axi_control_WVALID = WVALID_reg;
assign TRAN_s_axi_control_WDATA = WDATA_reg;
assign TRAN_s_axi_control_WSTRB = WSTRB_reg;
assign TRAN_s_axi_control_ARADDR = ARADDR_reg;
assign TRAN_s_axi_control_ARVALID = ARVALID_reg;
assign TRAN_s_axi_control_RREADY = RREADY_reg;
assign TRAN_s_axi_control_BREADY = BREADY_reg;
assign TRAN_control_write_start_finish = AESL_write_start_finish;
assign TRAN_control_done_out = AESL_done_index_reg;
assign TRAN_control_ready_out = AESL_ready_out_index_reg;
assign TRAN_control_idle_out = AESL_idle_index_reg;
assign TRAN_control_write_data_finish = 1 & num_rows_write_data_finish & num_cols_write_data_finish & nnz_write_data_finish & A_row_idx_write_data_finish & A_col_ptr_write_data_finish & A_values_write_data_finish & x_write_data_finish & y_write_data_finish;
always @(TRAN_control_ready_in or ready_initial) 
begin
    AESL_ready_reg <= TRAN_control_ready_in | ready_initial;
end

always @(reset or process_0_finish or process_1_finish or process_2_finish or process_3_finish or process_4_finish or process_5_finish or process_6_finish or process_7_finish or process_8_finish or process_9_finish ) begin
    if (reset == 0) begin
        ongoing_process_number <= 0;
    end
    else if (ongoing_process_number == 0 && process_0_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 1 && process_1_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 2 && process_2_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 3 && process_3_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 4 && process_4_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 5 && process_5_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 6 && process_6_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 7 && process_7_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 8 && process_8_finish == 1) begin
            ongoing_process_number <= ongoing_process_number + 1;
    end
    else if (ongoing_process_number == 9 && process_9_finish == 1) begin
            ongoing_process_number <= 0;
    end
end

task count_c_data_four_byte_num_by_bitwidth;
input  integer bitwidth;
output integer num;
integer factor;
integer i;
begin
    factor = 32;
    for (i = 1; i <= 1024; i = i + 1) begin
        if (bitwidth <= factor && bitwidth > factor - 32) begin
            num = i;
        end
        factor = factor + 32;
    end
end    
endtask

function integer ceil_align_to_pow_of_two;
input integer a;
begin
    ceil_align_to_pow_of_two = $pow(2,$clog2(a));
end
endfunction

task count_seperate_factor_by_bitwidth;
input  integer bitwidth;
output integer factor;
begin
    if (bitwidth <= 8) begin
        factor=4;
    end
    if (bitwidth <= 16 & bitwidth > 8 ) begin
        factor=2;
    end
    if (bitwidth <= 32 & bitwidth > 16 ) begin
        factor=1;
    end
    if (bitwidth > 32 ) begin
        factor=1;
    end
end    
endtask

task count_operate_depth_by_bitwidth_and_depth;
input  integer bitwidth;
input  integer depth;
output integer operate_depth;
integer factor;
integer remain;
begin
    count_seperate_factor_by_bitwidth (bitwidth , factor);
    operate_depth = depth / factor;
    remain = depth % factor;
    if (remain > 0) begin
        operate_depth = operate_depth + 1;
    end
end    
endtask

task write; /*{{{*/
    input  reg [ADDR_WIDTH - 1:0] waddr;   // write address
    input  reg [DATA_WIDTH - 1:0] wdata;   // write data
    output reg wresp;
    reg aw_flag;
    reg w_flag;
    reg [DATA_WIDTH/8 - 1:0] wstrb_reg;
    integer i;
begin 
    wresp = 0;
    aw_flag = 0;
    w_flag = 0;
//=======================one single write operate======================
    AWADDR_reg <= waddr;
    AWVALID_reg <= 1;
    WDATA_reg <= wdata;
    WVALID_reg <= 1;
    for (i = 0; i < DATA_WIDTH/8; i = i + 1) begin
        wstrb_reg [i] = 1;
    end    
    WSTRB_reg <= wstrb_reg;
    while (!(aw_flag && w_flag)) begin
        @(posedge clk);
        if (aw_flag != 1)
            aw_flag = TRAN_s_axi_control_AWREADY & AWVALID_reg;
        if (w_flag != 1)
            w_flag = TRAN_s_axi_control_WREADY & WVALID_reg;
        AWVALID_reg <= !aw_flag;
        WVALID_reg <= !w_flag;
    end

    BREADY_reg <= 1;
    while (TRAN_s_axi_control_BVALID != 1) begin
        //wait for response 
        @(posedge clk);
    end
    @(posedge clk);
    BREADY_reg <= 0;
    if (TRAN_s_axi_control_BRESP === 2'b00) begin
        wresp = 1;
        //input success. in fact BRESP is always 2'b00
    end   
//=======================one single write operate======================

end
endtask/*}}}*/

task read (/*{{{*/
    input  [ADDR_WIDTH - 1:0] raddr ,   // write address
    output [DATA_WIDTH - 1:0] RDATA_result ,
    output rresp
);
begin 
    rresp = 0;
//=======================one single read operate======================
    ARADDR_reg <= raddr;
    ARVALID_reg <= 1;
    while (TRAN_s_axi_control_ARREADY !== 1) begin
        @(posedge clk);
    end
    @(posedge clk);
    ARVALID_reg <= 0;
    RREADY_reg <= 1;
    while (TRAN_s_axi_control_RVALID !== 1) begin
        //wait for response 
        @(posedge clk);
    end
    @(posedge clk);
    RDATA_result  <= TRAN_s_axi_control_RDATA;
    RREADY_reg <= 0;
    if (TRAN_s_axi_control_RRESP === 2'b00 ) begin
        rresp <= 1;
        //output success. in fact RRESP is always 2'b00
    end  
    @(posedge clk);

//=======================one single read operate end======================

end
endtask/*}}}*/

initial begin : ready_initial_process
    ready_initial = 0;
    wait(reset === 1);
    @(posedge clk);
    ready_initial = 1;
    @(posedge clk);
    ready_initial = 0;
end

initial begin : update_status
    integer process_num ;
    integer read_status_resp;
    wait(reset === 1);
    @(posedge clk);
    process_num = 0;
    while (1) begin
        process_0_finish = 0;
        AESL_done_index_reg         <= 0;
        AESL_ready_out_index_reg        <= 0;
        if (ongoing_process_number === process_num && process_busy === 0) begin
            process_busy = 1;
            read (STATUS_ADDR, RDATA_reg, read_status_resp);
                AESL_done_index_reg         <= RDATA_reg[1 : 1];
                AESL_ready_out_index_reg    <= RDATA_reg[1 : 1];
                AESL_idle_index_reg         <= RDATA_reg[2 : 2];
            process_0_finish = 1;
            process_busy = 0;
        end 
        @(posedge clk);
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_num_rows_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (num_rows_c_bitwidth, num_rows_DEPTH, num_rows_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_num_rows_run_flag <= 1; 
        end
        else if ((write_one_num_rows_data_done == 1 && write_num_rows_count == num_rows_diff_count - 1) || num_rows_diff_count == 0) begin
            write_num_rows_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_num_rows_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_num_rows_count = 0;
        end
        if (write_one_num_rows_data_done === 1) begin
            write_num_rows_count = write_num_rows_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        num_rows_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            num_rows_write_data_finish <= 0;
        end
        if (write_num_rows_run_flag == 1 && write_num_rows_count == num_rows_diff_count) begin
            num_rows_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_num_rows
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] num_rows_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = num_rows_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        num_rows_diff_count = 0;

        for (k = 0; k < num_rows_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (num_rows_c_bitwidth < 32) begin
                    num_rows_data_tmp_reg = mem_num_rows[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < num_rows_c_bitwidth) begin
                            num_rows_data_tmp_reg[j] = mem_num_rows[k][i*32 + j];
                        end
                        else begin
                            num_rows_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_num_rows[k * four_byte_num  + i]!==num_rows_data_tmp_reg) begin
                num_rows_diff_count = num_rows_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_num_rows
    integer write_num_rows_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_num_rows_count;
    reg [31 : 0] num_rows_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = num_rows_c_bitwidth;
    process_num = 1;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_1_finish <= 0;

        for (check_num_rows_count = 0; check_num_rows_count < num_rows_OPERATE_DEPTH; check_num_rows_count = check_num_rows_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_num_rows_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write num_rows data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (num_rows_c_bitwidth < 32) begin
                        num_rows_data_tmp_reg = mem_num_rows[check_num_rows_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < num_rows_c_bitwidth) begin
                                num_rows_data_tmp_reg[j] = mem_num_rows[check_num_rows_count][i*32 + j];
                            end
                            else begin
                                num_rows_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_num_rows[check_num_rows_count * four_byte_num  + i]!==num_rows_data_tmp_reg) begin
                        image_mem_num_rows[check_num_rows_count * four_byte_num + i]=num_rows_data_tmp_reg;
                        write (num_rows_data_in_addr + check_num_rows_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, num_rows_data_tmp_reg, write_num_rows_resp);
                        write_one_num_rows_data_done <= 1;
                        @(posedge clk);
                        write_one_num_rows_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_1_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_num_cols_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (num_cols_c_bitwidth, num_cols_DEPTH, num_cols_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_num_cols_run_flag <= 1; 
        end
        else if ((write_one_num_cols_data_done == 1 && write_num_cols_count == num_cols_diff_count - 1) || num_cols_diff_count == 0) begin
            write_num_cols_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_num_cols_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_num_cols_count = 0;
        end
        if (write_one_num_cols_data_done === 1) begin
            write_num_cols_count = write_num_cols_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        num_cols_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            num_cols_write_data_finish <= 0;
        end
        if (write_num_cols_run_flag == 1 && write_num_cols_count == num_cols_diff_count) begin
            num_cols_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_num_cols
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] num_cols_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = num_cols_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        num_cols_diff_count = 0;

        for (k = 0; k < num_cols_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (num_cols_c_bitwidth < 32) begin
                    num_cols_data_tmp_reg = mem_num_cols[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < num_cols_c_bitwidth) begin
                            num_cols_data_tmp_reg[j] = mem_num_cols[k][i*32 + j];
                        end
                        else begin
                            num_cols_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_num_cols[k * four_byte_num  + i]!==num_cols_data_tmp_reg) begin
                num_cols_diff_count = num_cols_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_num_cols
    integer write_num_cols_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_num_cols_count;
    reg [31 : 0] num_cols_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = num_cols_c_bitwidth;
    process_num = 2;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_2_finish <= 0;

        for (check_num_cols_count = 0; check_num_cols_count < num_cols_OPERATE_DEPTH; check_num_cols_count = check_num_cols_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_num_cols_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write num_cols data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (num_cols_c_bitwidth < 32) begin
                        num_cols_data_tmp_reg = mem_num_cols[check_num_cols_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < num_cols_c_bitwidth) begin
                                num_cols_data_tmp_reg[j] = mem_num_cols[check_num_cols_count][i*32 + j];
                            end
                            else begin
                                num_cols_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_num_cols[check_num_cols_count * four_byte_num  + i]!==num_cols_data_tmp_reg) begin
                        image_mem_num_cols[check_num_cols_count * four_byte_num + i]=num_cols_data_tmp_reg;
                        write (num_cols_data_in_addr + check_num_cols_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, num_cols_data_tmp_reg, write_num_cols_resp);
                        write_one_num_cols_data_done <= 1;
                        @(posedge clk);
                        write_one_num_cols_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_2_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_nnz_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (nnz_c_bitwidth, nnz_DEPTH, nnz_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_nnz_run_flag <= 1; 
        end
        else if ((write_one_nnz_data_done == 1 && write_nnz_count == nnz_diff_count - 1) || nnz_diff_count == 0) begin
            write_nnz_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_nnz_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_nnz_count = 0;
        end
        if (write_one_nnz_data_done === 1) begin
            write_nnz_count = write_nnz_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        nnz_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            nnz_write_data_finish <= 0;
        end
        if (write_nnz_run_flag == 1 && write_nnz_count == nnz_diff_count) begin
            nnz_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_nnz
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] nnz_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = nnz_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        nnz_diff_count = 0;

        for (k = 0; k < nnz_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (nnz_c_bitwidth < 32) begin
                    nnz_data_tmp_reg = mem_nnz[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < nnz_c_bitwidth) begin
                            nnz_data_tmp_reg[j] = mem_nnz[k][i*32 + j];
                        end
                        else begin
                            nnz_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_nnz[k * four_byte_num  + i]!==nnz_data_tmp_reg) begin
                nnz_diff_count = nnz_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_nnz
    integer write_nnz_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_nnz_count;
    reg [31 : 0] nnz_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = nnz_c_bitwidth;
    process_num = 3;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_3_finish <= 0;

        for (check_nnz_count = 0; check_nnz_count < nnz_OPERATE_DEPTH; check_nnz_count = check_nnz_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_nnz_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write nnz data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (nnz_c_bitwidth < 32) begin
                        nnz_data_tmp_reg = mem_nnz[check_nnz_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < nnz_c_bitwidth) begin
                                nnz_data_tmp_reg[j] = mem_nnz[check_nnz_count][i*32 + j];
                            end
                            else begin
                                nnz_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_nnz[check_nnz_count * four_byte_num  + i]!==nnz_data_tmp_reg) begin
                        image_mem_nnz[check_nnz_count * four_byte_num + i]=nnz_data_tmp_reg;
                        write (nnz_data_in_addr + check_nnz_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, nnz_data_tmp_reg, write_nnz_resp);
                        write_one_nnz_data_done <= 1;
                        @(posedge clk);
                        write_one_nnz_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_3_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_A_row_idx_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (A_row_idx_c_bitwidth, A_row_idx_DEPTH, A_row_idx_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_A_row_idx_run_flag <= 1; 
        end
        else if ((write_one_A_row_idx_data_done == 1 && write_A_row_idx_count == A_row_idx_diff_count - 1) || A_row_idx_diff_count == 0) begin
            write_A_row_idx_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_A_row_idx_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_A_row_idx_count = 0;
        end
        if (write_one_A_row_idx_data_done === 1) begin
            write_A_row_idx_count = write_A_row_idx_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        A_row_idx_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            A_row_idx_write_data_finish <= 0;
        end
        if (write_A_row_idx_run_flag == 1 && write_A_row_idx_count == A_row_idx_diff_count) begin
            A_row_idx_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_A_row_idx
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] A_row_idx_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = A_row_idx_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        A_row_idx_diff_count = 0;

        for (k = 0; k < A_row_idx_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (A_row_idx_c_bitwidth < 32) begin
                    A_row_idx_data_tmp_reg = mem_A_row_idx[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < A_row_idx_c_bitwidth) begin
                            A_row_idx_data_tmp_reg[j] = mem_A_row_idx[k][i*32 + j];
                        end
                        else begin
                            A_row_idx_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_A_row_idx[k * four_byte_num  + i]!==A_row_idx_data_tmp_reg) begin
                A_row_idx_diff_count = A_row_idx_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_A_row_idx
    integer write_A_row_idx_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_A_row_idx_count;
    reg [31 : 0] A_row_idx_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = A_row_idx_c_bitwidth;
    process_num = 4;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_4_finish <= 0;

        for (check_A_row_idx_count = 0; check_A_row_idx_count < A_row_idx_OPERATE_DEPTH; check_A_row_idx_count = check_A_row_idx_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_A_row_idx_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write A_row_idx data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (A_row_idx_c_bitwidth < 32) begin
                        A_row_idx_data_tmp_reg = mem_A_row_idx[check_A_row_idx_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < A_row_idx_c_bitwidth) begin
                                A_row_idx_data_tmp_reg[j] = mem_A_row_idx[check_A_row_idx_count][i*32 + j];
                            end
                            else begin
                                A_row_idx_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_A_row_idx[check_A_row_idx_count * four_byte_num  + i]!==A_row_idx_data_tmp_reg) begin
                        image_mem_A_row_idx[check_A_row_idx_count * four_byte_num + i]=A_row_idx_data_tmp_reg;
                        write (A_row_idx_data_in_addr + check_A_row_idx_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, A_row_idx_data_tmp_reg, write_A_row_idx_resp);
                        write_one_A_row_idx_data_done <= 1;
                        @(posedge clk);
                        write_one_A_row_idx_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_4_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_A_col_ptr_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (A_col_ptr_c_bitwidth, A_col_ptr_DEPTH, A_col_ptr_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_A_col_ptr_run_flag <= 1; 
        end
        else if ((write_one_A_col_ptr_data_done == 1 && write_A_col_ptr_count == A_col_ptr_diff_count - 1) || A_col_ptr_diff_count == 0) begin
            write_A_col_ptr_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_A_col_ptr_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_A_col_ptr_count = 0;
        end
        if (write_one_A_col_ptr_data_done === 1) begin
            write_A_col_ptr_count = write_A_col_ptr_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        A_col_ptr_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            A_col_ptr_write_data_finish <= 0;
        end
        if (write_A_col_ptr_run_flag == 1 && write_A_col_ptr_count == A_col_ptr_diff_count) begin
            A_col_ptr_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_A_col_ptr
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] A_col_ptr_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = A_col_ptr_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        A_col_ptr_diff_count = 0;

        for (k = 0; k < A_col_ptr_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (A_col_ptr_c_bitwidth < 32) begin
                    A_col_ptr_data_tmp_reg = mem_A_col_ptr[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < A_col_ptr_c_bitwidth) begin
                            A_col_ptr_data_tmp_reg[j] = mem_A_col_ptr[k][i*32 + j];
                        end
                        else begin
                            A_col_ptr_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_A_col_ptr[k * four_byte_num  + i]!==A_col_ptr_data_tmp_reg) begin
                A_col_ptr_diff_count = A_col_ptr_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_A_col_ptr
    integer write_A_col_ptr_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_A_col_ptr_count;
    reg [31 : 0] A_col_ptr_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = A_col_ptr_c_bitwidth;
    process_num = 5;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_5_finish <= 0;

        for (check_A_col_ptr_count = 0; check_A_col_ptr_count < A_col_ptr_OPERATE_DEPTH; check_A_col_ptr_count = check_A_col_ptr_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_A_col_ptr_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write A_col_ptr data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (A_col_ptr_c_bitwidth < 32) begin
                        A_col_ptr_data_tmp_reg = mem_A_col_ptr[check_A_col_ptr_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < A_col_ptr_c_bitwidth) begin
                                A_col_ptr_data_tmp_reg[j] = mem_A_col_ptr[check_A_col_ptr_count][i*32 + j];
                            end
                            else begin
                                A_col_ptr_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_A_col_ptr[check_A_col_ptr_count * four_byte_num  + i]!==A_col_ptr_data_tmp_reg) begin
                        image_mem_A_col_ptr[check_A_col_ptr_count * four_byte_num + i]=A_col_ptr_data_tmp_reg;
                        write (A_col_ptr_data_in_addr + check_A_col_ptr_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, A_col_ptr_data_tmp_reg, write_A_col_ptr_resp);
                        write_one_A_col_ptr_data_done <= 1;
                        @(posedge clk);
                        write_one_A_col_ptr_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_5_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_A_values_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (A_values_c_bitwidth, A_values_DEPTH, A_values_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_A_values_run_flag <= 1; 
        end
        else if ((write_one_A_values_data_done == 1 && write_A_values_count == A_values_diff_count - 1) || A_values_diff_count == 0) begin
            write_A_values_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_A_values_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_A_values_count = 0;
        end
        if (write_one_A_values_data_done === 1) begin
            write_A_values_count = write_A_values_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        A_values_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            A_values_write_data_finish <= 0;
        end
        if (write_A_values_run_flag == 1 && write_A_values_count == A_values_diff_count) begin
            A_values_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_A_values
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] A_values_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = A_values_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        A_values_diff_count = 0;

        for (k = 0; k < A_values_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (A_values_c_bitwidth < 32) begin
                    A_values_data_tmp_reg = mem_A_values[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < A_values_c_bitwidth) begin
                            A_values_data_tmp_reg[j] = mem_A_values[k][i*32 + j];
                        end
                        else begin
                            A_values_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_A_values[k * four_byte_num  + i]!==A_values_data_tmp_reg) begin
                A_values_diff_count = A_values_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_A_values
    integer write_A_values_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_A_values_count;
    reg [31 : 0] A_values_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = A_values_c_bitwidth;
    process_num = 6;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_6_finish <= 0;

        for (check_A_values_count = 0; check_A_values_count < A_values_OPERATE_DEPTH; check_A_values_count = check_A_values_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_A_values_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write A_values data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (A_values_c_bitwidth < 32) begin
                        A_values_data_tmp_reg = mem_A_values[check_A_values_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < A_values_c_bitwidth) begin
                                A_values_data_tmp_reg[j] = mem_A_values[check_A_values_count][i*32 + j];
                            end
                            else begin
                                A_values_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_A_values[check_A_values_count * four_byte_num  + i]!==A_values_data_tmp_reg) begin
                        image_mem_A_values[check_A_values_count * four_byte_num + i]=A_values_data_tmp_reg;
                        write (A_values_data_in_addr + check_A_values_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, A_values_data_tmp_reg, write_A_values_resp);
                        write_one_A_values_data_done <= 1;
                        @(posedge clk);
                        write_one_A_values_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_6_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_x_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (x_c_bitwidth, x_DEPTH, x_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_x_run_flag <= 1; 
        end
        else if ((write_one_x_data_done == 1 && write_x_count == x_diff_count - 1) || x_diff_count == 0) begin
            write_x_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_x_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_x_count = 0;
        end
        if (write_one_x_data_done === 1) begin
            write_x_count = write_x_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        x_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            x_write_data_finish <= 0;
        end
        if (write_x_run_flag == 1 && write_x_count == x_diff_count) begin
            x_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_x
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] x_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = x_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        x_diff_count = 0;

        for (k = 0; k < x_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (x_c_bitwidth < 32) begin
                    x_data_tmp_reg = mem_x[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < x_c_bitwidth) begin
                            x_data_tmp_reg[j] = mem_x[k][i*32 + j];
                        end
                        else begin
                            x_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_x[k * four_byte_num  + i]!==x_data_tmp_reg) begin
                x_diff_count = x_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_x
    integer write_x_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_x_count;
    reg [31 : 0] x_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = x_c_bitwidth;
    process_num = 7;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_7_finish <= 0;

        for (check_x_count = 0; check_x_count < x_OPERATE_DEPTH; check_x_count = check_x_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_x_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write x data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (x_c_bitwidth < 32) begin
                        x_data_tmp_reg = mem_x[check_x_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < x_c_bitwidth) begin
                                x_data_tmp_reg[j] = mem_x[check_x_count][i*32 + j];
                            end
                            else begin
                                x_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_x[check_x_count * four_byte_num  + i]!==x_data_tmp_reg) begin
                        image_mem_x[check_x_count * four_byte_num + i]=x_data_tmp_reg;
                        write (x_data_in_addr + check_x_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, x_data_tmp_reg, write_x_resp);
                        write_one_x_data_done <= 1;
                        @(posedge clk);
                        write_one_x_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_7_finish <= 1;
        @(posedge clk);
    end    
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_y_run_flag <= 0; 
        count_operate_depth_by_bitwidth_and_depth (y_c_bitwidth, y_DEPTH, y_OPERATE_DEPTH);
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_y_run_flag <= 1; 
        end
        else if ((write_one_y_data_done == 1 && write_y_count == y_diff_count - 1) || y_diff_count == 0) begin
            write_y_run_flag <= 0; 
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_y_count = 0;
    end
    else begin
        if (AESL_ready_reg === 1) begin
            write_y_count = 0;
        end
        if (write_one_y_data_done === 1) begin
            write_y_count = write_y_count + 1;
        end
    end
end

always @(reset or posedge clk) begin
    if (reset == 0) begin
        y_write_data_finish <= 0;
    end
    else begin
        if (TRAN_control_start_in === 1) begin
            y_write_data_finish <= 0;
        end
        if (write_y_run_flag == 1 && write_y_count == y_diff_count) begin
            y_write_data_finish <= 1;
        end
    end
end

initial begin : initial_diff_counter_y
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer k;
    reg [31 : 0] y_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = y_c_bitwidth;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        wait (AESL_ready_reg === 1);
        y_diff_count = 0;

        for (k = 0; k < y_OPERATE_DEPTH; k = k + 1) begin
            for (i = 0; i < four_byte_num; i = i + 1) begin
                if (y_c_bitwidth < 32) begin
                    y_data_tmp_reg = mem_y[k];
                end
                else begin
                    for (j = 0; j < 32; j = j + 1) begin
                        if (i*32 + j < y_c_bitwidth) begin
                            y_data_tmp_reg[j] = mem_y[k][i*32 + j];
                        end
                        else begin
                            y_data_tmp_reg[j] = 0;
                        end
                    end
                end
                if(image_mem_y[k * four_byte_num  + i]!==y_data_tmp_reg) begin
                y_diff_count = y_diff_count + 1;
                end
            end
        end

        @(posedge clk);
    end
end

initial begin : write_y
    integer write_y_resp;
    integer process_num ;
    integer get_ack;
    integer four_byte_num;
    integer ceil_align_to_pow_of_two_four_byte_num;
    integer c_bitwidth;
    integer i;
    integer j;
    integer check_y_count;
    reg [31 : 0] y_data_tmp_reg;
    wait(reset === 1);
    @(posedge clk);
    c_bitwidth = y_c_bitwidth;
    process_num = 8;
    count_c_data_four_byte_num_by_bitwidth (c_bitwidth , four_byte_num);
    ceil_align_to_pow_of_two_four_byte_num = ceil_align_to_pow_of_two(four_byte_num);
    while (1) begin
        process_8_finish <= 0;

        for (check_y_count = 0; check_y_count < y_OPERATE_DEPTH; check_y_count = check_y_count + 1) begin
            wait (ongoing_process_number === process_num && process_busy === 0);
            get_ack = 1;
            if (write_y_run_flag === 1 && get_ack === 1) begin
                process_busy = 1;
                //write y data 
                for (i = 0; i < four_byte_num; i = i + 1) begin
                    if (y_c_bitwidth < 32) begin
                        y_data_tmp_reg = mem_y[check_y_count];
                    end
                    else begin
                        for (j = 0; j < 32; j = j + 1) begin
                            if (i*32 + j < y_c_bitwidth) begin
                                y_data_tmp_reg[j] = mem_y[check_y_count][i*32 + j];
                            end
                            else begin
                                y_data_tmp_reg[j] = 0;
                            end
                        end
                    end
                    if(image_mem_y[check_y_count * four_byte_num  + i]!==y_data_tmp_reg) begin
                        image_mem_y[check_y_count * four_byte_num + i]=y_data_tmp_reg;
                        write (y_data_in_addr + check_y_count * ceil_align_to_pow_of_two_four_byte_num * 4 + i * 4, y_data_tmp_reg, write_y_resp);
                        write_one_y_data_done <= 1;
                        @(posedge clk);
                        write_one_y_data_done <= 0;
                    end
                end
            end
            process_busy = 0;
        end

        process_8_finish <= 1;
        @(posedge clk);
    end    
end


always @(reset or posedge clk) begin
    if (reset == 0) begin
        write_start_run_flag <= 0; 
        write_start_count <= 0;
    end
    else begin
        if (write_start_count >= 1) begin
            write_start_run_flag <= 0; 
        end
        else if (TRAN_control_write_start_in === 1) begin
            write_start_run_flag <= 1; 
        end
        if (AESL_write_start_finish === 1) begin
            write_start_count <= write_start_count + 1;
            write_start_run_flag <= 0; 
        end
    end
end

initial begin : write_start
    reg [DATA_WIDTH - 1 : 0] write_start_tmp;
    integer process_num;
    integer write_start_resp;
    wait(reset === 1);
    @(posedge clk);
    process_num = 9;
    while (1) begin
        process_9_finish = 0;
        if (ongoing_process_number === process_num && process_busy === 0 ) begin
            if (write_start_run_flag === 1) begin
                process_busy = 1;
                write_start_tmp=0;
                write_start_tmp[0 : 0] = 1;
                write (START_ADDR, write_start_tmp, write_start_resp);
                process_busy = 0;
                AESL_write_start_finish <= 1;
                @(posedge clk);
                AESL_write_start_finish <= 0;
            end
            process_9_finish <= 1;
        end 
        @(posedge clk);
    end
end

//------------------------Task and function-------------- 
task read_token; 
    input integer fp; 
    output reg [151 : 0] token;
    integer ret;
    begin
        token = "";
        ret = 0;
        ret = $fscanf(fp,"%s",token);
    end 
endtask 
 
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_num_rows_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [num_rows_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (num_rows_c_bitwidth , factor);
  fp = $fopen(`TV_IN_num_rows ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_num_rows); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < num_rows_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_num_rows [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_num_rows [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_num_rows [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_num_rows [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_num_rows [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_num_rows;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_num_cols_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [num_cols_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (num_cols_c_bitwidth , factor);
  fp = $fopen(`TV_IN_num_cols ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_num_cols); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < num_cols_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_num_cols [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_num_cols [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_num_cols [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_num_cols [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_num_cols [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_num_cols;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_nnz_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [127 : 0] token; 
  reg [127 : 0] token_tmp; 
  //reg [nnz_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (nnz_c_bitwidth , factor);
  fp = $fopen(`TV_IN_nnz ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_nnz); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < nnz_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_nnz [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_nnz [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_nnz [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_nnz [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_nnz [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_nnz;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_A_row_idx_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [151 : 0] token; 
  reg [151 : 0] token_tmp; 
  //reg [A_row_idx_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (A_row_idx_c_bitwidth , factor);
  fp = $fopen(`TV_IN_A_row_idx ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_A_row_idx); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < A_row_idx_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_A_row_idx [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_A_row_idx [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_A_row_idx [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_A_row_idx [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_A_row_idx [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_A_row_idx;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_A_col_ptr_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [151 : 0] token; 
  reg [151 : 0] token_tmp; 
  //reg [A_col_ptr_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (A_col_ptr_c_bitwidth , factor);
  fp = $fopen(`TV_IN_A_col_ptr ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_A_col_ptr); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < A_col_ptr_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_A_col_ptr [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_A_col_ptr [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_A_col_ptr [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_A_col_ptr [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_A_col_ptr [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_A_col_ptr;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_A_values_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [151 : 0] token; 
  reg [151 : 0] token_tmp; 
  //reg [A_values_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (A_values_c_bitwidth , factor);
  fp = $fopen(`TV_IN_A_values ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_A_values); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < A_values_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_A_values [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_A_values [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_A_values [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_A_values [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_A_values [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_A_values;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_x_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [151 : 0] token; 
  reg [151 : 0] token_tmp; 
  //reg [x_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (x_c_bitwidth , factor);
  fp = $fopen(`TV_IN_x ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_x); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < x_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_x [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_x [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_x [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_x [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_x [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_x;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
//------------------------Read file------------------------ 
 
// Read data from file 
initial begin : read_y_file_process 
  integer fp; 
  integer ret; 
  integer factor; 
  reg [151 : 0] token; 
  reg [151 : 0] token_tmp; 
  //reg [y_c_bitwidth - 1 : 0] token_tmp; 
  reg [DATA_WIDTH - 1 : 0] tmp_cache_mem; 
  reg [ 8*5 : 1] str;
    reg [63:0] trans_depth;
  integer transaction_idx; 
  integer i; 
  transaction_idx = 0; 
  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
  count_seperate_factor_by_bitwidth (y_c_bitwidth , factor);
  fp = $fopen(`TV_IN_y ,"r"); 
  if(fp == 0) begin                               // Failed to open file 
      $display("Failed to open file \"%s\"!", `TV_IN_y); 
      $finish; 
  end 
  read_token(fp, token); 
  if (token != "[[[runtime]]]") begin             // Illegal format 
      $display("ERROR: Simulation using HLS TB failed.");
      $finish; 
  end 
  read_token(fp, token); 
  while (token != "[[[/runtime]]]") begin 
      if (token != "[[transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token);                        // skip transaction number 
      @(posedge clk);
      # 0.2;
      while(AESL_ready_reg !== 1) begin
          @(posedge clk); 
          # 0.2;
      end
      for(i = 0; i < y_DEPTH; i = i + 1) begin 
          read_token(fp, token); 
          ret = $sscanf(token, "0x%x", token_tmp); 
          if (factor == 4) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [7 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [15 : 8] = token_tmp;
              end
              if (i%factor == 2) begin
                  tmp_cache_mem [23 : 16] = token_tmp;
              end
              if (i%factor == 3) begin
                  tmp_cache_mem [31 : 24] = token_tmp;
                  mem_y [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1 : 0] = 0;
              end
          end
          if (factor == 2) begin
              if (i%factor == 0) begin
                  tmp_cache_mem [15 : 0] = token_tmp;
              end
              if (i%factor == 1) begin
                  tmp_cache_mem [31 : 16] = token_tmp;
                  mem_y [i/factor] = tmp_cache_mem;
                  tmp_cache_mem [DATA_WIDTH - 1: 0] = 0;
              end
          end
          if (factor == 1) begin
              mem_y [i] = token_tmp;
          end
      end 
      if (factor == 4) begin
          if (i%factor != 0) begin
              mem_y [i/factor] = tmp_cache_mem;
          end
      end
      if (factor == 2) begin
          if (i%factor != 0) begin
              mem_y [i/factor] = tmp_cache_mem;
          end
      end 
      read_token(fp, token); 
      if(token != "[[/transaction]]") begin 
          $display("ERROR: Simulation using HLS TB failed.");
          $finish; 
      end 
      read_token(fp, token); 
      transaction_idx = transaction_idx + 1; 
  end 
  $fclose(fp); 
end 
 
task write_binary_y;
    input integer fp;
    input reg[64-1:0] in;
    input integer in_bw;
    reg [63:0] tmp_long;
    reg[64-1:0] local_in;
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
endmodule
