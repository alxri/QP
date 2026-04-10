// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xmv.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XMv_CfgInitialize(XMv *InstancePtr, XMv_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->Control_bus_BaseAddress = ConfigPtr->Control_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XMv_Start(XMv *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL) & 0x80;
    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XMv_IsDone(XMv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XMv_IsIdle(XMv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XMv_IsReady(XMv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XMv_EnableAutoRestart(XMv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL, 0x80);
}

void XMv_DisableAutoRestart(XMv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_AP_CTRL, 0);
}

void XMv_Set_A(XMv *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_A_DATA, (u32)(Data));
    XMv_WriteReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_A_DATA + 4, (u32)(Data >> 32));
}

u64 XMv_Get_A(XMv *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_A_DATA);
    Data += (u64)XMv_ReadReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_A_DATA + 4) << 32;
    return Data;
}

void XMv_Set_x(XMv *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_X_DATA, (u32)(Data));
    XMv_WriteReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_X_DATA + 4, (u32)(Data >> 32));
}

u64 XMv_Get_x(XMv *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_X_DATA);
    Data += (u64)XMv_ReadReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_X_DATA + 4) << 32;
    return Data;
}

void XMv_Set_y(XMv *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_Y_DATA, (u32)(Data));
    XMv_WriteReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_Y_DATA + 4, (u32)(Data >> 32));
}

u64 XMv_Get_y(XMv *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_Y_DATA);
    Data += (u64)XMv_ReadReg(InstancePtr->Control_BaseAddress, XMV_CONTROL_ADDR_Y_DATA + 4) << 32;
    return Data;
}

void XMv_Set_rows(XMv *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_ROWS_DATA, Data);
}

u32 XMv_Get_rows(XMv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_ROWS_DATA);
    return Data;
}

void XMv_Set_columns(XMv *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_COLUMNS_DATA, Data);
}

u32 XMv_Get_columns(XMv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_COLUMNS_DATA);
    return Data;
}

void XMv_InterruptGlobalEnable(XMv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_GIE, 1);
}

void XMv_InterruptGlobalDisable(XMv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_GIE, 0);
}

void XMv_InterruptEnable(XMv *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_IER);
    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_IER, Register | Mask);
}

void XMv_InterruptDisable(XMv *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_IER);
    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_IER, Register & (~Mask));
}

void XMv_InterruptClear(XMv *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XMv_WriteReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_ISR, Mask);
}

u32 XMv_InterruptGetEnabled(XMv *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_IER);
}

u32 XMv_InterruptGetStatus(XMv *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XMv_ReadReg(InstancePtr->Control_bus_BaseAddress, XMV_CONTROL_BUS_ADDR_ISR);
}

