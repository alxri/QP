from __future__ import annotations

import ctypes
from dataclasses import asdict
import os
import shlex
import subprocess
import shutil
from pathlib import Path
from typing import Protocol

import numpy as np
import scipy.sparse as sp

from .data import QPData, QPSolverOptions, QPSolverResult


class QPFPGABackend(Protocol):
    def solve(self, problem: QPData, options: QPSolverOptions) -> QPSolverResult:
        raise NotImplementedError


class MockBackend:
    """Development backend used on PC when no FPGA runtime is available."""

    def solve(self, problem: QPData, options: QPSolverOptions) -> QPSolverResult:
        x = np.zeros(problem.q.shape[0], dtype=np.float32)
        y = np.zeros(problem.A.shape[0], dtype=np.float32)
        return QPSolverResult(
            status="not_implemented",
            x=x,
            y=y,
            obj_val=None,
            extra_stats={"backend": "mock", "options": asdict(options)},
        )


class CtypesBackend:
    """Loads a shared C++ backend and forwards OSQP-style data to it."""

    def __init__(self, library_path: str | Path, bitstream_path: str | Path | None = None) -> None:
        self.library_path = Path(library_path)
        self.bitstream_path = Path(bitstream_path) if bitstream_path is not None else None
        self._bitstream_loaded = False
        self._lib = ctypes.CDLL(str(self.library_path))
        self._configure_abi()

    def _configure_abi(self) -> None:
        self._lib.qpfpga_solve_osqp_style.argtypes = [
            ctypes.POINTER(QPFPGAProblemC),
            ctypes.POINTER(QPFPGAOptionsC),
            ctypes.POINTER(QPFPGAResultC),
        ]
        self._lib.qpfpga_solve_osqp_style.restype = ctypes.c_int32

    def _ensure_bitstream_loaded(self) -> None:
        if self.bitstream_path is None or self._bitstream_loaded:
            return
        if not self.bitstream_path.exists():
            raise FileNotFoundError(f"QPFPGA bitstream not found: {self.bitstream_path}")
        try:
            from pynq import Overlay  # type: ignore

            Overlay(str(self.bitstream_path))
        except Exception:
            firmware_name = self.bitstream_path.name
            firmware_candidates = [
                Path("/sys/class/fpga_manager/fpga0/firmware"),
                Path("/sys/class/fpga_manager/fpga1/firmware"),
            ]
            firmware_target = next((path for path in firmware_candidates if path.exists()), None)
            if firmware_target is None:
                raise RuntimeError(
                    "Unable to program the bitstream: PYNQ Overlay is unavailable and no "
                    "fpga_manager firmware node was found under /sys/class/fpga_manager/."
                )

            firmware_dir = Path("/lib/firmware")
            firmware_dir.mkdir(parents=True, exist_ok=True)
            staged_bitstream = firmware_dir / firmware_name
            if staged_bitstream.resolve() != self.bitstream_path.resolve():
                shutil.copy2(self.bitstream_path, staged_bitstream)

            firmware_target.write_text(firmware_name)
        self._bitstream_loaded = True

    def solve(self, problem: QPData, options: QPSolverOptions) -> QPSolverResult:
        self._ensure_bitstream_loaded()
        p_indptr = np.ascontiguousarray(problem.P.indptr, dtype=np.int32)
        p_indices = np.ascontiguousarray(problem.P.indices, dtype=np.int32)
        p_data = np.ascontiguousarray(problem.P.data, dtype=np.float32)
        a_indptr = np.ascontiguousarray(problem.A.indptr, dtype=np.int32)
        a_indices = np.ascontiguousarray(problem.A.indices, dtype=np.int32)
        a_data = np.ascontiguousarray(problem.A.data, dtype=np.float32)
        q = np.ascontiguousarray(problem.q, dtype=np.float32)
        l = np.ascontiguousarray(problem.l, dtype=np.float32)
        u = np.ascontiguousarray(problem.u, dtype=np.float32)

        p_matrix = QPFPGACscMatrixC(
            nrows=problem.P.shape[0],
            ncols=problem.P.shape[1],
            nnz=problem.P.nnz,
            indptr=p_indptr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            indices=p_indices.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            data=p_data.ctypes.data_as(ctypes.POINTER(ctypes.c_float)),
        )
        a_matrix = QPFPGACscMatrixC(
            nrows=problem.A.shape[0],
            ncols=problem.A.shape[1],
            nnz=problem.A.nnz,
            indptr=a_indptr.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            indices=a_indices.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            data=a_data.ctypes.data_as(ctypes.POINTER(ctypes.c_float)),
        )
        problem_c = QPFPGAProblemC(
            P=p_matrix,
            A=a_matrix,
            q=q.ctypes.data_as(ctypes.POINTER(ctypes.c_float)),
            l=l.ctypes.data_as(ctypes.POINTER(ctypes.c_float)),
            u=u.ctypes.data_as(ctypes.POINTER(ctypes.c_float)),
            n=problem.q.shape[0],
            m=problem.A.shape[0],
        )

        options_c = QPFPGAOptionsC(
            sigma=ctypes.c_float(options.sigma),
            alpha=ctypes.c_float(options.alpha),
            eps_abs=ctypes.c_float(options.eps_abs),
            eps_rel=ctypes.c_float(options.eps_rel),
            pcg_tol_fraction=ctypes.c_float(options.pcg_tol_fraction),
            admm_max_iter=ctypes.c_int32(options.admm_max_iter),
            pcg_max_iter=ctypes.c_int32(options.pcg_max_iter),
            adaptive_rho=ctypes.c_int32(int(options.adaptive_rho)),
        )
        x_out = np.zeros(problem.q.shape[0], dtype=np.float32)
        y_out = np.zeros(problem.A.shape[0], dtype=np.float32)
        result_c = QPFPGAResultC()

        status = self._lib.qpfpga_solve_osqp_style(
            ctypes.byref(problem_c),
            ctypes.byref(options_c),
            ctypes.byref(result_c),
        )

        if result_c.x:
            x_out = np.ctypeslib.as_array(result_c.x, shape=(problem.q.shape[0],)).astype(np.float32, copy=True)
        if result_c.y:
            y_out = np.ctypeslib.as_array(result_c.y, shape=(problem.A.shape[0],)).astype(np.float32, copy=True)

        return QPSolverResult(
            status=_status_name_from_code(status),
            x=x_out if result_c.x else None,
            y=y_out if result_c.y else None,
            obj_val=float(result_c.objective_value) if result_c.status != 0 else None,
            primal_residual=float(result_c.primal_residual),
            dual_residual=float(result_c.dual_residual),
            num_iters=int(result_c.admm_iters),
            solve_time_s=float(result_c.solve_time_ms) / 1000.0,
            extra_stats={
                "library_path": str(self.library_path),
                "return_code": int(status),
                "options": asdict(options),
            },
        )


def default_backend(library_path: str | Path | None = None) -> QPFPGABackend:
    force_cpu = os.environ.get("QPFPGA_FORCE_CPU", "")
    if force_cpu and force_cpu not in {"0", "false", "False"}:
        return MockBackend()
    if library_path is None:
        library_path = os.environ.get("QPFPGA_LIBRARY")
    bitstream_path = os.environ.get("QPFPGA_BITSTREAM")
    if library_path is None:
        return MockBackend()
    return CtypesBackend(library_path, bitstream_path=bitstream_path)


def as_osqp_problem(data: dict) -> QPData:
    try:
        import cvxpy.settings as s
    except ModuleNotFoundError as exc:
        raise ImportError("CVXPY settings are required to map solver data keys.") from exc

    P = sp.csc_matrix((data[s.P].data, data[s.P].indices, data[s.P].indptr), shape=data[s.P].shape)
    Aeq = sp.csc_matrix(data[s.A])
    Aineq = sp.csc_matrix(data[s.F])
    A = sp.vstack([Aeq, Aineq]).tocsc()
    q = np.asarray(data[s.Q], dtype=np.float32)
    b = np.asarray(data[s.B], dtype=np.float32)
    g = np.asarray(data[s.G], dtype=np.float32)
    l = np.concatenate([b, -np.inf * np.ones_like(g)])
    u = np.concatenate([b, g])
    return QPData(P=P, q=q, A=A, l=l, u=u)


class QPFPGACscMatrixC(ctypes.Structure):
    _fields_ = [
        ("nrows", ctypes.c_int32),
        ("ncols", ctypes.c_int32),
        ("nnz", ctypes.c_int32),
        ("indptr", ctypes.POINTER(ctypes.c_int32)),
        ("indices", ctypes.POINTER(ctypes.c_int32)),
        ("data", ctypes.POINTER(ctypes.c_float)),
    ]


class QPFPGAOptionsC(ctypes.Structure):
    _fields_ = [
        ("sigma", ctypes.c_float),
        ("alpha", ctypes.c_float),
        ("eps_abs", ctypes.c_float),
        ("eps_rel", ctypes.c_float),
        ("pcg_tol_fraction", ctypes.c_float),
        ("admm_max_iter", ctypes.c_int32),
        ("pcg_max_iter", ctypes.c_int32),
        ("adaptive_rho", ctypes.c_int32),
    ]


class QPFPGAProblemC(ctypes.Structure):
    _fields_ = [
        ("P", QPFPGACscMatrixC),
        ("A", QPFPGACscMatrixC),
        ("q", ctypes.POINTER(ctypes.c_float)),
        ("l", ctypes.POINTER(ctypes.c_float)),
        ("u", ctypes.POINTER(ctypes.c_float)),
        ("n", ctypes.c_int32),
        ("m", ctypes.c_int32),
    ]


class QPFPGAResultC(ctypes.Structure):
    _fields_ = [
        ("status", ctypes.c_int32),
        ("admm_iters", ctypes.c_int32),
        ("pcg_iters", ctypes.c_int32),
        ("primal_residual", ctypes.c_float),
        ("dual_residual", ctypes.c_float),
        ("objective_value", ctypes.c_float),
        ("solve_time_ms", ctypes.c_double),
        ("x", ctypes.POINTER(ctypes.c_float)),
        ("y", ctypes.POINTER(ctypes.c_float)),
    ]


def _status_name_from_code(status_code: int) -> str:
    status_map = {
        1: "optimal",
        2: "optimal_inaccurate",
        3: "infeasible",
        4: "infeasible_inaccurate",
        5: "unbounded",
        6: "unbounded_inaccurate",
        7: "user_limit",
        10: "solver_error",
        -1: "not_implemented",
    }
    return status_map.get(int(status_code), "solver_error")