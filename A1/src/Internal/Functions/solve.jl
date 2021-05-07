"""
`solve(P::Problem, O::Options=DefaultOptions)`

Solve the problem `P` using options `O`.

See `Problem` and `Options` for more info about how to state a problem and change the default options.
"""
function solve(P::Problem, O::Options=DefaultOptions)

    # Unpack the data structures
    @unpack p, q, f, a, α, A, b, β, B = P
    @unpack n = O

    # Compute the step
    h = (b - a) / n

    # Compute auxiliary variables
    h⁻¹ = 1 / h
    hₕ = h / 2
    ax₀ = h⁻¹ * (hₕ * p(a) + 1)
    axₙ = h⁻¹ * (hₕ * p(b) - 1)

    # Compute diagonals and right-hand column
    dl = OffsetArray([[1 - hₕ * p(a + k * h) for k in 1:n-1]; axₙ], 2:n+1)
    d = [-ax₀ + hₕ * q(a) - α; [h^2 * q(a + k * h) - 2 for k in 1:n-1]; -axₙ - hₕ * q(b) - β]
    du = [ax₀; [1 + hₕ * p(a + k * h) for k in 1:n-1]]
    f = [hₕ * f(a) + A; [h^2 * f(a + k * h) for k in 1:n-1]; B - hₕ * f(b)]

    # Perform the forward sweep
    for i in 2:n+1
        w = dl[i] / d[i-1]
        d[i] = d[i] - w * du[i-1]
        f[i] = f[i] - w * f[i-1]
    end

    # Prepare the result array
    y = Vector{Float64}(undef, n+1)

    # Perform the back substitution
    y[n+1] = f[n+1] / d[n+1]
    for i in n:-1:1
        y[i] = (f[i] - du[i] * y[i+1]) / d[i]
    end

end
