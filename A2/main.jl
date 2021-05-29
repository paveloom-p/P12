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
        -5,
        -4,
        4,
    ),
    Options(n),
)

open("result", "w") do io
    println(io, "y z")
    for i in 1:n+1
        println(io, y[i], " ", z[i])
    end
end

h = (b - a) / n
x = [a + i * h for i in 0:n]

plot(x, y)
plot(x, z, hold=true)
legend("y", "z")
savefig("figures/result.pdf")
