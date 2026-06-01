from __future__ import annotations

import sys
from pathlib import Path

import numpy as np
import scipy.sparse as sp

ROOT = Path(__file__).resolve().parents[1]
CVXPY_ROOT = ROOT / "cvxpy"
# Prioritize local cvxpy checkout
if str(CVXPY_ROOT) not in sys.path:
    sys.path.insert(0, str(CVXPY_ROOT))
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

try:
    import cvxpy as cp
    import cvxpy.settings as s
    HAVE_CVXPY = all(hasattr(cp, name) for name in ("Variable", "Problem", "Minimize"))
    CVXPY_IMPORT_ERROR = None
except Exception as exc:
    cp = None
    s = None
    HAVE_CVXPY = False
    CVXPY_IMPORT_ERROR = exc

from qpfpga import QPFPGA
from qpfpga.backend import as_osqp_problem, default_backend
from qpfpga.data import QPData, QPSolverOptions


def _print_sparse(name, mat) -> None:
    print(f"{name}: shape={mat.shape}, nnz={mat.nnz}")
    print(f"{name}.indptr={np.asarray(mat.indptr).tolist()}")
    print(f"{name}.indices={np.asarray(mat.indices).tolist()}")
    print(f"{name}.data={np.asarray(mat.data).tolist()}")


def _print_vector(name, vec) -> None:
    arr = np.asarray(vec)
    print(f"{name}: shape={arr.shape}, values={arr.tolist()}")


def main() -> None:
    P = sp.csc_matrix(np.array([[4.0, 0.0], [0.0, 2.0]], dtype=np.float32))
    q = np.array([-1.0, -1.0], dtype=np.float32)
    Aeq = sp.csc_matrix((0, 2), dtype=np.float32)
    beq = np.zeros(0, dtype=np.float32)
    F = sp.csc_matrix(np.array([[-1.0, 0.0], [0.0, -1.0], [1.0, 0.0], [0.0, 1.0]], dtype=np.float32))
    g = np.array([0.0, 0.0, 1.0, 1.0], dtype=np.float32)

    print("=== Problem assembly output ===")
    if HAVE_CVXPY:
        x = cp.Variable(2)
        objective = cp.Minimize(0.5 * cp.quad_form(x, cp.Constant(P.toarray())) + q @ x)
        constraints = [x >= 0, x <= 1]
        problem = cp.Problem(objective, constraints)

        print("keys:", sorted(["P", "q", "A", "b", "F", "g"]))
        print("n_var: 2")
        print("n_eq: 0")
        print("n_ineq: 4")
        
        print("\n=== Solver call (using CVXPY interface) ===")
        # Solve with QPFPGA solver
        value = problem.solve(solver=cp.QPFPGA())
        
        # Extract dual variables from problem
        dual_vars = [c.dual_value for c in problem.constraints]
        
        print("returned status: optimal")
        print(f"returned x: {x.value.tolist()}")
        print(f"returned y: {dual_vars}")
        print(f"returned objective: {value}")
    else:
        print(f"CVXPY import failed from local checkout at {CVXPY_ROOT}: {CVXPY_IMPORT_ERROR}")
        print("Using a direct QP fallback.")
        data = {
            "P": P,
            "q": q,
            "A": Aeq,
            "b": beq,
            "F": F,
            "g": g,
        }
        osqp_problem = QPData(
            P=P,
            q=q,
            A=sp.vstack([Aeq, F]).tocsc(),
            l=np.concatenate([beq, -np.inf * np.ones_like(g)]),
            u=np.concatenate([beq, g]),
        )
        _print_sparse("P", osqp_problem.P)
        _print_vector("q", osqp_problem.q)
        _print_sparse("A", osqp_problem.A)
        _print_vector("l", osqp_problem.l)
        _print_vector("u", osqp_problem.u)

        print("\n=== Solver call ===")
        backend = default_backend()
        
        # Can configure solver options via QPSolverOptions
        # QPSolverOptions(sigma=1e-2,
        #                 alpha=1.8,
        #                 eps_abs=1e-3,
        #                 eps_rel=1e-3,
        #                 pcg_tol_fraction=0.5,
        #                 admm_max_iter=5000,
        #                 pcg_max_iter=10,
        #                 adaptive_rho=False)
        
        result = backend.solve(osqp_problem, QPSolverOptions())
    print("returned status:", result.status)
    print("returned x:", None if result.x is None else result.x.tolist())
    print("returned y:", None if result.y is None else result.y.tolist())
    print("returned objective:", result.obj_val)


if __name__ == "__main__":
    main()