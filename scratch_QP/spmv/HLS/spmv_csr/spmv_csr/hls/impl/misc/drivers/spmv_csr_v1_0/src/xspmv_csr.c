// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xspmv_csr.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XSpmv_csr_CfgInitialize(XSpmv_csr *InstancePtr, XSpmv_csr_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XSpmv_csr_Start(XSpmv_csr *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL) & 0x80;
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XSpmv_csr_IsDone(XSpmv_csr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XSpmv_csr_IsIdle(XSpmv_csr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XSpmv_csr_IsReady(XSpmv_csr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XSpmv_csr_EnableAutoRestart(XSpmv_csr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XSpmv_csr_DisableAutoRestart(XSpmv_csr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_AP_CTRL, 0);
}

void XSpmv_csr_Set_num_rows(XSpmv_csr *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_NUM_ROWS_DATA, Data);
}

u32 XSpmv_csr_Get_num_rows(XSpmv_csr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_NUM_ROWS_DATA);
    return Data;
}

void XSpmv_csr_Set_num_cols(XSpmv_csr *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_NUM_COLS_DATA, Data);
}

u32 XSpmv_csr_Get_num_cols(XSpmv_csr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_NUM_COLS_DATA);
    return Data;
}

void XSpmv_csr_Set_A_row_index(XSpmv_csr *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_ROW_INDEX_DATA, (u32)(Data));
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_ROW_INDEX_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csr_Get_A_row_index(XSpmv_csr *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_ROW_INDEX_DATA);
    Data += (u64)XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_ROW_INDEX_DATA + 4) << 32;
    return Data;
}

void XSpmv_csr_Set_A_col_index(XSpmv_csr *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_COL_INDEX_DATA, (u32)(Data));
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_COL_INDEX_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csr_Get_A_col_index(XSpmv_csr *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_COL_INDEX_DATA);
    Data += (u64)XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_COL_INDEX_DATA + 4) << 32;
    return Data;
}

void XSpmv_csr_Set_A_values(XSpmv_csr *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_VALUES_DATA, (u32)(Data));
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_VALUES_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csr_Get_A_values(XSpmv_csr *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_VALUES_DATA);
    Data += (u64)XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_A_VALUES_DATA + 4) << 32;
    return Data;
}

void XSpmv_csr_Set_x(XSpmv_csr *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_X_DATA, (u32)(Data));
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_X_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csr_Get_x(XSpmv_csr *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_X_DATA);
    Data += (u64)XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_X_DATA + 4) << 32;
    return Data;
}

void XSpmv_csr_Set_y(XSpmv_csr *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_Y_DATA, (u32)(Data));
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_Y_DATA + 4, (u32)(Data >> 32));
}

u64 XSpmv_csr_Get_y(XSpmv_csr *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_Y_DATA);
    Data += (u64)XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_Y_DATA + 4) << 32;
    return Data;
}

void XSpmv_csr_InterruptGlobalEnable(XSpmv_csr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_GIE, 1);
}

void XSpmv_csr_InterruptGlobalDisable(XSpmv_csr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_GIE, 0);
}

void XSpmv_csr_InterruptEnable(XSpmv_csr *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_IER);
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_IER, Register | Mask);
}

void XSpmv_csr_InterruptDisable(XSpmv_csr *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_IER);
    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_IER, Register & (~Mask));
}

void XSpmv_csr_InterruptClear(XSpmv_csr *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XSpmv_csr_WriteReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_ISR, Mask);
}

u32 XSpmv_csr_InterruptGetEnabled(XSpmv_csr *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_IER);
}

u32 XSpmv_csr_InterruptGetStatus(XSpmv_csr *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XSpmv_csr_ReadReg(InstancePtr->Control_BaseAddress, XSPMV_CSR_CONTROL_ADDR_ISR);
}

