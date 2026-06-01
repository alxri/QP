#include <cstdlib>
#include <string>
#include <vector>
#include "utils.h"
#include "fpga_utils.h"

// PYNQ libcma exports
extern "C" {
    void* cma_alloc(uint32_t len, uint32_t cacheable);
    unsigned long cma_get_phy_addr(void *buf);
    void cma_free(void *buf);
    void cma_flush_cache(void *buf, unsigned long phys_addr, int size);
    void cma_invalidate_cache(void *buf, unsigned long phys_addr, int size);
}

// Provide lightweight CMA stubs for host testing when PYNQ libcma is unavailable.
// Mark as weak so a real PYNQ libcma implementation can override these symbols
// when present on the target system.
extern "C" {
    void* cma_alloc(uint32_t len, uint32_t cacheable) __attribute__((weak));
    unsigned long cma_get_phy_addr(void *buf) __attribute__((weak));
    void cma_free(void *buf) __attribute__((weak));
    void cma_flush_cache(void *buf, unsigned long phys_addr, int size) __attribute__((weak));
    void cma_invalidate_cache(void *buf, unsigned long phys_addr, int size) __attribute__((weak));

    void* cma_alloc(uint32_t len, uint32_t cacheable) {
        (void)cacheable;
        return std::malloc(len);
    }
    unsigned long cma_get_phy_addr(void *buf) {
        // On host we cannot provide a real physical address; return the pointer value cast.
        return (unsigned long)buf;
    }
    void cma_free(void *buf) { std::free(buf); }
    void cma_flush_cache(void *buf, unsigned long phys_addr, int size) { (void)buf; (void)phys_addr; (void)size; }
    void cma_invalidate_cache(void *buf, unsigned long phys_addr, int size) { (void)buf; (void)phys_addr; (void)size; }
}

// cma_copy is implemented in utils.cpp

// path: bitstreams/*.bit

int load_bitstream(const char* path) {
    // Prefer the canonical firmware/sysfs programming method: copy the bitstream
    // into /lib/firmware and write the filename into the FPGA manager sysfs
    // node. Fall back to a direct copy attempt if sysfs path differs.
    std::string src(path);
    std::string fname = src.substr(src.find_last_of("/\\") + 1);
    std::string staged = std::string("/lib/firmware/") + fname;
    std::string sysfs_firmware = "/sys/class/fpga_manager/fpga0/firmware";
    std::string alternate_sysfs = "/sys/class/fpga_manager/fpga_manager/firmware";

    // Copy to /lib/firmware
    std::string copy_cmd = "cp -f '" + src + "' '" + staged + "'";
    int rc = std::system(copy_cmd.c_str());
    if (rc != 0) {
        // Attempt a direct cat to firmware node as a last resort (may require root)
        std::string direct_cmd = "cat '" + src + "' > /lib/firmware/xilinx/fpga_manager";
        return std::system(direct_cmd.c_str());
    }

    // Write the filename into sysfs to trigger programming
    std::string echo_cmd = "echo '" + fname + "' > " + sysfs_firmware;
    rc = std::system(echo_cmd.c_str());
    if (rc == 0) return 0;

    // Try alternate sysfs location
    echo_cmd = "echo '" + fname + "' > " + alternate_sysfs;
    rc = std::system(echo_cmd.c_str());
    return rc;
}

void write_reg(void *base, uint32_t offset, uint32_t val) { *((volatile uint32_t *)((uint8_t *)base + offset)) = val; }
uint32_t read_reg(void *base, uint32_t offset) { return *((volatile uint32_t *)((uint8_t *)base + offset)); }
void write_64bit_address(void *base, uint32_t offset, uintptr_t address) {
    write_reg(base, offset, (uint32_t)(address & 0xFFFFFFFF));
    write_reg(base, offset + 0x04, (uint32_t)((uint64_t)address >> 32));
}

// Program a list of (offset, physical_address) into the control_r registers
void program_cma_addresses(void* ctrl_r, const std::vector<std::pair<uint32_t, uintptr_t>>& addr_list) {
    for (const auto &p : addr_list) {
        write_64bit_address(ctrl_r, p.first, p.second);
    }
}



// Allocate CMA buffers for CSC arrays and copy packed-word data into them.
void allocate_and_copy_csc_to_cma(
    CmaTracker& cma,
    const std::vector<int>& cptr,
    const std::vector<int>& ridx,
    const std::vector<float>& vals,
    int32_words** out_ridx_reg,
    float32_words** out_vals_reg,
    int** out_cptr_reg,
    int* out_words_cnt)
{
    int words_cnt = ceil_div((int)vals.size(), PACK_SIZE);
    // allocate CMA buffers
    int32_words* reg_ridx = cma.alloc<int32_words>(words_cnt);
    float32_words* reg_vals = cma.alloc<float32_words>(words_cnt);
    int* reg_cptr = cma.alloc<int>(cptr.size());

    // Pack into temporary word arrays then copy
    std::vector<int32_words> temp_ridx;
    std::vector<float32_words> temp_vals;
    pack_indices_to_words(ridx, temp_ridx);
    pack_vals_to_words(vals, temp_vals);

    cma_copy(reg_cptr, cptr.data(), (size_t)cptr.size());
    cma_copy(reg_ridx, temp_ridx.data(), (size_t)words_cnt);
    cma_copy(reg_vals, temp_vals.data(), (size_t)words_cnt);

    *out_ridx_reg = reg_ridx;
    *out_vals_reg = reg_vals;
    *out_cptr_reg = reg_cptr;
    *out_words_cnt = words_cnt;
}