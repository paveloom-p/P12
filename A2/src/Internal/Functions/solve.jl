"""
`solve(P::Problem, O::Options=DefaultOptions)::Tuple{Vector, Vector}`

Solve the problem `P` using options `O`.

See `Problem` and `Options` for more info about how to state a problem and change the
default options.
"""
function solve(P::Problem, O::Options=DefaultOptions)::Tuple{Vector, Vector}

    # Unpack the data structures
    @unpack α, β, γ, δ, p, q, a, b, A, y₀, z₀ = P
    @unpack n = O

    # Compute the step
    h = (b - a) / n

    # Prepare the result arrays
    y = Vector{Float64}(undef, n+1); z = copy(y)

    # Put the boundary values first
    y[1] = y₀
    z[1] = z₀

    # Compute the rest
    for i in 1:n
        x = a + i * h
        yᵢ₊₁(x, zᵢ₊₁) = (y[i] + h * (β(A) * zᵢ₊₁ + p(x, zᵢ₊₁))) / (1 - h * α(A))
        z[i+1] = find_zero(
            (zᵢ₊₁) -> -zᵢ₊₁ + z[i] + h * (γ(A) * yᵢ₊₁(x, zᵢ₊₁) + δ(A) * zᵢ₊₁ + q(x, zᵢ₊₁)),
            z[i],
        )
        y[i+1] = yᵢ₊₁(x, z[i+1])
    end

    return y, z

end
