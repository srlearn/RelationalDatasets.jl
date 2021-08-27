# Copyright © 2021 Alexander L. Hayes

# Run from the base of the repository:
#   julia --project=. docs/make.jl
#
# This is partially to make sure the project README.md is copied and turned
# into the "Home" page.

push!(LOAD_PATH,"../src/")

cp("README.md", "docs/src/index.md", force=true)

using Documenter, RelationalDatasets

makedocs(
    sitename="RelationalDatasets.jl",
    pages = [
        "Home" => "index.md",
        "API Docs" => "api.md",
        "Types" => "types.md",
    ]
)

deploydocs(
    repo = "github.com/srlearn/RelationalDatasets.jl.git",
)
