# QP FPGA Workspace

This repository collects FPGA-oriented implementations and experiments for quadratic programming and related sparse linear algebra kernels.

The `admm/` directory contains the final HLS implementation of the full accelerator stack:

- ADMM controller
- PCG solver components
- SpMV engine

The other top-level directories contain intermediate implementations, kernel prototypes, benchmarks, and scratch explorations.

## Repository Layout

- `admm/` - final accelerator implementation and build artifacts
- `QPFPGA/` - Implemented QP solver accelerator with compiled bitstreams. Includes the benchmark.


### Prototyping and testing directorios
- `axpy/` - AXPY kernel prototype and HLS flow
- `dot_prod/` - dot-product kernel prototype and HLS flow
- `pcg/` - PCG accelerator work, software, and test collateral
- `spmv_coo/` - sparse matrix-vector multiply using COO format
- `spmv_csc/` - sparse matrix-vector multiply using CSC format
- `scratch_admm/` - ADMM design-space exploration and experimental variants
- `scratch_QP/` - scratch work for QP-related matrix-vector kernels and optimizations
- `tiled_spmv_csc/` - tiled CSC SpMV experiments


## Notes

- For the final accelerator architecture and build flow, see [admm/README.md](admm/README.md).
- For the QPFPGA software package and Python usage, see [QPFPGA/README.md](QPFPGA/README.md).
