# Build helpers for the ZCU104 (A53) software PCG benchmark.
#
# Native on-board build (Linux):
#   make CC=gcc
#
# Cross-compile on host (Ubuntu/Debian):
#   sudo apt-get install gcc-aarch64-linux-gnu
#   make CC=aarch64-linux-gnu-gcc

TARGET := pcg_sw_bench

CC ?= aarch64-linux-gnu-gcc
CC_MACHINE := $(shell $(CC) -dumpmachine 2>/dev/null)

CFLAGS_COMMON := -O3 -std=c11 -Wall -Wextra -ffast-math
CFLAGS_ARCH :=
ifneq (,$(findstring aarch64,$(CC_MACHINE)))
	CFLAGS_ARCH += -mcpu=cortex-a53
else
	CFLAGS_ARCH += -march=native
endif

CFLAGS ?= $(CFLAGS_COMMON) $(CFLAGS_ARCH)
LDLIBS ?= -lm -lrt

all: $(TARGET)

$(TARGET): pcg_sw_bench.c
	$(CC) $(CFLAGS) $< -o $@ $(LDLIBS)

clean:
	rm -f $(TARGET)
