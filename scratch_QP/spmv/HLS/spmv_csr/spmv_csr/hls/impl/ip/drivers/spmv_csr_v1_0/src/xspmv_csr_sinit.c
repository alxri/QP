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
#include "xspmv_csr.h"

extern XSpmv_csr_Config XSpmv_csr_ConfigTable[];

#ifdef SDT
XSpmv_csr_Config *XSpmv_csr_LookupConfig(UINTPTR BaseAddress) {
	XSpmv_csr_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XSpmv_csr_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XSpmv_csr_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XSpmv_csr_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSpmv_csr_Initialize(XSpmv_csr *InstancePtr, UINTPTR BaseAddress) {
	XSpmv_csr_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSpmv_csr_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSpmv_csr_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XSpmv_csr_Config *XSpmv_csr_LookupConfig(u16 DeviceId) {
	XSpmv_csr_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XSPMV_CSR_NUM_INSTANCES; Index++) {
		if (XSpmv_csr_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XSpmv_csr_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSpmv_csr_Initialize(XSpmv_csr *InstancePtr, u16 DeviceId) {
	XSpmv_csr_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSpmv_csr_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSpmv_csr_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

