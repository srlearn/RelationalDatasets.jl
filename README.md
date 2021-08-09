# RelationalDatasets.jl

> *A small library for loading and downloading relational datasets.*
>
> or:
>
> *The [`relational-datasets`](https://github.com/srlearn/relational-datasets)
Python package—but written in Julia.*

## Usage

`RelationalDatasets.jl` exports a single function: `load` to return train
and test folds.

```julia
using RelationalDatasets

train, test = load("webkb", "v0.0.4", fold=2)

println(length(train.facts))
```

## Install

### From Registry

WIP

### From GitHub Source

```bash
git clone https://github.com/srlearn/RelationalDatasets.jl.git
cd RelationalDatasets.jl
```

```julia
] add RelationalDatasets
```

`ZipFile.jl` seems to fail occasionally. If an error is raised, try
instantiating the package:

```julia
] activate .
using Pkg
Pkg.instantiate()
```
