"""
    run_comparison(k::Real, dim::Int = 1, n::Int = 100)
Compare direct (UMFPACK) and iterative (GMRES) solvers for the Helmholtz equation for a single wave number `k`.
"""
function run_comparison(k::Real, dim::Int = 1, n::Int = 100)
    result = Dict()

    # Discretize the problem
    A, b = discretize_helmholtz(n, k)

    # Time direct solver
    direct_time = @elapsed begin
        u_direct = solve_helmholtz_direct(A, b)
    end

    # Time iterative solver
    iterative_time = @elapsed begin
        u_iterative = solve_helmholtz_iterative(A, b)
    end

    # Store results
    result = Dict(
        "direct_time" => direct_time,
        "iterative_time" => iterative_time,
        "solution_diff" => norm(u_direct - u_iterative)
    )

    return result
end

"""
    run_benchmark(k_values::Vector{<:Real}, dim::Int = 1, n::Int = 100)
Compare direct (UMFPACK) and iterative (GMRES) solvers for the Helmholtz equation for a number of wave numbers `k_values`.
"""
function run_benchmark(k_values::Vector{<:Real}, dim::Int = 1, n::Int = 100)
    results = Dict()
    for k in k_values
        result = run_comparison(k, dim, n)
        results[k] = result
    end

    return results
end

"""
    verify_solution()

Verify the implementation by comparing with the exact solution
for ``k=0`` and ``f=1``, where ``u(x) = (1/2)x(1-x)``.
"""
function verify_solution()
    n = 100
    h = 1 / (n + 1)

    # Set up the problem with k=0 and f=1
    A, _ = discretize_helmholtz(n, 0.0)
    b = ones(n)

    # Solve
    u_numerical = solve_helmholtz_direct(A, b)

    # Compute exact solution
    x = [(i * h) for i in 1:n]
    u_exact = @. 0.5 * x * (1 - x)

    return x, u_numerical, u_exact
end
