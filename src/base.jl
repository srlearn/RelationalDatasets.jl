# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License


function get_data_home(data_home::Union{String, Nothing} = nothing)::String

    if data_home == nothing
        # Try setting using the RELATIONAL_DATASETS environment variables.
        println("data home is not set")
    end

    return "/home/hayesall/relational_datasets/"

end


function clear_data_home(data_home::Union{String, Nothing})::nothing
end
