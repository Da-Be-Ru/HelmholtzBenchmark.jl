# discretization.jl
"""
    discretize_helmholtz(n::Int, k::Real) -> (A::SparseMatrixCSC{Float64,Int}, b::Vector{Float64})

Discretize the Helmholtz equation (-∇²-k²)u = f on [0,1] using second-order finite differences.
Uses n interior points (resulting in an n×n matrix).
f is set to a delta function at x = 1/2.
Returns the system matrix A and the right-hand side vector b.
"""
function discretize_helmholtz(n::Int, k::Real)
    h = 1 / (n + 1)  # grid spacing

    # Create sparse matrix for discretization
    # For -∇²u - k²u = f:
    # Main diagonal: 2/h² - k²
    # Off diagonals: -1/h²
    main_diag = fill(2 / h^2 - k^2, n)
    off_diag = fill(-1 / h^2, n - 1)

    A = spdiagm(
        -1 => off_diag,  # lower diagonal
        0 => main_diag, # main diagonal
        1 => off_diag   # upper diagonal
    )

    # Right hand side: delta function at x = 1/2
    b = zeros(n)
    mid_point = round(Int, n / 2)
    b[mid_point] = 1 / h  # normalized delta function

    return A, b
end
