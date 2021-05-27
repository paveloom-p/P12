__precompile__()

"""

A module for solving Cauchy problems for linear-stiff systems of two ordinary differential
equations.

See `Problem`, `Options`, and `solve` for more info.

"""
baremodule A2

using Base

# Load the internal logic
Base.include(A2, "Internal/Internal.jl")

# Export the second-level components
using .Internal

# Export the first-level components
export Problem, Options, solve

end
