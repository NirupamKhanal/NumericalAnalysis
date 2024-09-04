import numpy as np
import matplotlib.pyplot as plt

def euler_method(y_prime, y0, t0, tn, h):
    """
    Implement Euler's method for solving a first-order ODE.

    Parameters:
    - y_prime: The derivative function dy/dt.
    - y0: Initial value of y.
    - t0: Initial value of t.
    - tn: Final value of t.
    - h: Step size.

    Returns:
    - t_values: List of t values.
    - y_values: List of corresponding y values.
    """
    t_values = [t0]
    y_values = [y0]

    while t_values[-1] < tn:
        t_next = t_values[-1] + h
        y_next = y_values[-1] + h * y_prime(y_values[-1], t_values[-1])
        t_values.append(t_next)
        y_values.append(y_next)

    return t_values, y_values

# Get user input
equation_str = input("Enter the ODE in the form of y' = f(y, t): ")
y_prime = lambda y, t: eval(equation_str)
y0 = float(input("Enter the initial value of y (y0): "))
t0 = float(input("Enter the initial value of t (t0): "))
tn = float(input("Enter the final value of t (tn): "))
h = float(input("Enter the step size (h): "))

# Perform Euler's method
t_values, y_values = euler_method(y_prime, y0, t0, tn, h)

# Display results
print("\nResults:")
for t, y in zip(t_values, y_values):
    print(f"t = {t:.4f}, y = {y:.4f}")
    
# Plotting the results
plt.plot(t_values, y_values, label="Euler's Method")
plt.title("Euler's Method for y' = -y")
plt.xlabel("t")
plt.ylabel("y(t)")
plt.legend()
plt.show()
