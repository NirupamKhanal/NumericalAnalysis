# Cubic Spline Interpolation

# Function to perform cubic spline interpolation
function cubic_spline_interpolation(x, y, xi)
    n = length(x) - 1  # n is the number of intervals
    h = diff(x)  # h contains the differences between consecutive x values
    
    # Coefficients for the cubic spline: a, b, c, and d
    a = y[1:n+1]
    b = zeros(n)
    c = zeros(n+1)  # Note: c has n+1 elements (including boundaries)
    d = zeros(n)

    # Set up the tridiagonal system for the second derivatives (c)
    A = zeros(n+1, n+1)  # A will be tridiagonal with some extra conditions
    rhs = zeros(n+1)

    # Natural boundary conditions: second derivatives at the boundaries are 0
    A[1, 1] = 1
    A[n+1, n+1] = 1

    # Fill in the tridiagonal part for the interior points
    for i in 2:n
        A[i, i-1] = h[i-1]
        A[i, i] = 2 * (h[i-1] + h[i])
        A[i, i+1] = h[i]
        rhs[i] = 3 * ((y[i+1] - y[i]) / h[i] - (y[i] - y[i-1]) / h[i-1])
    end

    # Solve the system for c (second derivatives)
    c = A \ rhs

    # Solve for b and d coefficients
    for i in 1:n
        b[i] = (y[i+1] - y[i]) / h[i] - h[i] * (2 * c[i] + c[i+1]) / 3
        d[i] = (c[i+1] - c[i]) / (3 * h[i])
    end

    # Interpolation process
    yi = []
    for x_val in xi
        if x_val < x[1] || x_val > x[end]
            throw(BoundsError("xi values are outside the range of x."))
        end

        # Find the interval [x_i, x_{i+1}] where x_val lies
        for i in 1:n
            if x_val >= x[i] && x_val <= x[i+1]
                dx = x_val - x[i]
                y_interp = a[i] + b[i] * dx + c[i] * dx^2 + d[i] * dx^3
                push!(yi, y_interp)
                break
            end
        end
    end
    
    return yi
end

# Example usage
function main()
    # Given data points
    x = [1.0, 2.0, 3.0, 4.0, 5.0]
    y = [2.0, 4.1, 6.2, 8.5, 10.1]
    
    # Points at which we want to interpolate
    xi = [1.5, 2.5, 3.5, 4.5]
    
    # Perform interpolation
    yi = cubic_spline_interpolation(x, y, xi)
    
    println("Interpolated values at xi: ", xi)
    println("Corresponding yi values: ", yi)
end

main()