"This module contains all inner parts."
module Internal

export Problem, Options, solve

using Roots
using UnPack

"""
```
Problem(
    α::Function,
    β::Function,
    γ::Function,
    δ::Function,
    p::Function
    q::Function
    a::Float64,
    b::Float64,
    A::Float64,
    y₀::Float64,
    z₀::Float64,
)
```

A Cauchy problem for a linear-stiff system of two ordinary differentials equations.

Expects the problem in the form:

```
[L]  y'(x) = α(A) y(x) + β(A) z(x) + p(x,z(x))
[NL] z'(x) = γ(A) y(x) + δ(A) z(x) + q(x,y(x),z(x))
y(a) = y₀, z(a) = z₀
```

where [L] is a linear equation, and [NL] is a nonlinear equation. The interval is [a, b].

You can call `y(x)` in `q` as `yᵢ₊₁(x, zᵢ₊₁)`.

"""
struct Problem
    α::Function
    β::Function
    γ::Function
    δ::Function

    p::Function
    q::Function

    a::Float64
    b::Float64
    A::Float64

    y₀::Float64
    z₀::Float64
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
