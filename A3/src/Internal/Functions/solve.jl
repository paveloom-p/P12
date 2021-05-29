"""
`solve(P::Problem, O::Options=DefaultOptions)::Tuple{Float64, Float64, Vector}`

Solve the problem `P` using options `O`.

See `Problem` and `Options` for more info about how to state a problem and change the
default options.
"""
function solve(P::Problem, O::Options=DefaultOptions)::Tuple{Float64, Float64, Vector}

    # Unpack the data structures
    @unpack aᵢⱼ = P
    @unpack n, iterₘₐₓ, ϵₚ, ϵⱼ, get_x₀ = O

    # Get the matrix
    A = Symmetric(Array{Float64}(undef, n, n))
    for i = 1:n, j = i:n
        A.data[i,j] = aᵢⱼ(i, j)
    end

    # Get a vector of initial values
    x₀ = get_x₀(A)

    # Find the maximum modulo eigenvalue

    xₙ = copy(x₀)
    λₘₐₓ = 0
    λₚᵣₑᵥ = 1

    while abs(1 - λₘₐₓ / λₚᵣₑᵥ) > ϵₚ
        λₚᵣₑᵥ = λₘₐₓ
        x̃ₙ₊₁ = A * xₙ
        λₘₐₓ = x̃ₙ₊₁[1]
        xₙ = x̃ₙ₊₁ / λₘₐₓ
    end

    # Find the minimum modulo eigenvalue

    xₙ = copy(x₀)
    λ⁻¹ₘᵢₙ = 0
    λ⁻¹ₚᵣₑᵥ = 1

    while abs(1 - λ⁻¹ₘᵢₙ / λ⁻¹ₚᵣₑᵥ) > ϵₚ
        λ⁻¹ₚᵣₑᵥ = λ⁻¹ₘᵢₙ
        x̃ₙ₊₁ = A \ xₙ
        λ⁻¹ₘᵢₙ = x̃ₙ₊₁[1]
        xₙ = x̃ₙ₊₁ / λ⁻¹ₘᵢₙ
    end

    # Use the Jacobi eigenvalue algorithm to find all eigenvalues

    λ = Vector{Float64}(undef, n)

    for _ in 1:iterₘₐₓ

        aₘₐₓ = k = l = 0

        for i in 1:n-1, j in i+1:n
            if abs(A[i,j]) ≥ aₘₐₓ
                aₘₐₓ = abs(A[i,j])
                k = i; l = j
            end
        end

        if aₘₐₓ < ϵⱼ
            λ = Diagonal(A).diag
            break
        end

        Δ = A[l,l] - A[k,k]

        t = if abs(A[k,l]) < abs(Δ) * 1e-36
            A[k,l] / Δ
        else
            ϕ = Δ / (2 * A[k,l])
            if ϕ < 0
                -1 / (abs(ϕ) + √(ϕ^2 + 1))
            else
                1 / (abs(ϕ) + √(ϕ^2 + 1))
            end
        end

        c = 1 / √(t^2 + 1)
        s = t * c
        τ = s / (1 + c)

        aₜₑₘₚ = A[k,l]
        A.data[k,l] = 0
        A.data[k,k] -= t * aₜₑₘₚ
        A.data[l,l] += t * aₜₑₘₚ

        for i in 1:k-1
            aₜₑₘₚ = A[i,k]
            A.data[i,k] = aₜₑₘₚ - s * (A[i,l] + τ * aₜₑₘₚ)
            A.data[i,l] += s * (aₜₑₘₚ - τ * A[i,l])
        end

        for i in k+1:l-1
            aₜₑₘₚ = A[k,i]
            A.data[k,i] = aₜₑₘₚ - s * (A[i,l] + τ * A[k,i])
            A.data[i,l] += s * (aₜₑₘₚ - τ * A[i,l])
        end

        for i in l+1:n
            aₜₑₘₚ = A[k,i]
            A.data[k,i] = aₜₑₘₚ - s * (A[l,i] + τ * aₜₑₘₚ)
            A.data[l,i] += s * (aₜₑₘₚ - τ * A[l,i])
        end

    end

    return λₘₐₓ, 1 / λ⁻¹ₘᵢₙ, λ

end
