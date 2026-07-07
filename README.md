# Heat_Equation
Finite difference method solver for heat equation in GNU Octave


# Heat Equation Solver

> A computational process journal documenting my exploration of the Heat Equation, numerical methods, and the foundations of Computational Fluid Dynamics (CFD).

---

## Overview

This repository documents my journey of learning how partial differential equations (PDEs) are solved numerically.

Rather than simply implementing a solver, the goal is to understand the mathematical reasoning, computational techniques, and engineering decisions behind numerical simulation.

The project begins with the two-dimensional Heat Equation solved using the explicit Finite Difference Method (FDM) in GNU Octave and will gradually evolve toward more advanced numerical methods and computational physics.

---

## Project Goals

* Learn the mathematics behind the Heat Equation.
* Understand how PDEs are solved numerically.
* Explore Finite Difference Methods (FDM).
* Investigate numerical stability and convergence.
* Study different boundary conditions.
* Compare numerical methods.
* Build intuition for numerical solvers.

# Development Log

# Version 0 — Basic FTCS Heat Equation Solver

## Features

- Implemented a 2D heat equation solver using the FTCS (Forward Time, Central Space) method.
- 50 × 50 computational grid.
- Animated heat diffusion over time.
- Adjustable thermal diffusivity (`alpha`) and number of iterations.

---

## Notes

- Tested with both single and multiple heat sources.
- Heat diffused smoothly across the plate as expected.
- Total heat decreased over time because the plate used fixed-temperature (Dirichlet) boundaries.

---

# Version 1 — Improved FTCS Solver

## Features

- Added configurable simulation parameters (`dx`, `dy`, `dt`, `alpha`, and grid size).
- Implemented a numerical stability check before the simulation begins.
- Replaced the single heated cell with a central heated region for more realistic diffusion.
- Improved visualization using a fixed colour scale and clearer animation.
- Cleaned up and reorganized the code for improved readability and maintainability.

---

## Notes

- The stability check prevents unstable simulations caused by an excessively large time step.
- Fixed colour scaling makes temperature changes easier to compare throughout the simulation.
- This version establishes a cleaner foundation for future additions such as boundary conditions, multiple materials, and more advanced numerical methods.



