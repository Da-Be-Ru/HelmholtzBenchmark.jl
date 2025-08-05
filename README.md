[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Da-Be-Ru.github.io/HelmholtzBenchmark.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Da-Be-Ru.github.io/HelmholtzBenchmark.jl/dev/)
[![Build Status](https://github.com/Da-Be-Ru/HelmholtzBenchmark.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Da-Be-Ru/HelmholtzBenchmark.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/Da-Be-Ru/HelmholtzBenchmark.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Da-Be-Ru/HelmholtzBenchmark.jl)

# HelmholtzBenchmark.jl

A Julia package for benchmarking solvers for the Helmholtz equation in 1D usind a simple finite difference discretization.

## Problem Description

Solves the Helmholtz equation:

$(-\nabla^2 - k^2)u(x) = f(x)$

on the domain $\Omega = [0,1]$ with homogeneous Dirichlet boundary conditions $u(0)=u(1)=0$ by means of a second order 
accurate finite differences scheme.
The source term is a delta function at $x=1/2$, i.e. $f(x) = \delta(x-1/2)$.

## Features

- Second-order finite difference discretization
- Direct solver using UMFPACK
- Iterative solver using GMRES
- Benchmarking functionality to compare solver performance
- Verification against exact solution for special case

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/Da-Be-Ru/HelmholtzBenchmark.jl")
```

## Quick Start

You can run a quick benchmark manually:

```julia
using HelmholtzBenchmark

# Run benchmark for different k values
k_values = [0.0, 10.0, 100.0, 1000.0]
results = run_benchmark(k_values)

# Verify implementation against exact solution
error = verify_solution()
println("Maximum error: ", error)
```

or automatically generate the assorted data and plots from the
[`DrWatson.jl`](https://github.com/JuliaDynamics/DrWatson.jl)-compatible benchmark script:

```julia
include("./scripts/run_benchmark.jl")
```