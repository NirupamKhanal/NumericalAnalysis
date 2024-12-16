'''
Numerical solution for the 2-dimensional incompressible Navier Stokes Equations in a lid-driven cavity scenario
using Finite Differences, explicit timestepping, and Chorin's Projections. 

Momentum equations: ∂u/∂t + (u ⋅ ∇) u = − 1/ρ ∇p + ν ∇²u + f

Imcompressibility: ∇ ⋅ u = 0

u: velocity (2d)
p: pressure
f: forcing (f = 0)
ν: kinetic viscosity 
ρ: density
t: time
∇: Nabla operator (gradient, divergence, curl)
∇²: Laplacian

Conditions: 
* Initial Conditions are zero. 
* Homogenous Dirichlet Boundary Conditions, except horizontal velocity on top, driven by external flow. 
* Pressure Boundary Conditions: Homogenous Neumann Boundary except for the top, where it follows 
homogenous Dirichlet Boundary Conditions. 
'''

import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm

n_points = 41
domain_size = 1.0
n_iters = 500 
time_step = 0.001
kinematic_viscosity = 0.1
density = 1.0
velocity_horizontal_top = 1.0
n_pressure_iters = 50
stability_safety_factor = 0.5

def main():
    element_length = domain_size / (n_points - 1)
    x = np.linspace(0.0, domain_size, n_points)
    y = np.linspace(0.0, domain_size, n_points)

    X, Y = np.meshgrid(x, y)

    u_prev = np.zeros_like(X)
    v_prev = np.zeros_like(X)
    p_prev = np.zeros_like(X)

    def central_difference_x(f):
        diff = np.zeros_like(f)
        diff[1:-1, 1:-1] = (f[1:-1, 2:] - f[1:-1, 0:-2]) / (2*element_length)

        return diff

    def central_difference_y(f):
        diff = np.zeros_like(f)
        diff[1:-1, 1:-1] = (f[2: , 1:-1] - f[0:-2, 1:-1]) / (2*element_length)

        return diff

    def laplacian(f): 
        diff = np.zeros_like(f)
        diff[1:-1, 1:-1] = (f[1:-1, 0:-2] + f[0:-2, 1:-1] - 4*f[1:-1, 1:-1] + f[2: , 1:-1] + f[1:-1, 2: ]) / (element_length**2)

        return diff

    max_time_step = (0.5*element_length**2 / kinematic_viscosity)
    if time_step > stability_safety_factor * max_time_step: 
        raise RuntimeError("Stability is not guaranteed!")

    for _ in tqdm(range(n_iters)): 
        du_prev_dx = central_difference_x(u_prev)
        du_prev_dy = central_difference_y(u_prev)
        dv_prev_dx = central_difference_x(v_prev)
        dv_prev_dy = central_difference_y(v_prev)
        del2_u_prev = laplacian(u_prev)
        del2_v_prev = laplacian(v_prev)

        # Tentative step: Advection-diffusion for provisional velocities
        u_tent = (u_prev + time_step*(u_prev*du_prev_dx + v_prev*du_prev_dy) + kinematic_viscosity * del2_u_prev)
        v_tent = (v_prev + time_step*(u_prev*dv_prev_dx + v_prev*dv_prev_dy) + kinematic_viscosity * del2_v_prev)

        # Initializing Boundary Conditions
        u_tent[0, :] = 0.0
        u_tent[:, 0] = 0.0
        u_tent[:, -1] = 0.0
        u_tent[-1, :] = velocity_horizontal_top
        v_tent[0, :] = 0.0
        v_tent[:, 0] = 0.0
        v_tent[:, -1] = 0.0
        v_tent[-1, :] = 0.0

        du_tent_dx = central_difference_x(u_tent)
        dv_tent_dy = central_difference_y(v_tent)

        # Pressure correction: pressure-Poisson equation 
        rhs = (density / time_step * (du_tent_dx + dv_tent_dy))

        for _ in range(n_pressure_iters): 
            p_next = np.zeros_like(p_prev)
            p_next[1:-1, 1:-1] = 1/4 * (+ p_prev[1:-1, 0:-2] + p_prev[0:-2, 1:-1] + p_prev[1:-1, 2: ] + p_prev[2: , 1:-1] - element_length**2 * rhs[1:-1, 1:-1])

            # Initializing Pressure Boundary Conditions
            p_next[:, -1] = p_next[:, -2]
            p_next[0, :] = p_next[1, :]
            p_next[:, 0] = p_next[:, 1]
            p_next[-1, :] = 0.0

            p_prev = p_next

        dp_next_dx = central_difference_x(p_next)
        dp_next_dy = central_difference_y(p_next)

        # Correct the velocities such that the fluid stays incompressible: 
        u_next = (u_tent - time_step / density * dp_next_dx)
        v_next = (v_tent - time_step / density * dp_next_dy)

        u_next[0, :] = 0.0
        u_next[:, 0] = 0.0
        u_next[:, -1] = 0.0
        u_next[-1, :] = velocity_horizontal_top
        v_next[0, :] = 0.0
        v_next[:, 0] = 0.0
        v_next[:, -1] = 0.0
        v_next[-1, :] = 0.0

        # Advance in time: 
        u_prev = u_next
        v_prev = v_next
        p_prev = p_next

    plt.figure(1)
    plt.contourf(X[::2, ::2], Y[::2, ::2], p_next[::2, ::2], cmap="coolwarm")
    plt.colorbar()
    plt.quiver(X[::2, ::2], Y[::2, ::2], u_next[::2, ::2], v_next[::2, ::2], color='b')
    plt.xlim((0,1))
    plt.ylim((0,1))
    plt.show()
    
if __name__ == "__main__":
    main()
