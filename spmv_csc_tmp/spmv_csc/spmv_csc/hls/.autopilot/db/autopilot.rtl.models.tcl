set SynModuleInfo {
  {SRCNAME entry_proc MODELNAME entry_proc RTLNAME spmv_csc_entry_proc}
  {SRCNAME read_col_info_Pipeline_VITIS_LOOP_46_1 MODELNAME read_col_info_Pipeline_VITIS_LOOP_46_1 RTLNAME spmv_csc_read_col_info_Pipeline_VITIS_LOOP_46_1
    SUBMODULES {
      {MODELNAME spmv_csc_flow_control_loop_pipe_sequential_init RTLNAME spmv_csc_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME spmv_csc_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME read_col_info MODELNAME read_col_info RTLNAME spmv_csc_read_col_info}
  {SRCNAME read_nnz_packed_Pipeline_VITIS_LOOP_89_1 MODELNAME read_nnz_packed_Pipeline_VITIS_LOOP_89_1 RTLNAME spmv_csc_read_nnz_packed_Pipeline_VITIS_LOOP_89_1}
  {SRCNAME read_nnz_packed MODELNAME read_nnz_packed RTLNAME spmv_csc_read_nnz_packed}
  {SRCNAME distribute_to_pe_Pipeline_VITIS_LOOP_172_1 MODELNAME distribute_to_pe_Pipeline_VITIS_LOOP_172_1 RTLNAME spmv_csc_distribute_to_pe_Pipeline_VITIS_LOOP_172_1
    SUBMODULES {
      {MODELNAME spmv_csc_sparsemux_33_4_32_1_1 RTLNAME spmv_csc_sparsemux_33_4_32_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
    }
  }
  {SRCNAME distribute_to_pe_Pipeline_VITIS_LOOP_230_3 MODELNAME distribute_to_pe_Pipeline_VITIS_LOOP_230_3 RTLNAME spmv_csc_distribute_to_pe_Pipeline_VITIS_LOOP_230_3}
  {SRCNAME distribute_to_pe MODELNAME distribute_to_pe RTLNAME spmv_csc_distribute_to_pe}
  {SRCNAME compute_pe_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_Pipeline_VITIS_LOOP_251_2
    SUBMODULES {
      {MODELNAME spmv_csc_fadd_32ns_32ns_32_5_no_dsp_1 RTLNAME spmv_csc_fadd_32ns_32ns_32_5_no_dsp_1 BINDTYPE op TYPE fadd IMPL fabric LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME spmv_csc_fmul_32ns_32ns_32_4_max_dsp_1 RTLNAME spmv_csc_fmul_32ns_32ns_32_4_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 3 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME compute_pe MODELNAME compute_pe RTLNAME spmv_csc_compute_pe}
  {SRCNAME compute_pe.1_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_1_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_1_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.1_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_1_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_1_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.1 MODELNAME compute_pe_1 RTLNAME spmv_csc_compute_pe_1}
  {SRCNAME compute_pe.2_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_2_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_2_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.2_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_2_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_2_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.2 MODELNAME compute_pe_2 RTLNAME spmv_csc_compute_pe_2}
  {SRCNAME compute_pe.3_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_3_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_3_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.3_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_3_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_3_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.3 MODELNAME compute_pe_3 RTLNAME spmv_csc_compute_pe_3}
  {SRCNAME compute_pe.4_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_4_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_4_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.4_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_4_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_4_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.4 MODELNAME compute_pe_4 RTLNAME spmv_csc_compute_pe_4}
  {SRCNAME compute_pe.5_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_5_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_5_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.5_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_5_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_5_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.5 MODELNAME compute_pe_5 RTLNAME spmv_csc_compute_pe_5}
  {SRCNAME compute_pe.6_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_6_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_6_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.6_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_6_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_6_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.6 MODELNAME compute_pe_6 RTLNAME spmv_csc_compute_pe_6}
  {SRCNAME compute_pe.7_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_7_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_7_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.7_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_7_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_7_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.7 MODELNAME compute_pe_7 RTLNAME spmv_csc_compute_pe_7}
  {SRCNAME compute_pe.8_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_8_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_8_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.8_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_8_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_8_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.8 MODELNAME compute_pe_8 RTLNAME spmv_csc_compute_pe_8}
  {SRCNAME compute_pe.9_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_9_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_9_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.9_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_9_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_9_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.9 MODELNAME compute_pe_9 RTLNAME spmv_csc_compute_pe_9}
  {SRCNAME compute_pe.10_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_10_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_10_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.10_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_10_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_10_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.10 MODELNAME compute_pe_10 RTLNAME spmv_csc_compute_pe_10}
  {SRCNAME compute_pe.11_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_11_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_11_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.11_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_11_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_11_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.11 MODELNAME compute_pe_11 RTLNAME spmv_csc_compute_pe_11}
  {SRCNAME compute_pe.12_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_12_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_12_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.12_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_12_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_12_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.12 MODELNAME compute_pe_12 RTLNAME spmv_csc_compute_pe_12}
  {SRCNAME compute_pe.13_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_13_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_13_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.13_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_13_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_13_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.13 MODELNAME compute_pe_13 RTLNAME spmv_csc_compute_pe_13}
  {SRCNAME compute_pe.14_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_14_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_14_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.14_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_14_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_14_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.14 MODELNAME compute_pe_14 RTLNAME spmv_csc_compute_pe_14}
  {SRCNAME compute_pe.15_Pipeline_VITIS_LOOP_245_1 MODELNAME compute_pe_15_Pipeline_VITIS_LOOP_245_1 RTLNAME spmv_csc_compute_pe_15_Pipeline_VITIS_LOOP_245_1}
  {SRCNAME compute_pe.15_Pipeline_VITIS_LOOP_251_2 MODELNAME compute_pe_15_Pipeline_VITIS_LOOP_251_2 RTLNAME spmv_csc_compute_pe_15_Pipeline_VITIS_LOOP_251_2}
  {SRCNAME compute_pe.15 MODELNAME compute_pe_15 RTLNAME spmv_csc_compute_pe_15}
  {SRCNAME spmv_csc_dataflow MODELNAME spmv_csc_dataflow RTLNAME spmv_csc_spmv_csc_dataflow
    SUBMODULES {
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c2_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c3_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c4_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c5_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c6_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c7_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c8_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c9_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c10_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c11_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c12_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c13_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c14_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c15_U}
      {MODELNAME spmv_csc_fifo_w32_d4_S RTLNAME spmv_csc_fifo_w32_d4_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME num_rows_c16_U}
      {MODELNAME spmv_csc_fifo_w64_d64_A RTLNAME spmv_csc_fifo_w64_d64_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME col_info_stream_U}
      {MODELNAME spmv_csc_fifo_w1032_d256_A RTLNAME spmv_csc_fifo_w1032_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME nnz_stream_U}
      {MODELNAME spmv_csc_fifo_w32_d2_S RTLNAME spmv_csc_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME nnz_c_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_0_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_1_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_2_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_3_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_4_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_5_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_6_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_7_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_8_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_9_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_10_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_11_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_12_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_13_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_14_U}
      {MODELNAME spmv_csc_fifo_w97_d256_A RTLNAME spmv_csc_fifo_w97_d256_A BINDTYPE storage TYPE fifo IMPL memory ALLOW_PRAGMA 1 INSTNAME pe_streams_15_U}
      {MODELNAME spmv_csc_start_for_distribute_to_pe_U0 RTLNAME spmv_csc_start_for_distribute_to_pe_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_distribute_to_pe_U0_U}
    }
  }
  {SRCNAME reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2 MODELNAME reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2 RTLNAME spmv_csc_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2
    SUBMODULES {
      {MODELNAME spmv_csc_fadd_32ns_32ns_32_8_full_dsp_1 RTLNAME spmv_csc_fadd_32ns_32ns_32_8_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 7 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME reduce_and_write_packed MODELNAME reduce_and_write_packed RTLNAME spmv_csc_reduce_and_write_packed}
  {SRCNAME spmv_csc MODELNAME spmv_csc RTLNAME spmv_csc IS_TOP 1
    SUBMODULES {
      {MODELNAME spmv_csc_y_partial_RAM_T2P_URAM_1R1W RTLNAME spmv_csc_y_partial_RAM_T2P_URAM_1R1W BINDTYPE storage TYPE ram_t2p IMPL uram LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME spmv_csc_gmem0_m_axi RTLNAME spmv_csc_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csc_gmem1_m_axi RTLNAME spmv_csc_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csc_gmem2_m_axi RTLNAME spmv_csc_gmem2_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csc_gmem3_m_axi RTLNAME spmv_csc_gmem3_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csc_gmem4_m_axi RTLNAME spmv_csc_gmem4_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csc_control_s_axi RTLNAME spmv_csc_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
