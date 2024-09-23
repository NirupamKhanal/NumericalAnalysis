# Function to calculate divided differences for Hermite interpolation
function divided_differences(x, y, dy)
    n = length(x)
    z = zeros(2 * n)
    Q = zeros(2 * n, 2 * n)

    # Fill in z array (repeated x values) and initial values in Q (function values and derivatives)
    for i in 1:n
        z[2*i-1] = x[i]
        z[2*i] = x[i]
        Q[2*i-1, 1] = y[i]
        Q[2*i, 1] = y[i]
        Q[2*i, 2] = dy[i]  # Use derivative when points are repeated
        if i > 1
            Q[2*i-1, 2] = (Q[2*i-1, 1] - Q[2*i-2, 1]) / (z[2*i-1] - z[2*i-2])
        end
    end

    # Calculate higher order divided differences
    for j in 3:2*n
        for i in j:2*n
            Q[i, j] = (Q[i, j-1] - Q[i-1, j-1]) / (z[i] - z[i-j+1])
        end
    end

    return z, Q
end

function hermite_interpolation(x, y, dy, x_value)
    z, Q = divided_differences(x, y, dy)
    n = length(x)

    # Initialize the polynomial result with Q[1,1]
    result = Q[1, 1]
    product_term = 1.0

    # Construct the polynomial based on the divided differences
    for i in 2:2*n
        product_term *= (x_value - z[i-1])
        result += Q[i, i] * product_term
    end

    return result
end

function main()
    println("Enter the number of points: ")
    n = parse(Int, readline())  # Number of interpolation points
    
    x = zeros(n)  
    y = zeros(n)  
    dy = zeros(n) 

    println("Enter the function f(x) (e.g. x^2, sin(x), etc.): ")
    f_input = readline()
    f = eval(Meta.parse("x -> $f_input"))

    println("Enter the derivative f'(x) (e.g. 2x, cos(x), etc.): ")
    df_input = readline()
    df = eval(Meta.parse("x -> $df_input"))

    for i in 1:n
        println("Enter x[$i]: ")
        x[i] = parse(Float64, readline())
        y[i] = Base.invokelatest(f, x[i])   # Use invokelatest for the function
        dy[i] = Base.invokelatest(df, x[i]) # Use invokelatest for the derivative
    end

    println("Enter the x value where you want to interpolate: ")
    x_value = parse(Float64, readline())

    interp_value = hermite_interpolation(x, y, dy, x_value)
    println("Hermite interpolating polynomial at x = $x_value: $interp_value")
end

main()