// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XSPMV_CSC_H
#define XSPMV_CSC_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xspmv_csc_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XSpmv_csc_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XSpmv_csc;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XSpmv_csc_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XSpmv_csc_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XSpmv_csc_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XSpmv_csc_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XSpmv_csc_Initialize(XSpmv_csc *InstancePtr, UINTPTR BaseAddress);
XSpmv_csc_Config* XSpmv_csc_LookupConfig(UINTPTR BaseAddress);
#else
int XSpmv_csc_Initialize(XSpmv_csc *InstancePtr, u16 DeviceId);
XSpmv_csc_Config* XSpmv_csc_LookupConfig(u16 DeviceId);
#endif
int XSpmv_csc_CfgInitialize(XSpmv_csc *InstancePtr, XSpmv_csc_Config *ConfigPtr);
#else
int XSpmv_csc_Initialize(XSpmv_csc *InstancePtr, const char* InstanceName);
int XSpmv_csc_Release(XSpmv_csc *InstancePtr);
#endif

void XSpmv_csc_Start(XSpmv_csc *InstancePtr);
u32 XSpmv_csc_IsDone(XSpmv_csc *InstancePtr);
u32 XSpmv_csc_IsIdle(XSpmv_csc *InstancePtr);
u32 XSpmv_csc_IsReady(XSpmv_csc *InstancePtr);
void XSpmv_csc_EnableAutoRestart(XSpmv_csc *InstancePtr);
void XSpmv_csc_DisableAutoRestart(XSpmv_csc *InstancePtr);

void XSpmv_csc_Set_num_rows(XSpmv_csc *InstancePtr, u32 Data);
u32 XSpmv_csc_Get_num_rows(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_num_cols(XSpmv_csc *InstancePtr, u32 Data);
u32 XSpmv_csc_Get_num_cols(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_nnz(XSpmv_csc *InstancePtr, u32 Data);
u32 XSpmv_csc_Get_nnz(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_A_row_idx(XSpmv_csc *InstancePtr, u64 Data);
u64 XSpmv_csc_Get_A_row_idx(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_A_col_ptr(XSpmv_csc *InstancePtr, u64 Data);
u64 XSpmv_csc_Get_A_col_ptr(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_A_values(XSpmv_csc *InstancePtr, u64 Data);
u64 XSpmv_csc_Get_A_values(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_x(XSpmv_csc *InstancePtr, u64 Data);
u64 XSpmv_csc_Get_x(XSpmv_csc *InstancePtr);
void XSpmv_csc_Set_y(XSpmv_csc *InstancePtr, u64 Data);
u64 XSpmv_csc_Get_y(XSpmv_csc *InstancePtr);

void XSpmv_csc_InterruptGlobalEnable(XSpmv_csc *InstancePtr);
void XSpmv_csc_InterruptGlobalDisable(XSpmv_csc *InstancePtr);
void XSpmv_csc_InterruptEnable(XSpmv_csc *InstancePtr, u32 Mask);
void XSpmv_csc_InterruptDisable(XSpmv_csc *InstancePtr, u32 Mask);
void XSpmv_csc_InterruptClear(XSpmv_csc *InstancePtr, u32 Mask);
u32 XSpmv_csc_InterruptGetEnabled(XSpmv_csc *InstancePtr);
u32 XSpmv_csc_InterruptGetStatus(XSpmv_csc *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
