# HelmholtzBenchmark.jl

A Julia package for benchmarking solvers for the Helmholtz equation in 1D.

## Problem Description

Solves the Helmholtz equation:

$(-\nabla^2 - k^2)u(x) = f(x)$

on the domain $\Omega = [0,1]$ with homogeneous Dirichlet boundary conditions $u(0)=u(1)=0$.
The source term is a delta function at $x=1/2$.

## Features

- Second-order finite difference discretization
- Direct solver using UMFPACK
- Iterative solver using GMRES
- Benchmarking functionality to compare solver performance
- Verification against exact solution for special case

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/yourusername/HelmholtzBenchmark.jl")
```

## Quick Start

```julia
using HelmholtzBenchmark

# Run benchmark for different k values
k_values = [0.0, 10.0, 100.0, 1000.0]
results = run_benchmark(k_values)

# Verify implementation against exact solution
error = verify_solution()
println("Maximum error: ", error)
```

## Documentation

For more detailed information, please refer to the documentation.
