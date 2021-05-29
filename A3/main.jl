include("src/A3.jl")
using .A3

λₘₐₓ, λₘᵢₙ, λ = solve(
    Problem(
        function(i, j)
            return (-1)^(i+j) / (abs(i-j) + 1)
        end,
    ),
)

open("result", "w") do io
    println(io, "λₘₐₓ = ", λₘₐₓ)
    println(io, "λₘᵢₙ = ", λₘᵢₙ, "\n")
    println(io, "λ: ")
    for e in λ
        println(io, e)
    end
end
