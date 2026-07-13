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

---

# Version 2 — Boundary Conditions

## Features

- Added support for fixed-temperature (Dirichlet) and insulated (Neumann) boundary conditions.
- Switch between boundary conditions with a single setting.
- Preserved the FTCS solver while extending its physical realism.
- Compared heat diffusion under different edge constraints.

---

## Notes

- Fixed-temperature boundaries allow heat to leave the plate, while insulated boundaries retain heat within the domain.
- This version introduces boundary conditions, a fundamental concept in numerical heat transfer and computational physics.

---

# Version 3 — Heat Sources and Simulation Diagnostics

## Features

- Added internal heat generation to simulate a continuous heat source within the plate.
- Introduced temperature probes to monitor the thermal history at selected locations.
- Recorded and plotted the total heat in the system throughout the simulation.
- Extended the solver with simulation diagnostics while preserving the explicit FTCS method.

---

## Notes

- The internal heat source continuously injects energy into a specified region, creating a localized heating effect.
- Temperature probes provide insight into how heat propagates to different parts of the domain over time.
- The total heat plot helps visualize the overall energy evolution of the system and demonstrates the effect of continuous heat generation.

---

# Version 4 — Variable Material Properties

## Features

- Added support for spatially varying thermal diffusivity to simulate composite materials.
- Introduced a circular low-diffusivity region embedded within the base material.
- Simulated heat propagation across a material interface using the existing FTCS solver.
- Positioned temperature probes on opposite sides of the interface to compare heat transfer through different materials.
- Included an internal heat source near the material boundary to observe the effect of changing thermal diffusivity.

---

## Notes

- Materials with lower thermal diffusivity conduct heat more slowly, delaying temperature propagation through those regions.
- The probe located within the low-diffusivity insert exhibits a slower temperature rise than the probe in the surrounding material, illustrating the influence of heterogeneous material properties.
- This version extends the solver from homogeneous to composite domains, introducing a key concept used in engineering heat transfer, materials science, and computational physics.

