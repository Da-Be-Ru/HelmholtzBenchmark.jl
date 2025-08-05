using Documenter
using HelmholtzBenchmark

DocMeta.setdocmeta!(HelmholtzBenchmark, :DocTestSetup, :(using HelmholtzBenchmark); recursive = true)

makedocs(;
    modules = [HelmholtzBenchmark],
    authors = "Daniel Runge <runge@wias-berlin.de>, Zeina Amer <amer@wias-berlin.de>, Marieke Osewold <osewold@wias-berlin.de>",
    sitename = "HelmholtzBenchmark.jl",
    clean = false,
    format = Documenter.HTML(;
        canonical = "https://Da-Be-Ru.github.io/HelmholtzBenchmark.jl",
        edit_link = "master",
        assets = String[],
    ),
    pages = [
        "Home" => "index.md",
        "API Reference" => "api.md",
    ],
)

# deploydocs(;
#     repo="github.com/Da-Be-Ru/HelmholtzBenchmark.jl",
#     devbranch="master",
# )

# makedocs(
#     sitename = "HelmholtzBenchmark",
#     format = Documenter.HTML(),
#     modules = [HelmholtzBenchmark],
#     pages = [
#         "Home" => "index.md",
#         "API Reference" => "api.md"
#     ]
# )
