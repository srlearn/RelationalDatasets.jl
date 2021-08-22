# RelationalDatasets.jl

> *A small library for loading and downloading relational datasets.*
>
> or:
>
> *The [`relational-datasets`](https://github.com/srlearn/relational-datasets)
> Python package—but written in Julia.*

![GitHub release (latest by date)](https://img.shields.io/github/v/release/srlearn/RelationalDatasets.jl)
![GitHub](https://img.shields.io/github/license/srlearn/RelationalDatasets.jl)
[![codecov](https://codecov.io/gh/srlearn/RelationalDatasets.jl/branch/main/graph/badge.svg?token=HaQuwbovLv)](https://codecov.io/gh/srlearn/RelationalDatasets.jl)
[![Ubuntu/macOS/Windows](https://github.com/srlearn/RelationalDatasets.jl/actions/workflows/package-tests.yml/badge.svg)](https://github.com/srlearn/RelationalDatasets.jl/actions/workflows/package-tests.yml)

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
