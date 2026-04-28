`timescale 1 ns / 1 ps

module AESL_deadlock_report_unit #( parameter PROC_NUM = 4 ) (
    input dl_reset,
    input dl_clock,
    input [PROC_NUM - 1:0] dl_in_vec,
    input [15:0] trans_in_cnt_0,
    input [15:0] trans_out_cnt_0,
    input ap_done_reg_0,
    input ap_done_reg_1,
    input ap_done_reg_2,
    input ap_done_reg_3,
    input ap_done_reg_4,
    input ap_done_reg_5,
    input ap_done_reg_6,
    input ap_done_reg_7,
    input ap_done_reg_8,
    input ap_done_reg_9,
    input ap_done_reg_10,
    input ap_done_reg_11,
    input ap_done_reg_12,
    input ap_done_reg_13,
    input ap_done_reg_14,
    input ap_done_reg_15,
    output dl_detect_out,
    output reg [PROC_NUM - 1:0] origin,
    output token_clear);
   
    // FSM states
    localparam ST_IDLE = 3'b000;
    localparam ST_FILTER_FAKE = 3'b001;
    localparam ST_DL_DETECTED = 3'b010;
    localparam ST_DL_REPORT = 3'b100;

    reg find_df_deadlock;
    reg [2:0] CS_fsm;
    reg [2:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    reg [31:0] dl_keep_cnt;
    reg stop_report_path;
    reg [PROC_NUM - 1:0] reported_proc;
    integer i;
    integer fp;

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            reported_proc <= 'b0;
        end
        else if (CS_fsm == ST_DL_REPORT) begin
            reported_proc <= reported_proc | dl_in_vec;
        end
        else if (CS_fsm == ST_DL_DETECTED) begin
            reported_proc <= 'b0;
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            stop_report_path <= 1'b0;
        end
        else if (CS_fsm == ST_DL_REPORT && (|(dl_in_vec & reported_proc))) begin
            stop_report_path <= 1'b1;
        end
        else if (CS_fsm == ST_IDLE) begin
            stop_report_path <= 1'b0;
        end
    end

    // FSM State machine
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end

    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg or dl_keep_cnt) begin
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_FILTER_FAKE;
                end
                else begin
                    NS_fsm = ST_IDLE;
                end
            end
            ST_FILTER_FAKE: begin
                if (dl_keep_cnt >= 32'd1000) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else if (dl_detect_reg != (dl_detect_reg & dl_in_vec)) begin
                    NS_fsm = ST_IDLE;
                end
                else begin
                    NS_fsm = ST_FILTER_FAKE;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if ((dl_detect_reg != dl_done_reg) && stop_report_path == 1'b0) begin
                    NS_fsm = ST_DL_REPORT;
                end
                else begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                // avoid report deadlock ring.
                else if (|(dl_in_vec & reported_proc)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            default: NS_fsm = ST_IDLE;
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_keep_cnt <= 32'h0;
        end
        else begin
            if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg == (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= dl_keep_cnt + 32'h1;
            end
            else if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg != (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= 32'h0;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = (|dl_detect_reg) && (CS_fsm == ST_DL_DETECTED || CS_fsm == ST_DL_REPORT);

    // dl_done_reg record the cycles has been reported
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    wire [PROC_NUM*PROC_NUM - 1:0] origin_tmp;
    assign origin_tmp[PROC_NUM - 1:0] = (dl_detect_reg[0] & ~dl_done_reg[0]) ? 'b1 : 'b0;
    genvar j;
    generate
    for(j = 1;j < PROC_NUM;j = j + 1) begin: F1
        assign origin_tmp[j*PROC_NUM +: PROC_NUM] = (dl_detect_reg[j] & ~dl_done_reg[j]) ? ('b1 << j) : origin_tmp[(j - 1)*PROC_NUM +: PROC_NUM];
    end
    endgenerate
    always @ (CS_fsm or origin_tmp) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            origin = origin_tmp[(PROC_NUM - 1)*PROC_NUM +: PROC_NUM];
        end
        else begin
            origin = 'b0;
        end
    end

    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // find_df_deadlock to report the deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            find_df_deadlock <= 1'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED && ((dl_detect_reg == dl_done_reg) || (stop_report_path == 1'b1))) begin
                find_df_deadlock <= 1'b1;
            end
            else if (CS_fsm == ST_IDLE) begin
                find_df_deadlock <= 1'b0;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [536:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0";
                end
                1 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0";
                end
                2 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0";
                end
                3 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0";
                end
                4 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0";
                end
                5 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0";
                end
                6 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0";
                end
                7 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0";
                end
                8 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0";
                end
                9 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0";
                end
                10 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0";
                end
                11 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0";
                end
                12 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0";
                end
                13 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0";
                end
                14 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0";
                end
                15 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0";
                end
                16 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0";
                end
                17 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0";
                end
                18 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0";
                end
                19 : begin
                    proc_path = "spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [536:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [536:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [632:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
                    case(index2)
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c2_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c2_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c3_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c3_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c4_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c4_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c5_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c5_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c6_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c6_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c7_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c7_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c8_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c8_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c9_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c9_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c10_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c10_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c11_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c11_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c12_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c12_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c13_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c13_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c14_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c14_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c15_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c15_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c16_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.num_rows_c16_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    endcase
                end
                1 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
                    case(index2)
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.col_info_stream_blk_n data_FIFO} {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149.col_info_stream_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.col_info_stream_blk_n) | (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149.col_info_stream_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U' info is :
// blk sig is {{~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_full_n & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_start & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_read} start_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_full_n & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_start & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_read)) begin
                            $display("//      Blocked by full output start propagation FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0',");
                        end
                    end
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                2 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
                    case(index2)
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114.nnz_stream_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114.nnz_stream_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.nnz_c_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.nnz_c_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                3 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
                    case(index2)
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.nnz_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.nnz_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.nnz_stream_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.nnz_stream_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.nnz_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.col_info_stream_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.col_info_stream_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.col_info_stream_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U' info is :
// blk sig is {{~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_empty_n & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_write} start_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_empty_n & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U.if_write)) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.start_for_distribute_to_pe_U0_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0',");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_0_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_0_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_1_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_1_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_2_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_2_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_3_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_3_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_4_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_4_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_5_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_5_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_6_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_6_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_7_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_7_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_8_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_8_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_9_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_9_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_10_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_10_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_11_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_11_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_12_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_12_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_13_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_13_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_14_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_14_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_15_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0.grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72.pe_streams_15_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                4 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c16_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_0_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_0_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_0_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_0 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                5 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c15_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_1_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_1_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_1_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_1 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                6 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c14_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_2_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_2_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_2 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                7 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c13_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_3_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_3_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_3 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                8 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c12_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_4_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_4_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_4 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                9 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_5_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_5_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_5 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                10 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_6_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_6_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_6 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                11 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_7_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_7_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_7 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                12 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_8_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_8_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_8_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_8 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                13 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c7_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_9_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_9_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_9_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_9 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                14 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c6_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_10_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_10_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_10_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_10 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                15 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c5_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_11_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_11_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_11_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_11 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                16 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c4_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_12_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_12_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_12_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_12 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                17 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c3_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_13_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_13_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_13_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_13 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                18 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c2_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_14_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_14_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_14_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    19: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready} input_sync} {{ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready) | (ap_done_reg_14 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'");
                        end
                    end
                    endcase
                end
                19 : begin // for proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0'
                    case(index2)
                    0: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.num_rows_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.num_rows_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.num_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_entry_proc_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.entry_proc_U0'");
                        end
                    end
                    3: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'
// for dep channel 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U' info is :
// blk sig is {~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_15_blk_n data_FIFO}
                        if ((~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55.pe_streams_15_blk_n)) begin
                            if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U' written by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U' read by process 'spmv_csc.grp_spmv_csc_dataflow_fu_220.distribute_to_pe_U0'");
                                $fdisplay(fp, "Dependence_Channel_path spmv_csc.grp_spmv_csc_dataflow_fu_220.pe_streams_15_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_col_info_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_col_info_U0'");
                        end
                    end
                    2: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready} input_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_read_nnz_packed_U0_ap_ready)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.read_nnz_packed_U0'");
                        end
                    end
                    4: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_U0'");
                        end
                    end
                    5: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_1_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_1_U0'");
                        end
                    end
                    6: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_2_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_2_U0'");
                        end
                    end
                    7: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_3_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_3_U0'");
                        end
                    end
                    8: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_4_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_4_U0'");
                        end
                    end
                    9: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_5_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_5_U0'");
                        end
                    end
                    10: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_6_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_6_U0'");
                        end
                    end
                    11: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_7_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_7_U0'");
                        end
                    end
                    12: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_8_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_8_U0'");
                        end
                    end
                    13: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_9_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_9_U0'");
                        end
                    end
                    14: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_10_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_10_U0'");
                        end
                    end
                    15: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_11_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_11_U0'");
                        end
                    end
                    16: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_12_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_12_U0'");
                        end
                    end
                    17: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_13_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_13_U0'");
                        end
                    end
                    18: begin //  for dep proc 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'
// for dep channel '' info is :
// blk sig is {{AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready} input_sync} {{ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done} output_sync}
                        if ((AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_15_U0_ap_ready & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_idle & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.ap_sync_compute_pe_14_U0_ap_ready) | (ap_done_reg_15 & AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_15_U0.ap_done & ~AESL_inst_spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0.ap_done)) begin
                            $display("//      Blocked by input sync logic with process : 'spmv_csc.grp_spmv_csc_dataflow_fu_220.compute_pe_14_U0'");
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (dl_reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge dl_clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg && stop_report_path == 1'b0) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        @(negedge dl_clock);
                        @(negedge dl_clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg)) & ~(|(reported_proc & dl_in_vec))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else if (~(|(dl_in_vec)))begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
endmodule
