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
// 0x10 : Data signal of num_rows
//        bit 31~0 - num_rows[31:0] (Read/Write)
// 0x14 : reserved
// 0x18 : Data signal of num_cols
//        bit 31~0 - num_cols[31:0] (Read/Write)
// 0x1c : reserved
// 0x20 : Data signal of nnz
//        bit 31~0 - nnz[31:0] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of A_row_idx
//        bit 31~0 - A_row_idx[31:0] (Read/Write)
// 0x2c : Data signal of A_row_idx
//        bit 31~0 - A_row_idx[63:32] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of A_col_ptr
//        bit 31~0 - A_col_ptr[31:0] (Read/Write)
// 0x38 : Data signal of A_col_ptr
//        bit 31~0 - A_col_ptr[63:32] (Read/Write)
// 0x3c : reserved
// 0x40 : Data signal of A_values
//        bit 31~0 - A_values[31:0] (Read/Write)
// 0x44 : Data signal of A_values
//        bit 31~0 - A_values[63:32] (Read/Write)
// 0x48 : reserved
// 0x4c : Data signal of x
//        bit 31~0 - x[31:0] (Read/Write)
// 0x50 : Data signal of x
//        bit 31~0 - x[63:32] (Read/Write)
// 0x54 : reserved
// 0x58 : Data signal of y
//        bit 31~0 - y[31:0] (Read/Write)
// 0x5c : Data signal of y
//        bit 31~0 - y[63:32] (Read/Write)
// 0x60 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define CONTROL_ADDR_AP_CTRL        0x00
#define CONTROL_ADDR_GIE            0x04
#define CONTROL_ADDR_IER            0x08
#define CONTROL_ADDR_ISR            0x0c
#define CONTROL_ADDR_NUM_ROWS_DATA  0x10
#define CONTROL_BITS_NUM_ROWS_DATA  32
#define CONTROL_ADDR_NUM_COLS_DATA  0x18
#define CONTROL_BITS_NUM_COLS_DATA  32
#define CONTROL_ADDR_NNZ_DATA       0x20
#define CONTROL_BITS_NNZ_DATA       32
#define CONTROL_ADDR_A_ROW_IDX_DATA 0x28
#define CONTROL_BITS_A_ROW_IDX_DATA 64
#define CONTROL_ADDR_A_COL_PTR_DATA 0x34
#define CONTROL_BITS_A_COL_PTR_DATA 64
#define CONTROL_ADDR_A_VALUES_DATA  0x40
#define CONTROL_BITS_A_VALUES_DATA  64
#define CONTROL_ADDR_X_DATA         0x4c
#define CONTROL_BITS_X_DATA         64
#define CONTROL_ADDR_Y_DATA         0x58
#define CONTROL_BITS_Y_DATA         64
