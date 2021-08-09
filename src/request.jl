# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

# TODO(hayesall): Cross-platform paths?
# TODO(hayesall): ZipFile's build is a little weird, make sure it works in CI
#   using Pkg
#   Pkg.instantiate()

"""Request copies of relational datasets.
"""

using HTTP
using ZipFile

include("base.jl")
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
    data_location = fetch(name, version)
    return data_location
end


"""
    fetch(name::String, version::Union{String, Nothing} = nothing)
"""
function fetch(name::String, version::Union{String, Nothing} = nothing)::String

    data_file = _make_file_path(name, version)
    if Base.Filesystem.isfile(data_file)
        return data_file
    end

    download_url = _make_data_url(name, version)
    request = HTTP.request("GET", download_url)

    io = open(data_file, "w")
    write(io, request.body)
    close(io)

    return data_file
end


function _make_data_url(name::String, version::Union{String, Nothing} = nothing)::String
    @assert name in DATASETS
    if version == nothing
        version = LATEST_VERSION
    end

    # TODO(hayesall): Enforce no v0.0.2 or v0.0.3
    return "https://github.com/srlearn/datasets/releases/download/$(version)/$(name)_$(version).zip"
end

function _make_file_path(name::String, version::Union{String, Nothing} = nothing)::String
    @assert name in DATASETS
    if version == nothing
        return Base.Filesystem.joinpath(
            get_data_home(),
            "$(name)_$(LATEST_VERSION).zip",
        )
    end
    return Base.Filesystem.joinpath(
        get_data_home(),
        "$(name)_$(version).zip",
    )
end

#=
load("toy_cancer", "v0.0.4"; fold=1)
load("webkb")
load("webkb", "v0.0.3"; fold=2)
load("boston_housing", "v0.0.4")

println(_make_data_url("toy_cancer"))

r = HTTP.request("GET", "http://httpbin.org/ip")
println(r.status)
println(String(r.body))
=#
