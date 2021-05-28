"This module contains all inner parts."
module Internal

export Problem, Options, solve

using LinearAlgebra
using UnPack

"""
```
Problem(
    aᵢⱼ::Function
)
```

A function `aᵢⱼ(i, j)` for generating a symmetric matrix (upper triangle).
"""
struct Problem
    aᵢⱼ::Function
end

"""
`Options(n::Integer)`

Options to provide to the solver.

Includes:
- order `n` of the matrix;
- maximum number of iterations `iterₘₐₓ` for the Jacobi eigenvalue algorithm;
- error `ϵₚ` for power methods;
- error `ϵⱼ` for the Jacobi eigenvalue algorithm;
- function `get_x₀(A)` to get a vector of initial values.
"""
struct Options
    n::Integer
    iterₘₐₓ::Integer
    ϵₚ::Float64
    ϵⱼ::Float64
    get_x₀::Function
end

"""
The default set of options.

Sets:
- `n` to `10`;
- `iterₘₐₓ` to `1000000`;
- `ϵₚ` to `1e-16`;
- `ϵⱼ` to `1e-9`;
- `get_x₀(A)` to `(A) -> ones(size(A, 1))`.
"""
DefaultOptions = Options(10, 1000000, 1e-16, 1e-9, (A) -> ones(size(A, 1)))

include("Functions/solve.jl")

end
