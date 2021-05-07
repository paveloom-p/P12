__precompile__()

"""

A module for solving linear boundary value problems by the difference method using
the Thomas algorithm method.

See `Problem`, `Options`, and `solve` for more info.

"""
baremodule A1

using Base

# Load the internal logic
Base.include(A1, "Internal/Internal.jl")

# Export the second-level components
using .Internal

# Export the first-level components
export Problem, Options, solve

end
