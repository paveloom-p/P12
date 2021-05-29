include("src/A1.jl")
using .A1

y = solve(
    Problem(
        (x) -> 2 / √(x + 1), # p(x)
        (x) -> -2 * √(x^2 + 1), # q(x)
        (x) -> 10 / (1 + x * (1 - x)), # f(x)
        0, # a
        0, # α
        0.5, # A
        1, # b
        -1, # β
        0, # B
    ),
    Options(1000), # n
)

open("result", "w") do io
    println(io, y)
end
