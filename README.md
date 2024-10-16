# Numerical Analysis 

This repository contains various numerical methods and algorithms implemented in a variety of programming languages, including Julia, MATLAB, Python, and Fortran. The code is organized into different sections according to topics like interpolation, optimization, root-finding algorithms, linear algebra, and more.

## Table of Contents
- [Interpolation and Extrapolation](#interpolation-and-extrapolation)
- [Linear Algebra](#linear-algebra)
- [Monte Carlo Simulations](#monte-carlo-simulations)
- [Navier-Stokes Equations](#navier-stokes-equations)
- [Numerical Differentiation and Integration](#numerical-differentiation-and-integration)
- [Optimization](#optimization)
- [Ordinary Differential Equations (ODEs)](#ordinary-differential-equations-odes)
- [Partial Differential Equations (PDEs)](#partial-differential-equations-pdes)
- [Root-Finding Algorithms](#root-finding-algorithms)
- [License](#license)

## Interpolation and Extrapolation
Interpolation and extrapolation are techniques to estimate unknown values between or beyond a set of known data points. The following methods are implemented:

- **Cubic Spline Interpolation** (`CubicSplineInterpolation.jl`)
- **Hermite Interpolation** (`Hermitelnterpolation.jl`)
- **Lagrange Interpolation** (`Lagrangelnterpolation.f90`)
- **Linear Spline Interpolation** (`LinearSplineInterpolation.jl`)
- **Newton’s Backward Interpolation** (`NewtonsBackwardInterpolation.m`)
- **Newton’s Divided Differences** (`NewtonsDividedDifferencesInterpolation.jl`)
- **Newton’s Forward Interpolation** (`NewtonsForwardInterpolation.m`)
- **Quadratic Spline Interpolation** (`QuadraticSplineInterpolation.jl`)
- **General Spline Interpolation in Python** (`SplineInterpolation.py`)

Use Cases: These methods are commonly used in numerical computing for curve fitting and data smoothing.

## Linear Algebra
Linear algebra algorithms are fundamental for solving systems of equations and matrix operations.

- **Gauss Jordan Method** (`GaussJordan.m`)
- **Gauss-Seidel Method** (`GaussSeidel.m`)
- **Jacobi Method** (`Jacobi.m`)
- **LU Decomposition (Cholesky's Method)** (`LUCholeskysMethod.m`)
- **LU Decomposition (Crout's Method)** (`LUCroutsMethod.m`)
- **LU Decomposition (Doolittle's Method)** (`LUDoolittleMethod.m`)
- **Power Method** (`PowerMethod.m`)

Use Cases: These methods are often used in solving linear systems, matrix decomposition, and eigenvalue problems.

## Monte Carlo Simulations
Monte Carlo methods are used to perform numerical integration and simulate random processes.

- **1D Monte Carlo Simulation** (`MonteCarlo1d.py`)
- **2D Monte Carlo Simulation** (`MonteCarlo2d.py`)
- **Monte Carlo Markov Chains** (`MonteCarloMarkovChains.ipynb`)

Use Cases: Widely used in numerical integration, stochastic modeling, and simulations in physics and finance.

## Navier-Stokes Equations
This section contains implementations for solving the Navier-Stokes equations, primarily in fluid dynamics.

- **CFD: Lid Driven Cavity Problem** (`CFD_Lid_Driven_Cavity.py`)

Use Cases: These equations describe the motion of viscous fluid substances and are used in computational fluid dynamics (CFD).

## Numerical Differentiation and Integration
Numerical methods for differentiation and integration are useful for approximating the results of derivatives and integrals.

- **Gaussian Quadrature** (`GaussianQuadrature.f90`, `GaussianQuadrature.m`)
- **Monte Carlo Integration (1D)** (`MonteCarlolntegration1d.f90`)
- **Monte Carlo Integration (2D)** (`MonteCarlolntegration2d.f90`)
- **Simpson's Rule** (`SimpsonsRule.f90`)
- **Trapezoidal Rule** (`TrapezoidalRule.f90`)

Use Cases: These methods are crucial for numerical integration when exact methods are impractical.

## Optimization
Optimization techniques help in finding maxima, minima, or optimal solutions.

- **Linear Programming (Big-M Method)** (`BigM.m`)
- **Dual Simplex Method** (`DualSimplex.m`)
- **Graphical Method** (`GraphicalMethod.m`)
- **Simplex Method** (`Simplex.m`)
- **Gradient Descent for Linear Problems** (`GradDescentLin.ipynb`)

Use Cases: These methods are widely used in operational research, machine learning, and economics to solve optimization problems.

## Ordinary Differential Equations (ODEs)
Methods for numerically solving ordinary differential equations.

- **Euler's Method (Fortran)** (`EulersMethod.f90`)
- **Euler's Method (Python)** (`EulersMethod.py`)
- **Runge-Kutta 2nd Order Method** (`RungeKutta2ndOrder.f90`)
- **Runge-Kutta 4th Order Method** (`RungeKutta4thOrder.f90`)

Use Cases: These methods are widely used in physics, engineering, and biological modeling to solve time-dependent processes.

## Partial Differential Equations (PDEs)
PDEs describe functions with multiple variables and their partial derivatives.

- **Crank-Nicholson Method** (`CrankNicholsonMethod.m`)
- **DuFort-Frankel Method** (`DuFortFrankelMethod.m`)
- **Backward Time Central Space (BTCS) for Heat Equation** (`PDE-BTCS-HeatEquation.m`)
- **Forward Time Central Space (FTCS) for Heat Equation** (`PDE-FTCS-HeatEquation.m`)
- **Richardson Method** (`RichardsonMethod.m`)

Use Cases: PDEs are used in modeling heat transfer, fluid dynamics, and electromagnetism.

## Root-Finding Algorithms
Algorithms for finding roots of nonlinear equations.

- **Bisection Method** (`Bisection.f90`)
- **Fixed Point Iteration** (`FixedPointlteration.m`)
- **Newton-Raphson Method** (`NewtonRaphson.f90`)
- **Regula Falsi Method** (`Regula-Falsi.m`)
- **Secant Method** (`SecantMethod.f90`)

Use Cases: Used in numerical analysis to solve equations in engineering and science problems.

## License
This project is licensed under the Apache 2.0 License. See the [LICENSE](./LICENSE) file for details.

