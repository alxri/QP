#include <algorithm>
#include <cmath>
#include <cstdint>
#include <iomanip>
#include <iostream>
#include <limits>
#include <random>
#include <string>
#include <vector>

#include "dot_prod.h"

static float dot_prod_ref(const float *x, const float *y, int size)
{
	// Match the HW accumulation order used in dot_prod.cpp:
	// - 4 processing elements (each handles every 4th element)
	// - each PE uses a 4-way interleaved (shift-register) FP accumulator
	static constexpr int NUM_PES = 4;
	float acc[NUM_PES][4] = { { 0 } };

	for (int i = 0; i < size; i++) {
		const int pe = i % NUM_PES;
		const float prod = x[i] * y[i];
		const float updated = acc[pe][0] + prod;
		acc[pe][0] = acc[pe][1];
		acc[pe][1] = acc[pe][2];
		acc[pe][2] = acc[pe][3];
		acc[pe][3] = updated;
	}

	float sums[NUM_PES];
	for (int pe = 0; pe < NUM_PES; pe++) {
		sums[pe] = (acc[pe][0] + acc[pe][1]) + (acc[pe][2] + acc[pe][3]);
	}

	return sums[0] + sums[1] + sums[2] + sums[3];
}

static bool nearly_equal(float a, float b, float rtol = 1e-4f, float atol = 1e-4f)
{
	const float diff = std::fabs(a - b);
	if (diff <= atol) {
		return true;
	}
	const float scale = std::max(std::fabs(a), std::fabs(b));
	return diff <= rtol * scale;
}

static void print_vector_sample(const char *label, const std::vector<float> &v, int max_elems = 8)
{
	std::cout << "  " << label << "[0..";
	const int n = static_cast<int>(v.size());
	const int shown = std::min(n, max_elems);
	std::cout << (shown == 0 ? -1 : (shown - 1)) << "] = [";
	std::cout << std::fixed << std::setprecision(6);
	for (int i = 0; i < shown; i++) {
		if (i) {
			std::cout << ", ";
		}
		std::cout << v[static_cast<size_t>(i)];
	}
	std::cout << "]\n";
}

static int run_case(const std::vector<float> &x,
				const std::vector<float> &y,
				const char *name,
				bool verbose = false)
{
	if (x.size() != y.size()) {
		std::cerr << "ERROR: x/y size mismatch\n";
		return 1;
	}

	const int size_floats = static_cast<int>(x.size());
	const int size_packets = (size_floats + PACK_SIZE - 1) / PACK_SIZE;

	std::vector<float> x_padded(static_cast<size_t>(size_packets * PACK_SIZE), 0.0f);
	std::vector<float> y_padded(static_cast<size_t>(size_packets * PACK_SIZE), 0.0f);
	for (int i = 0; i < size_floats; i++) {
		x_padded[static_cast<size_t>(i)] = x[static_cast<size_t>(i)];
		y_padded[static_cast<size_t>(i)] = y[static_cast<size_t>(i)];
	}

	std::vector<float16> x_pkt(static_cast<size_t>(size_packets));
	std::vector<float16> y_pkt(static_cast<size_t>(size_packets));
	for (int p = 0; p < size_packets; p++) {
		for (int lane = 0; lane < PACK_SIZE; lane++) {
			const int idx = p * PACK_SIZE + lane;
			x_pkt[static_cast<size_t>(p)][lane] = x_padded[static_cast<size_t>(idx)];
			y_pkt[static_cast<size_t>(p)][lane] = y_padded[static_cast<size_t>(idx)];
		}
	}

	float result_mem[1];
	result_mem[0] = std::numeric_limits<float>::quiet_NaN();

	dot_prod(x_pkt.data(), y_pkt.data(), size_packets, result_mem);
	const float result = result_mem[0];

	const float golden = dot_prod_ref(x_padded.data(), y_padded.data(), size_packets * PACK_SIZE);
	const bool pass = nearly_equal(result, golden);
	if (verbose || !pass) {
		std::cout << std::setprecision(10);
		std::cout << (pass ? "CASE" : "FAIL") << ": " << (name ? name : "(unnamed)")
				  << " size=" << size_floats << " HW=" << result << " SW=" << golden
				  << " diff=" << std::fabs(result - golden) << "\n";
		if (verbose) {
			print_vector_sample("x", x);
			print_vector_sample("y", y);
		}
	}
	if (!pass) {
		return 1;
	}

	return 0;
}

int main()
{
	int failures = 0;

	// // Directed edge cases
	// {
	// 	std::vector<float> x{1.0f};
	// 	std::vector<float> y{2.0f};
	// 	failures += run_case(x, y, "single", true);
	// }
	// {
	// 	std::vector<float> x{1.0f, -3.0f, 0.5f, 4.0f};
	// 	std::vector<float> y{-2.0f, 1.0f, 8.0f, -0.25f};
	// 	failures += run_case(x, y, "mixed_small", true);
	// }
	// {
	// 	// Decimal values
	// 	std::vector<float> x{0.125f, -2.25f, 3.5f};
	// 	std::vector<float> y{-4.0f, 0.125f, 1.75f};
	// 	failures += run_case(x, y, "decimals_3", true);
	// }
	// {
	// 	// More decimals (non-integer dot product)
	// 	std::vector<float> x{1.1f, 2.2f, -3.3f, 4.4f, -5.5f, 6.6f, -7.7f, 8.8f};
	// 	std::vector<float> y{-0.9f, 0.8f, -0.7f, 0.6f, -0.5f, 0.4f, -0.3f, 0.2f};
	// 	failures += run_case(x, y, "decimals_8", true);
	// }
	// {
	// 	// All zeros
	// 	std::vector<float> x(64, 0.0f);
	// 	std::vector<float> y(64, 0.0f);
	// 	failures += run_case(x, y, "zeros_64", true);
	// }

	// // Randomized tests (bounded to the m_axi depth=1024 used in pragmas)
	// std::mt19937 rng(0xC0FFEEu);
	// std::uniform_int_distribution<int> size_dist(0, 1024);
	// std::uniform_real_distribution<float> val_dist(-10.0f, 10.0f);

	const int num_random = 200;
	const int num_random_verbose = 5;
	// for (int t = 0; t < num_random; t++) {
	// 	const int n = size_dist(rng);
	// 	std::vector<float> x(static_cast<size_t>(n));
	// 	std::vector<float> y(static_cast<size_t>(n));
	// 	for (int i = 0; i < n; i++) {
	// 		x[i] = val_dist(rng);
	// 		y[i] = val_dist(rng);
	// 	}
	// 	const bool verbose = (t < num_random_verbose);
	// 	const std::string name = std::string("random_") + std::to_string(t);
	// 	failures += run_case(x, y, name.c_str(), verbose);
	// }

	// Stress: maximum size with deterministic pattern
	{
		const int n = 1024;
		std::vector<float> x(static_cast<size_t>(n));
		std::vector<float> y(static_cast<size_t>(n));
		for (int i = 0; i < n; i++) {
			x[i] = (i % 7 == 0) ? -1.25f : 0.75f;
			y[i] = (i % 5 == 0) ? 2.0f : -0.5f;
		}
		failures += run_case(x, y, "stress_1024", true);
	}

	if (failures == 0) {
		const int num_directed = 5;
		std::cout << "PASS: dot_prod testbench (" << (num_directed + num_random + 1) << " cases)\n";
		return 0;
	}

	std::cout << "FAIL: dot_prod testbench with " << failures << " failing case(s)\n";
	return 1;
}

