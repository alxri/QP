// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
// Tool Version Limit: 2024.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
// control
// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of A
//        bit 31~0 - A[31:0] (Read/Write)
// 0x14 : Data signal of A
//        bit 31~0 - A[63:32] (Read/Write)
// 0x18 : reserved
// 0x1c : Data signal of x
//        bit 31~0 - x[31:0] (Read/Write)
// 0x20 : Data signal of x
//        bit 31~0 - x[63:32] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of y
//        bit 31~0 - y[31:0] (Read/Write)
// 0x2c : Data signal of y
//        bit 31~0 - y[63:32] (Read/Write)
// 0x30 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XMV_CONTROL_ADDR_A_DATA 0x10
#define XMV_CONTROL_BITS_A_DATA 64
#define XMV_CONTROL_ADDR_X_DATA 0x1c
#define XMV_CONTROL_BITS_X_DATA 64
#define XMV_CONTROL_ADDR_Y_DATA 0x28
#define XMV_CONTROL_BITS_Y_DATA 64

// control_bus
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of rows
//        bit 31~0 - rows[31:0] (Read/Write)
// 0x14 : reserved
// 0x18 : Data signal of columns
//        bit 31~0 - columns[31:0] (Read/Write)
// 0x1c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XMV_CONTROL_BUS_ADDR_AP_CTRL      0x00
#define XMV_CONTROL_BUS_ADDR_GIE          0x04
#define XMV_CONTROL_BUS_ADDR_IER          0x08
#define XMV_CONTROL_BUS_ADDR_ISR          0x0c
#define XMV_CONTROL_BUS_ADDR_ROWS_DATA    0x10
#define XMV_CONTROL_BUS_BITS_ROWS_DATA    32
#define XMV_CONTROL_BUS_ADDR_COLUMNS_DATA 0x18
#define XMV_CONTROL_BUS_BITS_COLUMNS_DATA 32

