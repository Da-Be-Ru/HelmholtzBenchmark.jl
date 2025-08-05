module RunBenchmark
using HelmholtzBenchmark
using Plots
using LinearAlgebra

using DrWatson
@quickactivate "HelmholtzBenchmark"

using DataFrames

function benchmark(d::Dict)
    @unpack k, dim, n = d
    benchmark_results = run_comparison(k, dim, n)
    results = merge(d, benchmark_results)
    return results
end

function main()
    # run benchmark
    parameters = Dict(
        "k" => [0.0, 10.0, 100.0, 500.0, 1000.0],
        "dim" => [1],
        "n" => [100]
    )

    parameter_dicts = dict_list(parameters)

    for pd in parameter_dicts
        @info "running with $(pd)"
        results = benchmark(pd)
        wsave(datadir("benchmarks", savename(pd, "jld2")), results)
    end

    # plot timing results
    df_results = collect_results(datadir("benchmarks"))
    sort!(df_results, ["k"])
    @info df_results

    direct_times = df_results[!, "direct_time"]
    iterative_times = df_results[!, "iterative_time"]
    k_values = df_results[!, "k"]

    p = plot(
        k_values, [direct_times iterative_times],
        label = ["UMFPACK" "GMRES"],
        xlabel = "k",
        ylabel = "Time (s)",
        title = "Solver Performance Comparison",
        marker = :circle,
        yscale = :log10,
        legend = :topleft
    )

    # Save plot
    benchmark_plotdir = plotsdir("benchmarks")
    mkpath(benchmark_plotdir)
    savefig(p, joinpath(benchmark_plotdir, "benchmark_results.png"))

    # run verification and plot graph
    x, u_numerical, u_exact = verify_solution()

    # Plot comparison
    p2 = plot(
        x, [u_numerical u_exact],
        label = ["Numerical" "Exact"],
        xlabel = "x",
        ylabel = "u(x)",
        title = "Solution Comparison (k=0, f=1)",
        marker = [:circle :none],
        linestyle = [:solid :dash],
        legend = :bottomright
    )

    # Save comparison plot
    verification_plotdir = plotsdir("verification")
    mkpath(verification_plotdir)
    savefig(p2, joinpath(verification_plotdir, "verification_comparison.png"))

    error = norm(u_numerical - u_exact, Inf)
    println("\nVerification error (k=0, f=1): ", error)

    return nothing
end
end # module RunBenchmark
