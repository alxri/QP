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
#include "xspmv_csc.h"

extern XSpmv_csc_Config XSpmv_csc_ConfigTable[];

#ifdef SDT
XSpmv_csc_Config *XSpmv_csc_LookupConfig(UINTPTR BaseAddress) {
	XSpmv_csc_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XSpmv_csc_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XSpmv_csc_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XSpmv_csc_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSpmv_csc_Initialize(XSpmv_csc *InstancePtr, UINTPTR BaseAddress) {
	XSpmv_csc_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSpmv_csc_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSpmv_csc_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XSpmv_csc_Config *XSpmv_csc_LookupConfig(u16 DeviceId) {
	XSpmv_csc_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XSPMV_CSC_NUM_INSTANCES; Index++) {
		if (XSpmv_csc_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XSpmv_csc_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSpmv_csc_Initialize(XSpmv_csc *InstancePtr, u16 DeviceId) {
	XSpmv_csc_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSpmv_csc_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSpmv_csc_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

