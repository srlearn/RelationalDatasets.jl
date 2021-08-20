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
function from_vector(X::Vector{Vector{Int64}}, y::Vector{Int64})::RelationalDataset
    println("Classification")

    for row in enumerate(transpose(X))
        println(row)
    end

    return RelationalDataset((["one"], ["two"], ["three"]))
end

"""
    from_vector()

Convert a regression dataset to an ILP representation.
"""
function from_vector(X::Vector{Vector{Int64}}, y::Vector{Float64})::RelationalDataset
    println("Regression")
    return RelationalDataset((["one"], ["two"], ["three"]))
end
