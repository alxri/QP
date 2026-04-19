set SynModuleInfo {
  {SRCNAME spmv_csr_Pipeline_READ_X MODELNAME spmv_csr_Pipeline_READ_X RTLNAME spmv_csr_spmv_csr_Pipeline_READ_X
    SUBMODULES {
      {MODELNAME spmv_csr_flow_control_loop_pipe_sequential_init RTLNAME spmv_csr_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME spmv_csr_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME spmv_csr_Pipeline_L2 MODELNAME spmv_csr_Pipeline_L2 RTLNAME spmv_csr_spmv_csr_Pipeline_L2
    SUBMODULES {
      {MODELNAME spmv_csr_fadd_32ns_32ns_32_4_full_dsp_1 RTLNAME spmv_csr_fadd_32ns_32ns_32_4_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME spmv_csr_fmul_32ns_32ns_32_3_max_dsp_1 RTLNAME spmv_csr_fmul_32ns_32ns_32_3_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME spmv_csr MODELNAME spmv_csr RTLNAME spmv_csr IS_TOP 1
    SUBMODULES {
      {MODELNAME spmv_csr_x_buf_RAM_AUTO_1R1W RTLNAME spmv_csr_x_buf_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME spmv_csr_gmem0_m_axi RTLNAME spmv_csr_gmem0_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csr_gmem1_m_axi RTLNAME spmv_csr_gmem1_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csr_gmem2_m_axi RTLNAME spmv_csr_gmem2_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csr_gmem3_m_axi RTLNAME spmv_csr_gmem3_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csr_gmem4_m_axi RTLNAME spmv_csr_gmem4_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME spmv_csr_control_s_axi RTLNAME spmv_csr_control_s_axi BINDTYPE interface TYPE interface_s_axilite}
    }
  }
}
