# solvers.jl
"""
Module containing the solver implementations for the Helmholtz equation.
Uses both direct (UMFPACK) and iterative (GMRES) methods.
"""

"""
    solve_helmholtz_direct(A::AbstractMatrix, b::AbstractVector) -> Vector{Float64}

Solve the Helmholtz system using the [`LinearSolve.jl`](https://github.com/SciML/LinearSolve.jl) interface to the UMFPACK direct solver.
"""
function solve_helmholtz_direct(A::AbstractMatrix, b::AbstractVector)
    prob = LinearProblem(A, b)
    sol = solve(prob, UMFPACKFactorization())
    return sol.u
end

"""
    solve_helmholtz_iterative(A::AbstractMatrix, b::AbstractVector; 
                            tol::Real=1e-6, maxiter::Int=100) -> Vector{Float64}

Solve the Helmholtz system using the [`LinearSolve.jl`](https://github.com/SciML/LinearSolve.jl) interface to the GMRES iterative solver
provided by [`Krylov.jl`](https://github.com/JuliaSmoothOptimizers/Krylov.jl).
"""
function solve_helmholtz_iterative(
        A::AbstractMatrix, b::AbstractVector;
        tol::Real = 1.0e-6, maxiter::Int = 100
    )
    prob = LinearProblem(A, b)
    sol = solve(prob, KrylovJL_GMRES(); abstol = tol, maxiters = maxiter)
    return sol.u
end
