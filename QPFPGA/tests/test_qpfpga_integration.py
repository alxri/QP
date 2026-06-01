from __future__ import annotations

import unittest
import sys
import sysconfig


_SITE_PACKAGES = sysconfig.get_paths()["purelib"]
if _SITE_PACKAGES in sys.path:
    sys.path.remove(_SITE_PACKAGES)
sys.path.insert(0, _SITE_PACKAGES)

import cvxpy as cp
import numpy as np

from qpfpga.backend import MockBackend
from qpfpga.solver import QPFPGA


class TestQPFPGAIntegration(unittest.TestCase):
    def _build_problem(self):
        x = cp.Variable(2)
        P = np.array([[4.0, 0.0], [0.0, 2.0]], dtype=float)
        q = np.array([-1.0, -1.0], dtype=float)
        problem = cp.Problem(
            cp.Minimize(0.5 * cp.quad_form(x, P) + q @ x),
            [x >= 0, x <= 1],
        )
        return problem, x

    def test_default_solver_backend_succeeds(self):
        problem, x = self._build_problem()

        value = problem.solve(solver=QPFPGA(), verbose=False)

        self.assertEqual(problem.status, cp.OPTIMAL)
        np.testing.assert_allclose(x.value, np.array([0.25, 0.5]), atol=1e-6)
        self.assertAlmostEqual(value, -0.375, places=6)

    def test_explicit_mock_backend_succeeds(self):
        problem, x = self._build_problem()

        value = problem.solve(solver=QPFPGA(backend=MockBackend()), verbose=False)

        self.assertEqual(problem.status, cp.OPTIMAL)
        np.testing.assert_allclose(x.value, np.array([0.25, 0.5]), atol=1e-6)
        self.assertAlmostEqual(value, -0.375, places=6)


if __name__ == "__main__":
    unittest.main()