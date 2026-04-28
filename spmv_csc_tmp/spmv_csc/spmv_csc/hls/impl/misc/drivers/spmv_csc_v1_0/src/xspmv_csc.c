// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xspmv_csc.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XSpmv_csc_CfgInitialize(XSpmv_csc *InstancePtr, XSpmv_csc_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XSpmv_csc_Start(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL) & 0x80;
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XSpmv_csc_IsDone(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XSpmv_csc_IsIdle(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XSpmv_csc_IsReady(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XSpmv_csc_EnableAutoRestart(XSpmv_csc *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XSpmv_csc_DisableAutoRestart(XSpmv_csc *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_AP_CTRL, 0);
}

void XSpmv_csc_Set_num_rows(XSpmv_csc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_NUM_ROWS_DATA, Data);
}

u32 XSpmv_csc_Get_num_rows(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_NUM_ROWS_DATA);
    return Data;
}

void XSpmv_csc_Set_num_cols(XSpmv_csc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_NUM_COLS_DATA, Data);
}

u32 XSpmv_csc_Get_num_cols(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_NUM_COLS_DATA);
    return Data;
}

void XSpmv_csc_Set_nnz(XSpmv_csc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_NNZ_DATA, Data);
}

u32 XSpmv_csc_Get_nnz(XSpmv_csc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_NNZ_DATA);
    return Data;
}

void XSpmv_csc_Set_A_row_idx(XSpmv_csc *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_ROW_IDX_DATA, (u32)(Data));
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_ROW_IDX_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csc_Get_A_row_idx(XSpmv_csc *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_ROW_IDX_DATA);
    Data += (u64)XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_ROW_IDX_DATA + 4) << 32;
    return Data;
}

void XSpmv_csc_Set_A_col_ptr(XSpmv_csc *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_COL_PTR_DATA, (u32)(Data));
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_COL_PTR_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csc_Get_A_col_ptr(XSpmv_csc *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_COL_PTR_DATA);
    Data += (u64)XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_COL_PTR_DATA + 4) << 32;
    return Data;
}

void XSpmv_csc_Set_A_values(XSpmv_csc *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_VALUES_DATA, (u32)(Data));
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_VALUES_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csc_Get_A_values(XSpmv_csc *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_VALUES_DATA);
    Data += (u64)XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_A_VALUES_DATA + 4) << 32;
    return Data;
}

void XSpmv_csc_Set_x(XSpmv_csc *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_X_DATA, (u32)(Data));
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_X_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csc_Get_x(XSpmv_csc *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_X_DATA);
    Data += (u64)XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_X_DATA + 4) << 32;
    return Data;
}

void XSpmv_csc_Set_y(XSpmv_csc *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_Y_DATA, (u32)(Data));
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_Y_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csc_Get_y(XSpmv_csc *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_Y_DATA);
    Data += (u64)XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_Y_DATA + 4) << 32;
    return Data;
}

void XSpmv_csc_InterruptGlobalEnable(XSpmv_csc *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_GIE, 1);
}

void XSpmv_csc_InterruptGlobalDisable(XSpmv_csc *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_GIE, 0);
}

void XSpmv_csc_InterruptEnable(XSpmv_csc *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_IER);
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_IER, Register | Mask);
}

void XSpmv_csc_InterruptDisable(XSpmv_csc *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_IER);
    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_IER, Register & (~Mask));
}

void XSpmv_csc_InterruptClear(XSpmv_csc *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csc_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_ISR, Mask);
}

u32 XSpmv_csc_InterruptGetEnabled(XSpmv_csc *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_IER);
}

u32 XSpmv_csc_InterruptGetStatus(XSpmv_csc *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSpmv_csc_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSC_CONTROL_ADDR_ISR);
}

