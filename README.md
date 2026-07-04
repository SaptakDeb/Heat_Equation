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

## Version 0 — Explicit Finite Difference Method (FDM)

### Features

* Implemented a 2D explicit Finite Difference Method (FDM) solver for the heat equation.
* Structured 50 × 50 computational grid.
* Animated temperature evolution.
* Adjustable diffusion coefficient (`alpha`) and number of iterations.

---

## Observations

### Trial 1 — Single Heat Source

**Initial Condition**
* 100 units of heat at the centre of the plate `(25,25)`.
* All other cells initialized to 0.

**Observation**
* Heat diffused symmetrically from the centre toward the boundaries.
* After 200 iterations, the total heat on the plate was **97.507**.

**Validity**
* The decrease in total heat is expected because the boundary cells remain fixed at 0, allowing heat to leave the computational domain. This is consistent with fixed-temperature (Dirichlet) boundary conditions rather than an insulated plate.

---

### Trial 2 — Two Heat Sources

**Initial Condition**
* 200 units of heat at `(12,12)`.
* 200 units of heat at `(37,37)`.

**Observation**
* Two independent diffusion fronts formed and gradually interacted as they expanded.
* After 200 iterations, the total heat remaining on the plate was **267.45**.

**Validity**
* Heat loss is again expected due to the fixed-temperature boundaries. The locations of the heat sources also influence how quickly heat reaches the boundaries and therefore how much energy remains within the computational domain after a fixed number of iterations.

---

## Future Plans
* Implement insulated (Neumann) boundary conditions and compare heat conservation.
* Investigate the effect of changing the diffusion coefficient (`alpha`) on stability and diffusion rate.
* Compare different grid resolutions.
* Introduce internal obstacles and study heat flow around them.
* Derive the finite difference update equation directly from the continuous heat equation.
* Progress toward irregular point distributions and eventually explore meshless methods such as RBF-FD.

---

## Tools
* GNU Octave
* Finite Difference Method (FDM)

---


