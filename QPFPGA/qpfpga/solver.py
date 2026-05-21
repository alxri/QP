from __future__ import annotations

from typing import Any

import numpy as np

try:
    import cvxpy.interface as intf
    import cvxpy.settings as s
    import cvxpy.reductions.solution as solution_mod
    from cvxpy.reductions.solvers import utilities
    from cvxpy.reductions.solvers.qp_solvers.qp_solver import QpSolver
except Exception:  # pragma: no cover - import-time fallback for scaffold use.
    intf = None
    s = None
    solution_mod = None
    utilities = None

    class QpSolver:  # type: ignore[no-redef]
        pass

from .backend import QPFPGABackend, as_osqp_problem, default_backend
from .data import QPSolverOptions, QPSolverResult

Solution = getattr(solution_mod, "Solution", None)
failure_solution = getattr(solution_mod, "failure_solution", None)


class QPFPGA(QpSolver):
    """CVXPY QP solver adapter for the FPGA backend."""

    STATUS_MAP = {} if s is None else {
        "optimal": s.OPTIMAL,
        "optimal_inaccurate": s.OPTIMAL_INACCURATE,
        "user_limit": s.USER_LIMIT,
        "infeasible": s.INFEASIBLE,
        "infeasible_inaccurate": s.INFEASIBLE_INACCURATE,
        "unbounded": s.UNBOUNDED,
        "unbounded_inaccurate": s.UNBOUNDED_INACCURATE,
        "solver_error": s.SOLVER_ERROR,
        "not_implemented": s.SOLVER_ERROR,
    }

    def __init__(self, backend: QPFPGABackend | None = None) -> None:
        self.backend = backend or default_backend()

    def name(self) -> str:
        return "QPFPGA"

    def import_solver(self) -> None:
        return None

    def cite(self, data):
        return ""

    def _solver_options(self, solver_opts: dict[str, Any] | None) -> QPSolverOptions:
        solver_opts = solver_opts or {}
        return QPSolverOptions(
            sigma=float(solver_opts.get("sigma", 1e-2)),
            alpha=float(solver_opts.get("alpha", 1.8)),
            eps_abs=float(solver_opts.get("eps_abs", 1e-3)),
            eps_rel=float(solver_opts.get("eps_rel", 1e-3)),
            pcg_tol_fraction=float(solver_opts.get("pcg_tol_fraction", 1.0)),
            admm_max_iter=int(solver_opts.get("admm_max_iter", 2000)),
            pcg_max_iter=int(solver_opts.get("pcg_max_iter", 5)),
            adaptive_rho=bool(solver_opts.get("adaptive_rho", False)),
            extra={k: v for k, v in solver_opts.items() if k not in {
                "sigma", "alpha", "eps_abs", "eps_rel", "pcg_tol_fraction",
                "admm_max_iter", "pcg_max_iter", "adaptive_rho"
            }},
        )

    def solve_via_data(self, data, warm_start: bool, verbose: bool, solver_opts, solver_cache=None):
        if s is None:
            raise ImportError("CVXPY is required to use QPFPGA as a solver backend.")
        if verbose:
            print("=== QPFPGA received CVXPY data ===")
            print("keys:", sorted(data.keys()))
            print(f"P: shape={data[s.P].shape}, nnz={data[s.P].nnz}")
            print(f"q: shape={np.asarray(data[s.Q]).shape}")
            print(f"A: shape={data[s.A].shape}, nnz={data[s.A].nnz}")
            print(f"b: shape={np.asarray(data[s.B]).shape}")
            print(f"F: shape={data[s.F].shape}, nnz={data[s.F].nnz}")
            print(f"g: shape={np.asarray(data[s.G]).shape}")
        qp_data = as_osqp_problem(data)
        options = self._solver_options(solver_opts)
        results = self.backend.solve(qp_data, options)
        data["_qpfpga_result"] = results
        return results

    def invert(self, solution: QPSolverResult, inverse_data):
        if s is None:
            raise ImportError("CVXPY is required to use QPFPGA as a solver backend.")
        if Solution is None or failure_solution is None:
            raise ImportError(
                "This CVXPY version does not expose the expected solution helpers; "
                "use the QPFPGA backend directly or upgrade/downgrade CVXPY."
            )
        attr = {
            s.SOLVE_TIME: solution.solve_time_s,
            s.NUM_ITERS: solution.num_iters,
            s.EXTRA_STATS: solution,
        }
        status = self.STATUS_MAP.get(solution.status, s.SOLVER_ERROR)
        if status in s.SOLUTION_PRESENT and solution.x is not None:
            primal_vars = {
                self.VAR_ID: intf.DEFAULT_INTF.const_to_matrix(np.asarray(solution.x))
            }
            dual_vars = {}
            if solution.y is not None:
                n_eq = inverse_data[self.DIMS].zero
                dual_vars = utilities.get_dual_values(
                    np.asarray(solution.y[:n_eq]),
                    utilities.extract_dual_value,
                    inverse_data[self.EQ_CONSTR],
                ) | utilities.get_dual_values(
                    np.asarray(solution.y[n_eq:]),
                    utilities.extract_dual_value,
                    inverse_data[self.NEQ_CONSTR],
                )
            opt_val = solution.obj_val
            return Solution(status, opt_val, primal_vars, dual_vars, attr)

        return failure_solution(status, attr)