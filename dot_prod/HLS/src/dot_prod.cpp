#include "dot_prod.h"

// NUM_PES -> must be an integer divisor of PACK_SIZE to keep the design balanced
#define NUM_PES 4

struct xy_pair {
    float x;
    float y;
};

static void unpack_to_pes(const float16 *x,
                     const float16 *y,
                     int size_packets,
                     hls::stream<xy_pair> s[NUM_PES])
{
#pragma HLS INLINE off
    for (int p = 0; p < size_packets; p++) {
        // Read one 512-bit packet from each input, then emit 16 scalar pairs.
        const float16 xv = x[p];
        const float16 yv = y[p];

        // Emit NUM_PES pairs per cycle (one per PE). Total: PACK_SIZE pairs per packet.
        for (int lane = 0; lane < PACK_SIZE; lane += NUM_PES) {
#pragma HLS PIPELINE II = 1
            for (int pe = 0; pe < NUM_PES; pe++) {
#pragma HLS UNROLL
                s[pe].write(xy_pair{ xv[lane + pe], yv[lane + pe] });
            }
        }
    }
}

static void pe_compute(hls::stream<xy_pair> &in, int count, hls::stream<float> &out)
{
#pragma HLS INLINE off
    // FP add latency is 3 cycles in your build. Interleave 4 partial sums to
    // break the recurrence and keep II=1.
    float acc0 = 0.0f;
    float acc1 = 0.0f;
    float acc2 = 0.0f;
    float acc3 = 0.0f;

    for (int i = 0; i < count; i++) {
#pragma HLS PIPELINE II = 1
        const xy_pair v = in.read();
        const float prod = v.x * v.y;
        const float updated = acc0 + prod;
        acc0 = acc1;
        acc1 = acc2;
        acc2 = acc3;
        acc3 = updated;
    }

    out.write((acc0 + acc1) + (acc2 + acc3));
}

static void reduce_sums(hls::stream<float> p[NUM_PES], float *result)
{
#pragma HLS INLINE off
    float sum = 0.0f;
    for (int pe = 0; pe < NUM_PES; pe++) {
#pragma HLS UNROLL
        sum += p[pe].read();
    }

    // Scalar output (single float in memory).
    result[0] = sum;
}


void dot_prod(float16 *x, float16 *y, int size, float *result)
{
#pragma HLS INTERFACE m_axi port = x offset = slave bundle = gmem0 depth = 1024 max_read_burst_length = 16 num_read_outstanding = 16
#pragma HLS INTERFACE m_axi port = y offset = slave bundle = gmem1 depth = 1024 max_read_burst_length = 16 num_read_outstanding = 16
#pragma HLS INTERFACE m_axi port = result offset = slave bundle = gmem2 depth = 1

#pragma HLS INTERFACE s_axilite port = x bundle = control
#pragma HLS INTERFACE s_axilite port = y bundle = control
#pragma HLS INTERFACE s_axilite port = size bundle = control
#pragma HLS INTERFACE s_axilite port = result bundle = control
#pragma HLS INTERFACE s_axilite port = return bundle = control

    // NOTE: `size` is the number of 512-bit packets (each packet holds PACK_SIZE floats).
    const int size_packets = size;
    const int elems_per_pe = size_packets * (PACK_SIZE / NUM_PES);
    hls::stream<xy_pair> s[NUM_PES];
    hls::stream<float> p[NUM_PES];
#pragma HLS ARRAY_PARTITION variable = s complete
#pragma HLS ARRAY_PARTITION variable = p complete
#pragma HLS STREAM variable = s depth = 64
#pragma HLS STREAM variable = p depth = 2

#pragma HLS DATAFLOW
    unpack_to_pes(x, y, size_packets, s);
    for (int pe = 0; pe < NUM_PES; pe++) {
#pragma HLS UNROLL
        pe_compute(s[pe], elems_per_pe, p[pe]);
    }
    reduce_sums(p, result);
}

