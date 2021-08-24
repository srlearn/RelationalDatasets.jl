# Copyright © 2021 Alexander L. Hayes

"""
Thinking through a graph/hypergraph representation of Relational Datasets.
"""

include("types.jl")

function build_entity_map(data::RelationalDataset)

    # TODO(hayesall): Is this really the best way to do parsing?
    entities = [split(split(split(pred, "(")[2], ")")[1], ",") for pred in data.facts]

    entity_map = Dict{String, Int64}()
    i = 1

    for row in entities
        for entity in row
            if !(haskey(entity_map, entity))
                entity_map[entity] = i
                i += 1
            end
        end
    end

    return entity_map
end
