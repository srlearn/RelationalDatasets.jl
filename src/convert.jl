# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

"""Convert (array-based) propositional datasets to a relational/ILP
representation.
"""

include("types.jl")

"""
    from_vector()

Convert a classification dataset to an ILP representation.
"""
function from_vector(X::Matrix{Int64}, y::Vector{Int64}, names::Union{Vector{String}, Nothing} = nothing)

    # Make sure the X and y are valid.
    @assert size(y)[1] == size(X)[2]

    if names == nothing
        names = ["v$(i)" for i in 1:size(X)[1] + 1]
    end

    # Make sure the names vector makes sense.
    @assert length(names) - 1 == size(X)[1]

    pos, neg, facts = String[], String[], String[]

    for (i, row) in enumerate(y)
        if Bool(row)
            push!(pos, "$(last(names))(id$(i)).")
        else
            push!(neg, "$(last(names))(id$(i)).")
        end
    end

    for (i, col) in enumerate(eachcol(X))
        var = names[i]
        facts = vcat(facts, ["$(var)(id$(j),$(row))." for (j, row) in enumerate(col)])
    end

    modes = ["$(name)(+id,#var$(name))." for name in names[1:end-1]]
    push!(modes, "$(last(names))(+id).")

    return RelationalDataset((pos, neg, facts)), modes
end

"""
    from_vector()

Convert a regression dataset to an ILP representation.
"""
function from_vector(X::Matrix{Int64}, y::Vector{Float64}, names::Union{Vector{String}, Nothing} = nothing)

    # Make sure the X and y are valid.
    @assert size(y)[1] == size(X)[2]

    if names == nothing
        names = ["v$(i)" for i in 1:size(X)[1] + 1]
    end

    # Make sure the names vector makes sense.
    @assert length(names) - 1 == size(X)[1]

    pos, neg, facts = String[], String[], String[]

    for (i, row) in enumerate(y)
        push!(pos, "regressionExample($(last(names))(id$(i)),$(row)).")
    end

    for (i, col) in enumerate(eachcol(X))
        var = names[i]
        facts = vcat(facts, ["$(var)(id$(j),$(row))." for (j, row) in enumerate(col)])
    end

    modes = ["$(name)(+id,#var$(name))." for name in names[1:end-1]]
    push!(modes, "$(last(names))(+id).")

    return RelationalDataset((pos, neg, facts)), modes
end
