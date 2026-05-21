from __future__ import annotations

import sys
from pathlib import Path

import numpy as np
import scipy.sparse as sp

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

try:
    import cvxpy as cp
    import cvxpy.settings as s
    HAVE_CVXPY = all(hasattr(cp, name) for name in ("Variable", "Problem", "Minimize"))
except Exception:
    cp = None
    s = None
    HAVE_CVXPY = False

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
        solver = QPFPGA()

        data, chain, inverse_data = problem.get_problem_data(solver)
        print("keys:", sorted(data.keys()))
        print("n_var:", data["n_var"])
        print("n_eq:", data["n_eq"])
        print("n_ineq:", data["n_ineq"])
        _print_sparse("P", data[s.P])
        _print_vector("q", data[s.Q])
        _print_sparse("A", data[s.A])
        _print_vector("b", data[s.B])
        _print_sparse("F", data[s.F])
        _print_vector("g", data[s.G])

        print("\n=== QPFPGA OSQP-style conversion ===")
        osqp_problem = as_osqp_problem(data)
        _print_sparse("osqp.P", osqp_problem.P)
        _print_vector("osqp.q", osqp_problem.q)
        _print_sparse("osqp.A", osqp_problem.A)
        _print_vector("osqp.l", osqp_problem.l)
        _print_vector("osqp.u", osqp_problem.u)

        print("\n=== Solver call ===")
        result = solver.solve_via_data(data, warm_start=False, verbose=True, solver_opts={})
    else:
        print("CVXPY is unavailable or incomplete on this board; using a direct QP fallback.")
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
        result = backend.solve(osqp_problem, QPSolverOptions())
    print("returned status:", result.status)
    print("returned x:", None if result.x is None else result.x.tolist())
    print("returned y:", None if result.y is None else result.y.tolist())
    print("returned objective:", result.obj_val)


if __name__ == "__main__":
    main()