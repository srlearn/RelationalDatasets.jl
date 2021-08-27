var documenterSearchIndex = {"docs":
[{"location":"api/#API-Docs","page":"API Docs","title":"API Docs","text":"","category":"section"},{"location":"api/#load","page":"API Docs","title":"load","text":"","category":"section"},{"location":"api/","page":"API Docs","title":"API Docs","text":"The main function for loading a dataset is load, which returns a train and test fold for a RelationalDataset type.","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"RelationalDatasets.load","category":"page"},{"location":"api/#RelationalDatasets.load","page":"API Docs","title":"RelationalDatasets.load","text":"load(name::String, version::Union{String, Nothing} = nothing; fold::Int64 = 1)\n\nLoad the training and test folds for a dataset.\n\n\n\n\n\n","category":"function"},{"location":"api/#Convert-propositional-relational","page":"API Docs","title":"Convert propositional->relational","text":"","category":"section"},{"location":"api/","page":"API Docs","title":"API Docs","text":"Many standard machine learning tasks are built around predicting a vector of outcomes y from a data matrix X.","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"Here we include methods for converting data like these into an Inductive Logic Programming or relational representation.","category":"page"},{"location":"api/#from_vector","page":"API Docs","title":"from_vector","text":"","category":"section"},{"location":"api/","page":"API Docs","title":"API Docs","text":"This assumes that the machine learning task can be inferred from the types of y: if y is composed of discrete integers we are in a classification task, if y is composed of continuous floats then we are in a regression task.","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"RelationalDatasets.from_vector","category":"page"},{"location":"api/#RelationalDatasets.from_vector","page":"API Docs","title":"RelationalDatasets.from_vector","text":"from_vector(X::Matrix{Int}, y::Vector{Int}, names::Union{Vector{String}, Nothing} = nothing)\n\nConvert a classification dataset to an ILP representation.\n\n\n\n\n\nfrom_vector(X::Matrix{Int}, y::Vector{Float64}, names::Union{Vector{String}, Nothing} = nothing)\n\nConvert a regression dataset to an ILP representation.\n\n\n\n\n\n","category":"function"},{"location":"api/","page":"API Docs","title":"API Docs","text":"Demo for converting a classification problem:","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"using RelationalDatasets # hide\ndata, modes = RelationalDatasets.from_vector(\n  [[0, 1, 1] [1, 0, 2] [2, 2, 0]],\n  [0, 0, 1],\n)\ndata.pos","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"Regression is similar:","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"using RelationalDatasets # hide\ndata, modes = RelationalDatasets.from_vector(\n  [[0, 1, 1] [1, 0, 2] [2, 2, 0]],\n  [1.1, 1.2, 1.3],\n)\ndata.pos","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"Custom names can also be passed to help make variables more interpretable. Below a small example based on the Boston Housing dataset.","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"The first two names are covariates and the last (\"medv\") is the dependent variable:","category":"page"},{"location":"api/","page":"API Docs","title":"API Docs","text":"using RelationalDatasets # hide\ndata, modes = RelationalDatasets.from_vector(\n  [[1, 1] [1, 2] [2, 1]],\n  [33.2, 27.5, 18.9],\n  [\"age\", \"dis\", \"medv\"],\n)\ndata.facts","category":"page"},{"location":"api/#Constants","page":"API Docs","title":"Constants","text":"","category":"section"},{"location":"api/#DATASETS","page":"API Docs","title":"DATASETS","text":"","category":"section"},{"location":"api/","page":"API Docs","title":"API Docs","text":"RelationalDatasets.DATASETS","category":"page"},{"location":"api/#RelationalDatasets.DATASETS","page":"API Docs","title":"RelationalDatasets.DATASETS","text":"Available datasets from the srlearn/datasets repository.\n\n\n\n\n\n","category":"constant"},{"location":"api/","page":"API Docs","title":"API Docs","text":"using RelationalDatasets # hide\nRelationalDatasets.DATASETS","category":"page"},{"location":"api/#LATEST_VERSION","page":"API Docs","title":"LATEST_VERSION","text":"","category":"section"},{"location":"api/","page":"API Docs","title":"API Docs","text":"RelationalDatasets.LATEST_VERSION","category":"page"},{"location":"api/#RelationalDatasets.LATEST_VERSION","page":"API Docs","title":"RelationalDatasets.LATEST_VERSION","text":"Default download version.\n\nIf a \"version\" parameter is not passed to load, a dataset of this version is downloaded by default.\n\n\n\n\n\n","category":"constant"},{"location":"api/","page":"API Docs","title":"API Docs","text":"using RelationalDatasets # hide\nRelationalDatasets.LATEST_VERSION","category":"page"},{"location":"#RelationalDatasets.jl","page":"Home","title":"RelationalDatasets.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A small library for loading and downloading relational datasets.or:The relational-datasets Python package—but written in Julia.","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: GitHub release (latest by date)) (Image: GitHub) (Image: codecov) (Image: Ubuntu/macOS/Windows)","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"RelationalDatasets.jl exports a single function: load to return train and test folds.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using RelationalDatasets\n\ntrain, test = load(\"webkb\", \"v0.0.4\", fold=2)\n\nprintln(length(train.facts))\n# 1344","category":"page"},{"location":"#Install","page":"Home","title":"Install","text":"","category":"section"},{"location":"#From-Registry","page":"Home","title":"From Registry","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"add RelationalDatasets","category":"page"},{"location":"#From-GitHub","page":"Home","title":"From GitHub","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using Pkg\nPkg.add(url=\"https://github.com/srlearn/RelationalDatasets.jl\")","category":"page"},{"location":"types/#Types","page":"Types","title":"Types","text":"","category":"section"},{"location":"types/#RelationalDataset","page":"Types","title":"RelationalDataset","text":"","category":"section"},{"location":"types/","page":"Types","title":"Types","text":"RelationalDatasets.RelationalDataset","category":"page"},{"location":"types/#RelationalDatasets.RelationalDataset","page":"Types","title":"RelationalDatasets.RelationalDataset","text":"RelationalDataset\n\nThe RelationalDataset is a NamedTuple with positive examples (pos), negative examples (neg), and facts (facts) about a domain.\n\nExamples\n\nCreate an instance of a RelationalDataset type:\n\nusing RelationalDatasets\n\ntrain = RelationalDatasets.RelationalDataset((\n    pos=[\"related(a,b).\"],\n    neg=[\"related(b,c).\"],\n    facts=[\"child(a,b).\"],\n))\n\nInstances of RelationalDataset are returned by load:\n\nusing RelationalDatasets\n\ntrain, test = load(\"webkb\")\n\n\n\n\n\n","category":"type"}]
}
