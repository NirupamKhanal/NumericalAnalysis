function [u, v, X, Y] = NavierStokes_LocalRBF(N, dt, Re, T)
    % Solves 2D Navier-Stokes equations using fractional step method with local RBF
    % N: number of grid points
    % dt: time step size
    % Re: Reynolds number
    % T: total time for the simulation
    
    % Domain initialization
    L = 1; % Length of the domain (assuming square domain)
    [X, Y] = meshgrid(linspace(0, L, N), linspace(0, L, N));
    dx = L / (N - 1); % Grid spacing

    % Initialize velocity (u, v) and pressure (p) fields
    u = zeros(N, N);
    v = zeros(N, N);
    p = zeros(N, N);
    
    % Boundary Conditions (for lid-driven cavity flow)
    u(:, end) = 1; % Top boundary moves with velocity 1 (lid-driven)
    
    % Time stepping loop
    for t = 0:dt:T
        % Step 1: Compute intermediate velocity u_star (advection-diffusion equation)
        u_star = u + dt * ((1/Re) * Laplacian(u, dx) - Advection(u, v, dx)); 
        v_star = v + dt * ((1/Re) * Laplacian(v, dx) - Advection(v, u, dx)); 
        
        % Update boundary conditions for intermediate velocity u_star, v_star
        u_star(:, end) = 1;
        u_star(1,:) = 0; u_star(end,:) = 0; u_star(:,1) = 0;
        v_star(1,:) = 0; v_star(end,:) = 0; v_star(:,1) = 0; v_star(:,end) = 0;
        
        % Step 2: Solve pressure Poisson equation ∇²p = (∇·u*) / dt
        div_u_star = Divergence(u_star, v_star, dx);
        p_new = SolvePoisson(p, div_u_star/dt, dx);
        
        % Step 3: Correct velocity field with pressure gradient
        u = u_star - dt * GradientX(p_new, dx);
        v = v_star - dt * GradientY(p_new, dx);
        
        % Enforce velocity boundary conditions after correction
        u(:, end) = 1; % Lid boundary condition
        u(1,:) = 0; u(end,:) = 0; u(:,1) = 0;
        v(1,:) = 0; v(end,:) = 0; v(:,1) = 0; v(:,end) = 0;
        
        % Update pressure
        p = p_new;
        
        % Visualize the flow field at each time step
        % if mod(t, 0.1) == 0
        %     clf;
        %     quiver(X, Y, u, v);
        %     title(['Flow field at time t = ', num2str(t)]);
        %     drawnow;
        % end
    end
end

% Helper functions for numerical operations

% Laplacian operator
function L = Laplacian(f, dx)
    L = (circshift(f, [0, -1]) + circshift(f, [0, 1]) + ...
        circshift(f, [-1, 0]) + circshift(f, [1, 0]) - 4*f) / dx^2;
end

% Advection term
function A = Advection(f1, f2, dx)
    A = (f1 .* GradientX(f1, dx) + f2 .* GradientY(f1, dx));
end

% Gradient in x direction
function Gx = GradientX(f, dx)
    Gx = (circshift(f, [0, -1]) - circshift(f, [0, 1])) / (2 * dx);
end

% Gradient in y direction
function Gy = GradientY(f, dx)
    Gy = (circshift(f, [-1, 0]) - circshift(f, [1, 0])) / (2 * dx);
end

% Divergence operator
function div = Divergence(u, v, dx)
    div = (circshift(u, [0, -1]) - circshift(u, [0, 1])) / (2 * dx) + ...
          (circshift(v, [-1, 0]) - circshift(v, [1, 0])) / (2 * dx);
end

% Solve Poisson equation for pressure
function p_new = SolvePoisson(p, b, dx)
    % Using Gauss-Seidel iterative method for simplicity
    tol = 1e-6;
    maxIter = 5000;
    iter = 0;
    p_new = p;
    while iter < maxIter
        p_old = p_new;
        p_new(2:end-1, 2:end-1) = 0.25 * (p_old(2:end-1, 1:end-2) + p_old(2:end-1, 3:end) + ...
                                        p_old(1:end-2, 2:end-1) + p_old(3:end, 2:end-1) - ...
                                           dx^2 * b(2:end-1, 2:end-1));
        if max(max(abs(p_new - p_old))) < tol
            break;
        end
        iter = iter + 1;
    end
end

function plotLidDrivenFlowStreamlines()
    % Parameters for simulation
    N = 50; % Number of grid points
    dt = 0.01; % Time step size
    T = 10; % Total simulation time

    % Reynolds number 100
    Re1 = 100;
    [u1, v1, X, Y] = NavierStokes_LocalRBF(N, dt, Re1, T);

    % Reynolds number 1000
    Re2 = 1000;
    [u2, v2, X, Y] = NavierStokes_LocalRBF(N, dt, Re2, T);

    % Create the figure and subplots
    figure;
    
    % Subplot 1: Streamlines for Re = 100
    subplot(1, 2, 1);
    streams1 = streamslice(X, Y, u1, v1);
    set(streams1, 'Color', 'b'); % Color the streamlines blue
    hold on;
    quiver(X, Y, u1, v1, 'r'); % Overlay velocity field vectors
    title('Streamlines for Re = 100');
    xlabel('X');
    ylabel('Y');
    axis equal;
    hold off;
    
    % Subplot 2: Streamlines for Re = 1000
    subplot(1, 2, 2);
    streams2 = streamslice(X, Y, u2, v2);
    set(streams2, 'Color', 'b'); % Color the streamlines blue
    hold on;
    quiver(X, Y, u2, v2, 'r'); % Overlay velocity field vectors
    title('Streamlines for Re = 1000');
    xlabel('X');
    ylabel('Y');
    axis equal;
    hold off;
    
    % Adjust layout
    sgtitle('Lid-driven Cavity Flow Streamlines');
end

function plotVelocityProfiles()
    % Parameters for the simulation
    dt = 0.01;  % Time step size
    T = 10;     % Total simulation time

    % Reynolds numbers to compare
    Re_100 = 100;
    Re_1000 = 1000;

    % Different grid sizes
    grid_sizes = [101, 51, 17];

    % Initialize figure
    figure;
    
    % Loop over Reynolds numbers and plot the results for each grid resolution
    for i = 1:length(grid_sizes)
        N = grid_sizes(i);  % Grid size
        
        % Solve for Re = 100
        [u_100, v_100, X, Y] = NavierStokes_LocalRBF(N, dt, Re_100, T);
        
        % Solve for Re = 1000
        [u_1000, v_1000, X, Y] = NavierStokes_LocalRBF(N, dt, Re_1000, T);
        
        % Extract u-velocity along vertical line x = 0.5
        x_index = find(abs(X(1,:) - 0.5) < 1e-6);  % Find the index for x = 0.5
        u_profile_100 = u_100(:, x_index);         % u-velocity profile for Re=100
        u_profile_1000 = u_1000(:, x_index);       % u-velocity profile for Re=1000
        y_profile = Y(:,1);                        % y values (same for both cases)
        
        % Extract v-velocity along horizontal line y = 0.5
        y_index = find(abs(Y(:,1) - 0.5) < 1e-6);  % Find the index for y = 0.5
        v_profile_100 = v_100(y_index, :);         % v-velocity profile for Re=100
        v_profile_1000 = v_1000(y_index, :);       % v-velocity profile for Re=1000
        x_profile = X(1,:);                        % x values (same for both cases)

        % Plot u-velocity for Re = 100
        subplot(2, 2, 1);
        plot(y_profile, u_profile_100, 'DisplayName', sprintf('LMAPS, Re=100, %dx%d', N, N));
        hold on;
        title('u-velocity (Re=100)');
        xlabel('Y');
        ylabel('U-velocity');
        legend show;

        % Plot v-velocity for Re = 100
        subplot(2, 2, 2);
        plot(x_profile, v_profile_100, 'DisplayName', sprintf('LMAPS, Re=100, %dx%d', N, N));
        hold on;
        title('v-velocity (Re=100)');
        xlabel('X');
        ylabel('V-velocity');
        legend show;
        
        % Plot u-velocity for Re = 1000
        subplot(2, 2, 3);
        plot(y_profile, u_profile_1000, 'DisplayName', sprintf('LMAPS, Re=1000, %dx%d', N, N));
        hold on;
        title('u-velocity (Re=1000)');
        xlabel('Y');
        ylabel('U-velocity');
        legend show;

        % Plot v-velocity for Re = 1000
        subplot(2, 2, 4);
        plot(x_profile, v_profile_1000, 'DisplayName', sprintf('LMAPS, Re=1000, %dx%d', N, N));
        hold on;
        title('v-velocity (Re=1000)');
        xlabel('X');
        ylabel('V-velocity');
        legend show;
    end

    % Add a super title to the figure
    sgtitle('u-velocity and v-velocity at centerlines for different Re and grid sizes');
end

NavierStokes_LocalRBF(64, 0.01, 100, 5);
plotLidDrivenFlowStreamlines();
plotVelocityProfiles();
