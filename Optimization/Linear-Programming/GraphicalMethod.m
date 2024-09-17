% Input the objective function, constraint matrix, and resultant vector
c = input('Enter the coefficients of the objective function: '); 
A = input('Enter constraint matrix (slack variables as matrix A): ');
b = input('Enter constraint values as a vector: ');

% Plotting the graph for all constraints
y1 = 0:100:max(b);

% Get the number of rows (constraints) and columns (variables) in A
[m, n] = size(A); 

if n ~= 2
    error('Graphical method only works for 2-variable problems.');
end

figure(1);
hold on;
% Loop through each constraint and calculate x2 for plotting
for i = 1:m
    if A(i, 2) ~= 0
        x2 = (b(i) - A(i, 1) .* y1) / A(i, 2);
        x2 = max(0, x2);  % Ensure non-negative x2
        plot(y1, x2, 'DisplayName', sprintf('Constraint %d: %.2fx1 + %.2fx2 = %.2f', i, A(i, 1), A(i, 2), b(i)));
    else
        % Vertical line when A(i, 2) == 0
        x1_line = b(i) / A(i, 1);
        line([y1, y1], [0, max(b)], 'DisplayName', sprintf('Constraint %d: x1 = %.2f', i, x1_line));
    end
end 

xlabel('x1');
ylabel('x2');
title('Graph of Constraints');
legend show;
grid on;
hold off;

% Define the objective function direction
z_intercept = 0:0.1:max(b);
x1_obj = (max(b) - c(2) * z_intercept) / c(1); % line for objective function (arbitrary)

% Plot the objective function direction
figure(2);
hold on;
plot(x1_obj, z_intercept, '--r', 'DisplayName', 'Objective Function');
xlabel('x1');
ylabel('x2');
title('Feasible Region and Constraints');
legend('show');

% Plot the feasible region and pass the objective function coefficients
feasible_region(A, b, c);

hold off;

function feasible_region(A, b, c)
    % Function to plot the feasible region and find the max objective function value.

    [m, n] = size(A);
    if n ~= 2
        error('Only works for 2-variable problems.');
    end

    % Compute the corner points of the feasible region
    V = [];
    for i = 1:m
        for j = i+1:m
            % Solve the system of equations for the constraints
            A_sub = A([i, j], :);
            b_sub = b([i, j]);
            
            % Solve if the system is not singular
            if rank(A_sub) == 2
                corner_point = A_sub \ b_sub;
                if all(corner_point >= 0)
                    V = [V; corner_point'];
                end
            end
        end
    end

    % Add intercept points with axes
    for i = 1:m
        if A(i, 1) ~= 0
            V = [V; b(i)/A(i, 1), 0];
        end
        if A(i, 2) ~= 0
            V = [V; 0, b(i)/A(i, 2)];
        end
    end

    % Remove duplicate points
    V = unique(V, 'rows');

    % Print points of intersection
    disp('Points of intersection:');
    disp(V);
    for i = 1:size(V, 1)
        text(V(i, 1), V(i, 2), sprintf('(%0.2f, %0.2f)', V(i, 1), V(i, 2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end

    % Plot the feasible region if we have enough points
    figure(3);
    if size(V, 1) >= 3
        k = convhull(V(:, 1), V(:, 2));
        fill(V(k, 1), V(k, 2), 'g', 'FaceAlpha', 0.3, 'DisplayName', 'Feasible Region');
    end

    % Compute the objective function values at each vertex
    obj_values = V * c(:);
    [max_value, idx_max] = max(obj_values);

    % Display the maximum point and the corresponding values of x1 and x2
    max_point = V(idx_max, :);
    fprintf('The maximum value of the objective function is %.2f at x1 = %.2f, x2 = %.2f\n', max_value, max_point(1), max_point(2));

    % Mark the maximum point on the plot
    plot(max_point(1), max_point(2), 'ro', 'MarkerSize', 10, 'DisplayName', 'Maximum Point');
    text(max_point(1), max_point(2), sprintf('Max (%.2f, %.2f)', max_point(1), max_point(2)), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
end