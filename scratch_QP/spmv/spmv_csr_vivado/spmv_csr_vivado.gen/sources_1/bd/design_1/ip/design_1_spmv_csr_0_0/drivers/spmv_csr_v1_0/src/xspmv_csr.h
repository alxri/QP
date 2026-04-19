// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XSPMV_CSR_H
#define XSPMV_CSR_H

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
#include "xspmv_csr_hw.h"

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
} XSpmv_csr_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XSpmv_csr;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XSpmv_csr_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XSpmv_csr_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XSpmv_csr_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XSpmv_csr_ReadReg(BaseAddress, RegOffset) \
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
int XSpmv_csr_Initialize(XSpmv_csr *InstancePtr, UINTPTR BaseAddress);
XSpmv_csr_Config* XSpmv_csr_LookupConfig(UINTPTR BaseAddress);
#else
int XSpmv_csr_Initialize(XSpmv_csr *InstancePtr, u16 DeviceId);
XSpmv_csr_Config* XSpmv_csr_LookupConfig(u16 DeviceId);
#endif
int XSpmv_csr_CfgInitialize(XSpmv_csr *InstancePtr, XSpmv_csr_Config *ConfigPtr);
#else
int XSpmv_csr_Initialize(XSpmv_csr *InstancePtr, const char* InstanceName);
int XSpmv_csr_Release(XSpmv_csr *InstancePtr);
#endif

void XSpmv_csr_Start(XSpmv_csr *InstancePtr);
u32 XSpmv_csr_IsDone(XSpmv_csr *InstancePtr);
u32 XSpmv_csr_IsIdle(XSpmv_csr *InstancePtr);
u32 XSpmv_csr_IsReady(XSpmv_csr *InstancePtr);
void XSpmv_csr_EnableAutoRestart(XSpmv_csr *InstancePtr);
void XSpmv_csr_DisableAutoRestart(XSpmv_csr *InstancePtr);

void XSpmv_csr_Set_num_rows(XSpmv_csr *InstancePtr, u32 Data);
u32 XSpmv_csr_Get_num_rows(XSpmv_csr *InstancePtr);
void XSpmv_csr_Set_num_cols(XSpmv_csr *InstancePtr, u32 Data);
u32 XSpmv_csr_Get_num_cols(XSpmv_csr *InstancePtr);
void XSpmv_csr_Set_A_row_index(XSpmv_csr *InstancePtr, u64 Data);
u64 XSpmv_csr_Get_A_row_index(XSpmv_csr *InstancePtr);
void XSpmv_csr_Set_A_col_index(XSpmv_csr *InstancePtr, u64 Data);
u64 XSpmv_csr_Get_A_col_index(XSpmv_csr *InstancePtr);
void XSpmv_csr_Set_A_values(XSpmv_csr *InstancePtr, u64 Data);
u64 XSpmv_csr_Get_A_values(XSpmv_csr *InstancePtr);
void XSpmv_csr_Set_x(XSpmv_csr *InstancePtr, u64 Data);
u64 XSpmv_csr_Get_x(XSpmv_csr *InstancePtr);
void XSpmv_csr_Set_y(XSpmv_csr *InstancePtr, u64 Data);
u64 XSpmv_csr_Get_y(XSpmv_csr *InstancePtr);

void XSpmv_csr_InterruptGlobalEnable(XSpmv_csr *InstancePtr);
void XSpmv_csr_InterruptGlobalDisable(XSpmv_csr *InstancePtr);
void XSpmv_csr_InterruptEnable(XSpmv_csr *InstancePtr, u32 Mask);
void XSpmv_csr_InterruptDisable(XSpmv_csr *InstancePtr, u32 Mask);
void XSpmv_csr_InterruptClear(XSpmv_csr *InstancePtr, u32 Mask);
u32 XSpmv_csr_InterruptGetEnabled(XSpmv_csr *InstancePtr);
u32 XSpmv_csr_InterruptGetStatus(XSpmv_csr *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
