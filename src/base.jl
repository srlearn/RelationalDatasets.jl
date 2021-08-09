# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License


function get_data_home(data_home::Union{String, Nothing} = nothing)::String

    _path = ""

    if data_home == nothing
        try
            _path = Base.Filesystem.expanduser(ENV["RELATIONAL_DATASETS"])
        catch e
            _path = Base.Filesystem.expanduser(
                Base.Filesystem.joinpath("~", "relational_datasets")
            )
        end
    end

    return Base.Filesystem.mkpath(_path)
end


function clear_data_home(data_home::Union{String, Nothing} = nothing)
    path = get_data_home(data_home)
    Base.Filesystem.rm(path, force=true, recursive=true)
    return nothing
end
