// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xmv.h"

extern XMv_Config XMv_ConfigTable[];

#ifdef SDT
XMv_Config *XMv_LookupConfig(UINTPTR BaseAddress) {
	XMv_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XMv_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XMv_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XMv_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMv_Initialize(XMv *InstancePtr, UINTPTR BaseAddress) {
	XMv_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMv_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMv_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XMv_Config *XMv_LookupConfig(u16 DeviceId) {
	XMv_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XMV_NUM_INSTANCES; Index++) {
		if (XMv_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XMv_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XMv_Initialize(XMv *InstancePtr, u16 DeviceId) {
	XMv_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XMv_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XMv_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

