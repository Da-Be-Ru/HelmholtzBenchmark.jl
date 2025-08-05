using Test
using HelmholtzBenchmark
using LinearAlgebra

≲(a, b; kwargs...) = (a < b) || (isapprox(a, b; kwargs...))

@testset "HelmholtzBenchmark.jl" begin
    @testset "Discretization" begin
        n = 10
        k = 1.0
        A, b = discretize_helmholtz(n, k)

        # Test matrix size
        @test size(A) == (n, n)
        @test length(b) == n

        # Test matrix is symmetric
        @test norm(A - A') ≲ 1.0e-16
    end

    @testset "Solvers" begin
        n = 10
        k = 1.0
        A, b = discretize_helmholtz(n, k)

        # Test both solvers give similar results
        u_direct = solve_helmholtz_direct(A, b)
        u_iterative = solve_helmholtz_iterative(A, b)

        @test norm(u_direct - u_iterative) ≲ 1.0e-14
    end

    @testset "Verification k=0" begin
        # Test against exact solution for k=0, f=1
        _, u_numerical, u_exact = verify_solution()
        error = norm(u_numerical - u_exact, Inf)
        @test error ≲ 1.0e-14 # Should be second order accurate
    end
end
