set SynModuleInfo {
  {SRCNAME mv_Pipeline_x_buff MODELNAME mv_Pipeline_x_buff RTLNAME mv_mv_Pipeline_x_buff
    SUBMODULES {
      {MODELNAME mv_flow_control_loop_pipe_sequential_init RTLNAME mv_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME mv_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME mv_Pipeline_col_loop MODELNAME mv_Pipeline_col_loop RTLNAME mv_mv_Pipeline_col_loop}
  {SRCNAME mv_Pipeline_mac_loop MODELNAME mv_Pipeline_mac_loop RTLNAME mv_mv_Pipeline_mac_loop
    SUBMODULES {
      {MODELNAME mv_fadd_32ns_32ns_32_4_full_dsp_1 RTLNAME mv_fadd_32ns_32ns_32_4_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME mv_fmul_32ns_32ns_32_3_max_dsp_1 RTLNAME mv_fmul_32ns_32ns_32_3_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME mv_sparsemux_17_3_32_1_1 RTLNAME mv_sparsemux_17_3_32_1_1 BINDTYPE op TYPE sparsemux IMPL compactencoding_dontcare}
    }
  }
  {SRCNAME mv MODELNAME mv RTLNAME mv IS_TOP 1
    SUBMODULES {
      {MODELNAME mv_mul_32ns_32ns_63_1_1 RTLNAME mv_mul_32ns_32ns_63_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME mv_x_buf_RAM_AUTO_1R1W RTLNAME mv_x_buf_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME mv_gmem0_m_axi RTLNAME mv_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME mv_gmem1_m_axi RTLNAME mv_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME mv_gmem2_m_axi RTLNAME mv_gmem2_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME mv_control_s_axi RTLNAME mv_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME mv_control_r_s_axi RTLNAME mv_control_r_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
