# RelationalDatasets.jl

> *A small library for loading and downloading relational datasets.*
>
> or:
>
> *The [`relational-datasets`](https://github.com/srlearn/relational-datasets)
> Python package—but written in Julia.*

## Usage

`RelationalDatasets.jl` exports a single function: `load` to return train
and test folds.

```julia
using RelationalDatasets

train, test = load("webkb", "v0.0.4", fold=2)

println(length(train.facts))
# 1344
```

## Install

### From Registry

```bash
add RelationalDatasets
```

### From GitHub

```julia
using Pkg
Pkg.add(url="https://github.com/srlearn/RelationalDatasets.jl")
```
