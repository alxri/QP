cmake_minimum_required(VERSION 3.16)
project(qpfpga_solver LANGUAGES CXX)

add_library(qpfpga SHARED
    src/api.cpp
    src/utils.cpp
    src/fpga_utils.cpp
)

target_include_directories(qpfpga
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_compile_features(qpfpga PUBLIC cxx_std_17)