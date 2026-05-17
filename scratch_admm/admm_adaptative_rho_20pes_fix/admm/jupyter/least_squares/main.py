import cvxpy as cp
from cvxpygen import cpg
import numpy as np
import scipy.sparse as sp
import time
import sys
import os

if __name__ == "__main__":

    '''
    1. Define Problem (Targeting 1024x1024 OSQP size)
    '''
    # To get a 1024x1024 OSQP matrix, m + n must equal 1024.
    m, n = 512, 512
    x = cp.Variable(n, name='x')

    # Generate a random sparse structure FIRST (e.g., 5% density)
    np.random.seed(1)
    A_sparse_matrix = sp.random(m, n, density=0.001, format='coo', random_state=1)

    # Tell CVXPY to use the exact row/col sparsity pattern we just generated
    A = cp.Parameter((m, n), name='A', sparsity=(A_sparse_matrix.row, A_sparse_matrix.col))
    b = cp.Parameter(m, name='b')
    
    problem = cp.Problem(cp.Minimize(cp.sum_squares(A @ x - b)), [x >= 0])

    # assign parameter values and test-solve
    A.value_sparse = A_sparse_matrix
    b.value = np.random.randn(m)
    
    # -----------------------------------------------------------------
    # EXPORT OSQP CANONICAL DATA FOR FPGA
    # -----------------------------------------------------------------
    print("\n--- Exporting OSQP Data ---")
    data, chain, inverse_data = problem.get_problem_data(cp.OSQP)

    P_osqp = data['P']
    q_osqp = data['q']
    A_eq = data['A']
    b_eq = data['b']
    F_ineq = data['F']
    G_ineq = data['G']

    # Build full OSQP constraint matrix
    A_osqp = sp.vstack([A_eq, F_ineq]).tocsc()

    # Final OSQP bounds
    l_osqp = np.hstack([b_eq, -np.inf * np.ones(F_ineq.shape[0])])
    u_osqp = np.hstack([b_eq, G_ineq])

    # Print dimensions
    print("P shape:", P_osqp.shape)
    print("q shape:", q_osqp.shape)
    print("A shape:", A_osqp.shape)
    print("l shape:", l_osqp.shape)
    print("u shape:", u_osqp.shape)

    # Ensure data directory exists
    os.makedirs("data", exist_ok=True)

    # Export sparse matrices
    sp.save_npz("data/P.npz", P_osqp)
    sp.save_npz("data/A.npz", A_osqp)

    # Export vectors
    np.save("data/q.npy", q_osqp)
    np.save("data/l.npy", l_osqp)
    np.save("data/u.npy", u_osqp)
    print("Exported OSQP canonicalized QP data to ./data/\n")
    # -----------------------------------------------------------------

    '''
    2. Generate Code
    '''
    # generate code
    #cpg.generate_code(problem, code_dir='nonneg_LS', solver='OSQP')

    '''
    3. Solve & Compare
    '''
    # solve problem conventionally
    t0 = time.time()
    val = problem.solve(solver='OSQP')
    t1 = time.time()
    
    sys.stdout.write('\nCVXPY\nSolve time: %.3f ms\n' % (1000*(t1-t0)))
    
    # FIX: Print just the first 5 elements so we don't crash the console
    sys.stdout.write('Primal solution (first 5 elements): %s\n' % np.array2string(x.value[:5], precision=6))
    sys.stdout.write('Dual solution   (first 5 elements): %s\n' % np.array2string(problem.constraints[0].dual_value[:5], precision=6))
    sys.stdout.write('Objective function value: %.6f\n' % val)

    # solve problem with C code via python wrapper
    # t0 = time.time()
    # val = problem.solve(method='CPG', updated_params=['A', 'b'])
    # t1 = time.time()
    # sys.stdout.write('\nCVXPYgen\nSolve time: %.3f ms\n' % (1000 * (t1 - t0)))
    # sys.stdout.write('Primal solution: x = [%.6f, %.6f]\n' % tuple(x.value))
    # sys.stdout.write('Dual solution: d0 = [%.6f, %.6f]\n' % tuple(problem.constraints[0].dual_value))
    # sys.stdout.write('Objective function value: %.6f\n' % val)