// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XMV_H
#define XMV_H

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
#include "xmv_hw.h"

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
    u64 Control_r_BaseAddress;
} XMv_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u64 Control_r_BaseAddress;
    u32 IsReady;
} XMv;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XMv_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XMv_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XMv_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XMv_ReadReg(BaseAddress, RegOffset) \
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
int XMv_Initialize(XMv *InstancePtr, UINTPTR BaseAddress);
XMv_Config* XMv_LookupConfig(UINTPTR BaseAddress);
#else
int XMv_Initialize(XMv *InstancePtr, u16 DeviceId);
XMv_Config* XMv_LookupConfig(u16 DeviceId);
#endif
int XMv_CfgInitialize(XMv *InstancePtr, XMv_Config *ConfigPtr);
#else
int XMv_Initialize(XMv *InstancePtr, const char* InstanceName);
int XMv_Release(XMv *InstancePtr);
#endif

void XMv_Start(XMv *InstancePtr);
u32 XMv_IsDone(XMv *InstancePtr);
u32 XMv_IsIdle(XMv *InstancePtr);
u32 XMv_IsReady(XMv *InstancePtr);
void XMv_EnableAutoRestart(XMv *InstancePtr);
void XMv_DisableAutoRestart(XMv *InstancePtr);

void XMv_Set_rows(XMv *InstancePtr, u32 Data);
u32 XMv_Get_rows(XMv *InstancePtr);
void XMv_Set_columns(XMv *InstancePtr, u32 Data);
u32 XMv_Get_columns(XMv *InstancePtr);
void XMv_Set_A(XMv *InstancePtr, u64 Data);
u64 XMv_Get_A(XMv *InstancePtr);
void XMv_Set_x(XMv *InstancePtr, u64 Data);
u64 XMv_Get_x(XMv *InstancePtr);
void XMv_Set_y(XMv *InstancePtr, u64 Data);
u64 XMv_Get_y(XMv *InstancePtr);

void XMv_InterruptGlobalEnable(XMv *InstancePtr);
void XMv_InterruptGlobalDisable(XMv *InstancePtr);
void XMv_InterruptEnable(XMv *InstancePtr, u32 Mask);
void XMv_InterruptDisable(XMv *InstancePtr, u32 Mask);
void XMv_InterruptClear(XMv *InstancePtr, u32 Mask);
u32 XMv_InterruptGetEnabled(XMv *InstancePtr);
u32 XMv_InterruptGetStatus(XMv *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
