__precompile__()

"""

A module for searching for eigenvalues of symmetric matrices.

See `Problem`, `Options`, and `solve` for more info.

"""
baremodule A3

using Base

# Load the internal logic
Base.include(A3, "Internal/Internal.jl")

# Export the second-level components
using .Internal

# Export the first-level components
export Problem, Options, solve

end
