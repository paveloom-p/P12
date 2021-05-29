# Description

Every directory shares the same logic.

## Julia

From the root of the project (A1, A2, or A3), run

```bash
julia --project=. main.jl
```

To get more information about the modules' contents, include a local module in the Julia REPL

```julia
include("src/A1.jl")
using .A1
```

and examine the docstrings

```julia
?A1
?Problem
?Options
?solve
```

## TeX

Use [`tectonic`](https://github.com/tectonic-typesetting/tectonic) to compile the `.tex` files:

```bash
tectonic -X compile A1.tex
```

Note that you need to be in the same directory as the `.tex` file.
