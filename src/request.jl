# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

"""Request copies of relational datasets.
"""

using HTTP
using ZipFile

include("base.jl")
include("types.jl")

"""
Available datasets from the
[`srlearn/datasets`](https://github.com/srlearn/datasets) repository.
"""
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
    "drug_interactions",
    "toy_machines",
]

"""Default download version.

If a "version" parameter is not passed to `load`, a dataset of this version
is downloaded by default.
"""
LATEST_VERSION = "v0.0.5"


"""
    load(name::String, version::Union{String, Nothing} = nothing; fold::Int64 = 1)

Load the training and test folds for a dataset.
"""
function load(name::String, version::Union{String, Nothing} = nothing; fold::Int64 = 1)
    data_location = fetch(name, version)
    return deserialize_zipfile(data_location, name, fold=fold)
end


function deserialize_zipfile(data_location::String, name::String; fold::Int64 = 1)

    reader = ZipFile.Reader(data_location)

    folds = _n_folds(reader)

    train_pos, train_neg, train_facts = nothing, nothing, nothing
    test_pos, test_neg, test_facts = nothing, nothing, nothing


    # TODO(hayesall): The ZipFile.jl doesn't make it quite as easy to seek a file by name.
    #   There's a package for building iterators out of tar archives, but it appears that
    #   the only way to do a "file name lookup" is by building an intermediate dictionary
    #   and jumping to the index of the name you want.
    file_num = Dict{String, Int64}()
    for (i, fname) in enumerate(reader.files)
        file_num[fname.name] = i
    end


    if folds == 0
        train_pos = readlines(reader.files[file_num["$(name)/train/train_pos.txt"]])
        train_neg = readlines(reader.files[file_num["$(name)/train/train_neg.txt"]])
        train_facts = readlines(reader.files[file_num["$(name)/train/train_facts.txt"]])

        test_pos = readlines(reader.files[file_num["$(name)/test/test_pos.txt"]])
        test_neg = readlines(reader.files[file_num["$(name)/test/test_neg.txt"]])
        test_facts = readlines(reader.files[file_num["$(name)/test/test_facts.txt"]])

    elseif fold > folds
        throw(error("Fold ($(fold)) does not exist in $(data_location)"))

    else

        train_pos = readlines(reader.files[file_num["$(name)/fold$(fold)/train/train_pos.txt"]])
        train_neg = readlines(reader.files[file_num["$(name)/fold$(fold)/train/train_neg.txt"]])
        train_facts = readlines(reader.files[file_num["$(name)/fold$(fold)/train/train_facts.txt"]])

        test_pos = readlines(reader.files[file_num["$(name)/fold$(fold)/test/test_pos.txt"]])
        test_neg = readlines(reader.files[file_num["$(name)/fold$(fold)/test/test_neg.txt"]])
        test_facts = readlines(reader.files[file_num["$(name)/fold$(fold)/test/test_facts.txt"]])

    end

    close(reader)

    return RelationalDataset((
        train_pos,
        train_neg,
        train_facts,
    )), RelationalDataset((
        test_pos,
        test_neg,
        test_facts,
    ))

end

"""
    fetch(name::String, version::Union{String, Nothing} = nothing)

Download a dataset with `name` and `version`, write the zipfile to the cache
directory, and return a string representing the path to the file on disk.
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

function _make_data_url(name::String, version::Union{String, Nothing} = nothing)::String
    @assert name in DATASETS
    if version == nothing
        version = LATEST_VERSION
    end

    # TODO(hayesall): Enforce no v0.0.2 or v0.0.3
    return "https://github.com/srlearn/datasets/releases/download/$(version)/$(name)_$(version).zip"
end

"""Does this zipfile contain CV folds?"""
function _has_folds(zip::ZipFile.Reader)::Bool
    return any([occursin("fold", file.name) for file in zip.files])
end

"""How many folds does this contain?"""
function _n_folds(zip::ZipFile.Reader)::Int64

    if !_has_folds(zip)
        return 0
    end

    numbers = Int64[]
    for path in zip.files
        if occursin("fold", path.name)
            append!(numbers, parse(Int64, split(split(path.name, "fold")[2], "/")[1]))
        end
    end

    return maximum(numbers)
end
