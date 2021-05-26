include("src/A2.jl")
using .A2

using GRUtils

a = 0
b = 1
n = 1000

y, z = solve(
    Problem(
        (A) -> 1 / 3,
        (A) -> -A,
        (A) -> -2,
        (A) -> A,
        (x, z) -> sqrt(z^2 / 2),
        (x, z) -> - z / (z^2 + 1),
        a,
        b,
        -10,
        -4,
        4,
    ),
    Options(n),
)

h = (b - a) / n
x = [a + i * h for i in 0:n]

plot(x, y)
plot(x, z, hold=true)
savefig("figures/result.pdf")
