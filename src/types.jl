# Copyright 2021 Alexander L. Hayes
# Apache 2.0 License

"""
Custom Types
"""

#=
data = RelationalDataset((
    ["cancer(alice)."],
    ["cancer(dan)."],
    ["friends(alice,bob)."]
))

println(data)
=#


RelationalDataset = @NamedTuple begin
    pos::Vector{String}
    neg::Vector{String}
    facts::Vector{String}
end
