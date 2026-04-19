#include "mv.h"
void mv(const float *A, const float *x, float *y, int rows, int columns)
{
#pragma HLS INTERFACE m_axi port = A offset = slave bundle = A_port
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = b_port
#pragma HLS INTERFACE m_axi port = y offset = slave bundle = c_port
#pragma HLS INTERFACE s_axilite port = rows bundle = control_bus
#pragma HLS INTERFACE s_axilite port = columns bundle = control_bus
#pragma HLS INTERFACE s_axilite port = return bundle = control_bus

    float x_buf[MAX_N];
    float row_buf[MAX_N];
#pragma HLS ARRAY_PARTITION variable = x_buf cyclic factor = 8
#pragma HLS ARRAY_PARTITION variable = row_buf cyclic factor = 8

x_buff:
    for (int i = 0; i < columns; i++)
    {
#pragma HLS PIPELINE II = 1
        x_buf[i] = x[i];
    }

row_loop:
    for (int i = 0; i < rows; i++)
    {

    col_loop:
        for (int j = 0; j < columns; j++)
        {
#pragma HLS PIPELINE II = 1
            row_buf[j] = A[i * columns + j];
        }

        float acc = 0.0f;
    mac_loop:
        for (int j = 0; j < columns; j++)
        {
#pragma HLS PIPELINE II = 1
            acc += row_buf[j] * x_buf[j];
        }
        y[i] = acc;
    }
}