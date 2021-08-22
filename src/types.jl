# Copyright © 2021 Alexander L. Hayes
# Apache 2.0 License

"""
Custom Types
"""

"""RelationalDataset

The RelationalDataset is a `NamedTuple` with positive examples (pos), negative
examples (neg), and facts (facts) about a domain.

Examples
--------

Create an instance of a `RelationalDataset` type:

```julia
using RelationalDatasets

train = RelationalDatasets.RelationalDataset((
    pos=["related(a,b)."],
    neg=["related(b,c)."],
    facts=["child(a,b)."],
))
```

Instances of `RelationalDataset` are returned by `load`:

```julia
using RelationalDatasets

train, test = load("webkb")
```
"""
RelationalDataset = @NamedTuple begin
    pos::Vector{String}
    neg::Vector{String}
    facts::Vector{String}
end
