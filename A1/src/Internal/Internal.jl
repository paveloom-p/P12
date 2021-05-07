"This module contains all inner parts."
module Internal

export Problem, Options, solve

using LinearAlgebra
using OffsetArrays
using UnPack

"""
```
Problem(
    p::Function,
    q::Function,
    f::Function,
    a::Float64,
    α::Float64,
    A::Float64,
    b::Float64,
    β::Float64,
    B::Float64
)
```

A linear boundary value problem.

Expects the problem in the form:

```
y''(x) + p(x) * y'(x) + q(x) * y(x) = f(x)
y'(a) = α * y(a) + A
y'(b) = β * y(b) + B
```

"""
struct Problem
    p::Function
    q::Function
    f::Function

    a::Float64
    α::Float64
    A::Float64
    b::Float64
    β::Float64
    B::Float64
end

"""
`Options(n::Integer)`

Options to provide to the solver. Includes the number of nodes in the grid `n`.
"""
struct Options
    n::Integer
end

"The default set of options. Sets `n` to 1000."
DefaultOptions = Options(1000)

include("Functions/solve.jl")

end
