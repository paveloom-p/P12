include("src/A1.jl")
using .A1

using GRUtils

a = 0
b = 1

p = Problem(
    (x) -> 2 / √(x + 1),
    (x) -> -2 * √(x^2 + 1),
    (x) -> 10 / (1 + x * (1 - x)),
    a,
    0,
    0.5,
    b,
    -1,
    0,
)

open("result", "w") do io
    println(io, solve(p))
end

for n in (10, 100)
    h = (b - a) / n
    x = [a + i * h for i in 0:n]
    y = solve(p, Options(n))
    if n == 10
        plot(x, y, "+", x, y, "b--", hold=true)
    else
        plot(x, y, hold=true)
    end
end

legend("n = 10", "n = 10", "n = 100", location = "upper left")
savefig("figures/comparison.pdf")
