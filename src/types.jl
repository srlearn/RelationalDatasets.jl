# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

"""
Custom Types
"""

RelationalDataset = @NamedTuple begin
    pos::Vector{String}
    neg::Vector{String}
    facts::Vector{String}
end
