#include <cstdlib>
#include <string>

// path: bitstreams/*.bit

int load_bitstream(const char* path) {
    std::string cmd = "cat " + std::string(path) + " > /lib/firmware/xilinx/fpga_manager";
    return std::system(cmd.c_str());
}

// Provide lightweight CMA stubs for host testing when PYNQ libcma is unavailable.
extern "C" {
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