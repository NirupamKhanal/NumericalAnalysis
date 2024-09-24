# Linear Spline Interpolation

# Function to perform linear spline interpolation
function linear_spline_interpolation(x, y, xi)
    n = length(x)
    
    if length(y) != n
        throw(DimensionMismatch("x and y must have the same length."))
    end
    
    yi = []
    
    for i in 1:length(xi)
        # Find the interval where xi[i] belongs
        if xi[i] < x[1] || xi[i] > x[n]
            throw(BoundsError("xi values are outside the range of x."))
        end
        
        for j in 1:n-1
            if xi[i] >= x[j] && xi[i] <= x[j+1]
                # Compute the linear interpolation in this interval
                slope = (y[j+1] - y[j]) / (x[j+1] - x[j])
                y_interp = y[j] + slope * (xi[i] - x[j])
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
    yi = linear_spline_interpolation(x, y, xi)
    
    println("Interpolated values at xi: ", xi)
    println("Corresponding yi values: ", yi)
end

main()
