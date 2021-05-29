include("src/A1.jl")
using .A1

y = solve(
    Problem(
        (x) -> 2 / √(x + 1),
        (x) -> -2 * √(x^2 + 1),
        (x) -> 10 / (1 + x * (1 - x)),
        0,
        0,
        0.5,
        1,
        -1,
        0,
    ),
    Options(1000),
)

open("result", "w") do io
    println(io, y)
end
