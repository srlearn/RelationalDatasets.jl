# RelationalDatasets.jl

*A small library for loading and downloading relational datasets.*

or: *The [`relational-datasets`](https://github.com/srlearn/relational-datasets)
Python package—but written in Julia.*

```console
add RelationalDatasets
```

![GitHub release (latest by date)](https://img.shields.io/github/v/release/srlearn/RelationalDatasets.jl)
![GitHub](https://img.shields.io/github/license/srlearn/RelationalDatasets.jl)
[![codecov](https://codecov.io/gh/srlearn/RelationalDatasets.jl/branch/main/graph/badge.svg?token=HaQuwbovLv)](https://codecov.io/gh/srlearn/RelationalDatasets.jl)
[![Ubuntu/macOS/Windows](https://github.com/srlearn/RelationalDatasets.jl/actions/workflows/package-tests.yml/badge.svg)](https://github.com/srlearn/RelationalDatasets.jl/actions/workflows/package-tests.yml)

## Usage

[![RelationalDatasets.jl stable documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://srlearn.github.io/RelationalDatasets.jl/stable)
[![RelationalDatasets.jl latest documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://srlearn.github.io/RelationalDatasets.jl/dev)

### Loading and Downloading Benchmark Datasets

`RelationalDatasets.jl` exports a single function: `load` to return train
and test folds.

```julia
using RelationalDatasets

train, test = load("webkb", "v0.0.4", fold=2)
length(train.facts)
# 1344
```

### Converting Vector-based Datasets

*Binary classification when `y` is a vector of 0/1*:

```julia
using RelationalDatasets

data, modes = RelationalDatasets.from_vector(
  [0 1 1; 1 0 2; 2 2 0],
  [0, 0, 1],
)
```

*Regression when `y` is a vector of floats*:

```julia
using RelationalDatasets

data, modes = RelationalDatasets.from_vector(
  [0 1 1; 1 0 2; 2 2 0],
  [1.1, 0.9, 2.5],
)
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
