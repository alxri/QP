# ==============================================================
# Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2024.2 (64-bit)
# Tool Version Limit: 2024.11
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
# 
# ==============================================================
cmake_minimum_required(VERSION 3.15)
project(spmv_csr)
find_package(common)
collector_create (PROJECT_LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}")
collect (PROJECT_LIB_SOURCES xspmv_csr.c)
collect (PROJECT_LIB_SOURCES xspmv_csr_sinit.c)
collect (PROJECT_LIB_SOURCES xspmv_csr_linux.c)
collect (PROJECT_LIB_SOURCES xspmv_csr_g.c)
collector_list (_sources PROJECT_LIB_SOURCES)
collector_create (PROJECT_LIB_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}")
collect (PROJECT_LIB_HEADERS xspmv_csr.h)
collect (PROJECT_LIB_HEADERS xspmv_csr_hw.h)
collector_list (_headers PROJECT_LIB_HEADERS)
file(COPY ${_headers} DESTINATION ${CMAKE_BINARY_DIR}/include)
include_directories(${CMAKE_BINARY_DIR}/include)
add_library(spmv_csr STATIC ${_sources})
set_target_properties(spmv_csr PROPERTIES LINKER_LANGUAGE C)

