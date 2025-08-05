module HelmholtzBenchmark

using LinearAlgebra
using SparseArrays
using LinearSolve

include("discretization.jl")
include("solvers.jl")
include("benchmark.jl")

# Export main functionality
export discretize_helmholtz,
       solve_helmholtz_direct,
       solve_helmholtz_iterative,
       run_comparison,
       run_benchmark,
       verify_solution

# override DrWatson directory functions so they continue working in the testing environment
# see https://github.com/JuliaDynamics/DrWatson.jl/issues/434
datadir(args...) = joinpath(pkgdir(ChargeTransport), "data", args...)
examplesdir(args...) = joinpath(pkgdir(ChargeTransport), "examples", args...)


end # module HelmholtzBenchmark
