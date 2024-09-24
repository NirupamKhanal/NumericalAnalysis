# Quadratic Spline Interpolation

# Function to perform quadratic spline interpolation
function quadratic_spline_interpolation(x, y, xi)
    n = length(x) - 1  # n is the number of intervals (length of x - 1)
    h = diff(x)  # h contains the differences between consecutive x values
    
    # Coefficients for the quadratic spline: a, b, and c
    a = y[1:n]
    b = zeros(n)
    c = zeros(n+1)  # Note: c has n+1 elements

    # Set up the system of equations for the second derivative conditions
    A = zeros(n-1, n-1)
    rhs = zeros(n-1)

    # Fill the matrix A and rhs based on second derivative continuity
    for i in 1:n-1
        A[i, i] = 2 * (h[i] + h[i+1])
        if i != 1
            A[i, i-1] = h[i]
        end
        if i != n-1
            A[i, i+1] = h[i+1]
        end
        rhs[i] = 3 * ((y[i+2] - y[i+1]) / h[i+1] - (y[i+1] - y[i]) / h[i])
    end

    # Solve for the c coefficients (interior)
    c[2:n] = A \ rhs

    # Solve for the b coefficients
    for i in 1:n
        b[i] = (y[i+1] - y[i]) / h[i] - (c[i+1] + 2 * c[i]) * h[i] / 3
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
                y_interp = a[i] + b[i] * dx + c[i] * dx^2
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
    yi = quadratic_spline_interpolation(x, y, xi)
    
    println("Interpolated values at xi: ", xi)
    println("Corresponding yi values: ", yi)
end

main()