

// Receive canonical QP data from CVXPY with OSQP format
// Receive solver options from CVXPY (ADMM and PCG parameters)

// Prepare data for FPGA:
// - Scale with ruiz equilibration (A and P)
// - Calculate transpose of A
// - Reorder matrices P, A and A^T into tiles (TILE_ROWS x TILE_COLS) for SpMV engine
// - Initialize rho vector for ADMM

// Copy data into CMA buffers

// Write data and addresses into FPGA registers

// Call FPGA and wait for completion

// Read back results and compute performance metrics

// Return results to CVXPY
