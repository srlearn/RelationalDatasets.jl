# API Docs

## `load`

The main function for loading a dataset is `load`, which returns a train and
test fold for a `RelationalDataset` type.

```@docs
RelationalDatasets.load
```

## Convert propositional->relational

Many standard machine learning tasks are built around predicting a vector of
outcomes $y$ from a data matrix $X$.

Here we include methods for converting data like these into an Inductive
Logic Programming or relational representation.

### `from_vector`

This assumes that the machine learning task can be inferred from the types of
$y$: if $y$ is composed of discrete integers we are in a classification task,
if $y$ is composed of continuous floats then we are in a regression task.

```@docs
RelationalDatasets.from_vector
```

Demo for converting a classification problem:

```@example
using RelationalDatasets # hide
data, modes = RelationalDatasets.from_vector(
  [[0, 1, 1] [1, 0, 2] [2, 2, 0]],
  [0, 0, 1],
)
data.pos
```

Regression is similar:

```@example
using RelationalDatasets # hide
data, modes = RelationalDatasets.from_vector(
  [[0, 1, 1] [1, 0, 2] [2, 2, 0]],
  [1.1, 1.2, 1.3],
)
data.pos
```

Custom names can also be passed to help make variables more interpretable.
Below a small example based on the
[Boston Housing](https://srlearn.github.io/relational-datasets/dataset_descriptions/boston_housing/)
dataset.

The first two names are covariates and the last ("medv") is
the dependent variable:

```@example
using RelationalDatasets # hide
data, modes = RelationalDatasets.from_vector(
  [[1, 1] [1, 2] [2, 1]],
  [33.2, 27.5, 18.9],
  ["age", "dis", "medv"],
)
data.facts
```

## Constants

### `DATASETS`

```@docs
RelationalDatasets.DATASETS
```

```@example
using RelationalDatasets # hide
RelationalDatasets.DATASETS
```

### `LATEST_VERSION`

```@docs
RelationalDatasets.LATEST_VERSION
```

```@example
using RelationalDatasets # hide
RelationalDatasets.LATEST_VERSION
```
