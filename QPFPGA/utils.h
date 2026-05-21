#include <cstdint>
#include <cstring>
#include <vector>
#include <iostream>
#include <cmath>
#include "admm_pcg_params.h"
#include "fpga_params.h"

using namespace std;

struct int32_words { int32_t data[PACK_SIZE]; };
struct float32_words { float data[PACK_SIZE]; };

// Expose helper functions and types from utils.cpp for external callers
extern "C" {
	void* cma_alloc(uint32_t len, uint32_t cacheable);
	unsigned long cma_get_phy_addr(void *buf);
	void cma_free(void *buf);
	void cma_flush_cache(void *buf, unsigned long phys_addr, int size);
	void cma_invalidate_cache(void *buf, unsigned long phys_addr, int size);
}

double get_time_ms();
void write_reg(void *base, uint32_t offset, uint32_t val);
uint32_t read_reg(void *base, uint32_t offset);
void write_64bit_address(void *base, uint32_t offset, uintptr_t address);
uint32_t float_to_uint(float f);
float uint_to_float(uint32_t u);
int ceil_div(int a, int b);

// CMA Memory Tracker (usable from other compilation units)
struct CmaTracker {
	std::vector<void*> bufs;
	std::vector<size_t> sizes;

	template <typename T>
	T* alloc(size_t elements) {
		size_t bytes = elements * sizeof(T);
		T* ptr = (T*)cma_alloc(bytes, 1);
		if (!ptr) { std::cout << "CMA allocation failed." << std::endl; exit(1); }
		memset(ptr, 0, bytes);
		bufs.push_back(ptr);
		sizes.push_back(bytes);
		return ptr;
	}

	void flush_all() {
		for (size_t i = 0; i < bufs.size(); ++i) {
			cma_flush_cache(bufs[i], cma_get_phy_addr(bufs[i]), sizes[i]);
		}
	}

	void invalidate_all() {
		for (size_t i = 0; i < bufs.size(); ++i) {
			cma_invalidate_cache(bufs[i], cma_get_phy_addr(bufs[i]), sizes[i]);
		}
	}

	void free_all() {
		for (void* ptr : bufs) cma_free(ptr);
		bufs.clear(); sizes.clear();
	}
};

// Tiled matrix descriptor (same layout used by accelerator)
struct TiledMatrix {
	int rtiles, ctiles;
	std::vector<int> counts, noff, coff, cptr, ridx;
	std::vector<float> vals;
};

TiledMatrix build_tiled_csc(int global_rows, int global_cols, const std::vector<int>& cptr_in, const std::vector<int>& ridx_in, const std::vector<float>& vals_in);
void transpose_csc(int rows, int cols, const std::vector<int>& cptr, const std::vector<int>& ridx, const std::vector<float>& vals, std::vector<int>& cptr_t, std::vector<int>& ridx_t, std::vector<float>& vals_t);

void ruiz_equilibration(
	int NUM_ROWS,
	int NUM_COLS,
	const std::vector<int>& A_cptr,
	const std::vector<int>& A_ridx,
	std::vector<float>& A_vals,
	std::vector<float>& P_diag,
	std::vector<float>& q,
	std::vector<float>& l,
	std::vector<float>& u,
	std::vector<float>& D,
	std::vector<float>& E,
	int iterations = 10);

std::vector<float> build_rho_vector(int NUM_ROWS, const std::vector<float>& l, const std::vector<float>& u);

// cma_copy is implemented in utils.cpp
template <typename T>
void cma_copy(T* dest, const T* src, size_t elements) {
	memcpy(dest, src, elements * sizeof(T));
}
