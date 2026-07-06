# ADMM Hardware Accelerator

Xilinx FPGA acceleration of the Alternating Direction Method of Multipliers (ADMM) optimization algorithm using HLS (High-Level Synthesis) and Vivado.

## Directory Structure

- **HLS/** — High-level synthesis code and headers for the accelerator
- **DSE/** — Design Space Exploration experiments and results (bitstream generation, parameter sweeps)
- **jupyter/** — Python/Jupyter notebooks for testing and PYNQ execution
- **scripts/** — TCL build and compilation scripts (HLS synthesis, Vivado implementation)
- **reports/** — Performance and synthesis reports
- **IP-catalog/** — Custom IP blocks

## Quick Start

1. Build HLS project:
   ```
   vivado -mode batch -source scripts/admm_HLS.tcl
   ```

2. Run co-simulation:
   ```
   vivado -mode batch -source scripts/admm_HLS_cosim.tcl
   ```

3. Generate bitstream:
   ```
   vivado -mode batch -source scripts/admm_Vivado.tcl
   ```

## Key Files

- `Makefile` — Build automation
- `admm_fixed_tiles.bit/hwh` — Pre-built bitstream and hardware definition
- `DSE/run_dse.py` — Design space exploration automation

## Requirements

- Xilinx Vivado (HLS + implementation tools)
- Python 3.x (for DSE and Jupyter notebooks)
- PYNQ framework (for board execution)
