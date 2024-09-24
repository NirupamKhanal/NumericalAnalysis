import numpy as np 
import matplotlib.pyplot as plt 
from scipy.interpolate import interp1d, CubicSpline

x = np.array([1, 6, 7, 9, 12, 20])
y = np.array([2, 8, 6, 10, 14, 41])

x_int = np.linspace(np.min(x), np.max(x), 50)

#1D Linear Spline Interpolation
y_lin = interp1d(x, y)
print(y_lin(3))

#1D Quadratic Spline Interpolation
y_quad = interp1d(x, y, kind="quadratic")
print(y_quad(3))

#1D Cubic Spline Interpolation
y_cub = interp1d(x, y, kind="cubic")
print(y_cub(3))

#1D Cubic Spline Interpolation with BC
y_cubBC = CubicSpline(x, y, bc_type="natural")

plt.plot(x, y, "o", label="Data Points")
plt.plot(x_int, y_lin(x_int), "red", label="Linear Spline Interpolation")
plt.plot(x_int, y_quad(x_int), "green", label="Quadratic Spline Interpolation")
plt.plot(x_int, y_cub(x_int), "pink", label="Cubic Spline Interpolation")
plt.plot(x_int, y_cubBC(x_int), "blue", label="Cubic Spline Interpolation with BC")
plt.legend()
plt.show()