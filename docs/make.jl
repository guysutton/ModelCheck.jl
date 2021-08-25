using ModelCheck
using Documenter

DocMeta.setdocmeta!(ModelCheck, :DocTestSetup, :(using ModelCheck); recursive=true)

makedocs(;
    modules=[ModelCheck],
    authors="Guy F. Sutton",
    repo="https://github.com/guysutton/ModelCheck.jl/blob/{commit}{path}#{line}",
    sitename="ModelCheck.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://guysutton.github.io/ModelCheck.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/guysutton/ModelCheck.jl",
)
