#include <cmath>
#include <iomanip>
#include <iostream>

#include "axpy.h"

static const int MAX_SIZE = 1024;

static bool run_test(float a_value,
					 int size,
					 float x[MAX_SIZE],
					 float y[MAX_SIZE],
					 float tol,
					 const char *name)
{
	float result[MAX_SIZE] = {0.0f};
	float golden[MAX_SIZE] = {0.0f};

	for (int i = 0; i < size; i++) {
		golden[i] = a_value * x[i] + y[i];
	}

	axpy(a_value,
		 x,
		 y,
		 size,
		 result);

	int errors = 0;
	for (int i = 0; i < size; i++) {
		const float diff = std::fabs(result[i] - golden[i]);
		if (diff > tol) {
			if (errors < 8) {
				std::cout << "[" << name << "] mismatch at i=" << i
						  << " result=" << std::setprecision(8) << result[i]
						  << " golden=" << golden[i]
						  << " diff=" << diff << std::endl;
			}
			errors++;
		}
	}

	if (errors == 0) {
		std::cout << "[PASS] " << name << " (size=" << size << ")" << std::endl;
		return true;
	}

	std::cout << "[FAIL] " << name << " -> mismatches: " << errors << std::endl;
	return false;
}

int main()
{
	bool ok = true;
	const float tol = 1e-5f;
	float x[MAX_SIZE] = {0.0f};
	float y[MAX_SIZE] = {0.0f};

	{
		const int n = 4;
		x[0] = 1.0f;
		x[1] = -2.0f;
		x[2] = 3.5f;
		x[3] = 0.0f;

		y[0] = 0.5f;
		y[1] = 4.0f;
		y[2] = -1.0f;
		y[3] = 2.0f;

		ok &= run_test(2.0f, n, x, y, tol, "basic_small");
	}

	{
		const int n = 128;
		for (int i = 0; i < n; i++) {
			x[i] = (static_cast<float>((i * 37) % 101) - 50.0f) / 7.0f;
			y[i] = (static_cast<float>((i * 19) % 89) - 40.0f) / 9.0f;
		}
		ok &= run_test(-1.25f, n, x, y, tol, "pattern_128");
	}

	{
		const int n = 257;
		for (int i = 0; i < n; i++) {
			x[i] = static_cast<float>(i % 17) * 0.125f;
			y[i] = static_cast<float>((i % 13) - 6) * 0.375f;
		}
		ok &= run_test(0.0f, n, x, y, tol, "a_zero_257");
	}

	if (ok) {
		std::cout << "\nAll AXPY test cases passed." << std::endl;
		return 0;
	}

	std::cout << "\nAXPY testbench failed." << std::endl;
	return 1;
}

