// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

extern "C" void AESL_WRAP_spmv_csc (
int num_rows,
int num_cols,
int nnz,
volatile void* A_row_idx,
volatile void* A_col_ptr,
volatile void* A_values,
volatile void* x,
volatile void* y);
