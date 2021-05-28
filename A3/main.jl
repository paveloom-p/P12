include("src/A3.jl")
using .A3

λₘₐₓ, λₘᵢₙ, λ = solve(
    Problem(
        function(i, j)
            return (-1)^(i+j) / (abs(i-j) + 1)
        end,
    ),
)
