# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

# TODO(hayesall): ExportPublic.jl

"""Request copies of relational datasets.
"""

using HTTP

include("types.jl")


DATASETS = [
    "toy_cancer",
    "toy_father",
    "citeseer",
    "cora",
    "uwcse",
    "webkb",
    "financial_nlp_small",
    "nell_sports",
    "icml",
    "boston_housing",
]
LATEST_VERSION = "v0.0.4"


"""
    load(name::String, version::Union{String, Nothing} = nothing; fold::Int64 = 1)

Load the training and test folds for a dataset.
"""
function load(name::String, version::Union{String, Nothing} = nothing; fold::Int64 = 1)

    if version == nothing
        version = LATEST_VERSION
    end

    filename = name * "_" * version * ".zip"

    println(filename, "   ", fold)

end


"""
    fetch(name::String, version::Union{String, Nothing} = nothing)
"""
function fetch(name::String, version::Union{String, Nothing} = nothing)
    println(name, version)
end


function _make_data_url(name::String, version::Union{String, Nothing} = nothing)::String
    @assert name in DATASETS
    if version == nothing
        version = LATEST_VERSION
    end

    return "https://github.com/srlearn/datasets/releases/download/$(version)/$(name)_$(version).zip"
end

function _make_file_path(name::String, version::Union{String, Nothing} = nothing)::String
    @assert name in DATASETS
    if version == nothing
        version = LATEST_VERSION
    end
end



load("toy_cancer", "v0.0.4"; fold=1)
load("webkb")
load("webkb", "v0.0.3"; fold=2)
load("boston_housing", "v0.0.4")

println(_make_data_url("toy_cancer"))

"""
r = HTTP.request("GET", "http://httpbin.org/ip")
println(r.status)
println(String(r.body))
"""


# println(DATASETS)
# println(LATEST_VERSION)
