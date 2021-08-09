# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

import Base.Filesystem: expanduser, joinpath, mkpath, rm

"""
    get_data_home(data_home::Union{String, Nothing} = nothing)::String

Get the data home directory.
"""
function get_data_home(data_home::Union{String, Nothing} = nothing)::String

    _path = ""

    if data_home == nothing
        try
            _path = expanduser(ENV["RELATIONAL_DATASETS"])
        catch e
            _path = expanduser(
                joinpath("~", "relational_datasets")
            )
        end
    end

    return mkpath(_path)
end


function clear_data_home(data_home::Union{String, Nothing} = nothing)
    path = get_data_home(data_home)
    rm(path, force=true, recursive=true)
    return nothing
end
