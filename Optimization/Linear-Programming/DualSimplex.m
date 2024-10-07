% Dual Simplex Method in MATLAB

% Step 1: Input Data
n = input('Enter the number of variables: '); 
c = input('Enter the coefficients of the objective function: '); 
t = input('Enter the constraints matrix: '); 
b = input('Enter resultant vector (ensure at least one b < 0 for dual simplex): '); 

% Step 2: Setup Slack Variables and Augmented Matrix
s = eye(size(t, 1)); 
A = [t s b]; 

% Step 3: Initialize Cost Row and Basic Variables
cost = zeros(1, size(A, 2)); 
cost(1:n) = c; 

% Initialize Basic Variables (BV) - initially set to slack variables
BV = n+1:1:size(A,2)-1; 

% Calculate initial Zj - Cj row (cost differences)
ZjCj = cost(BV) * A - cost;
ZCj = [ZjCj; A]; 
grid = array2table(ZCj);

disp('Initial Tableau:');
disp(grid);

run = true;
iteration = 0; 
max_iterations = 1000;  % Set a maximum number of iterations to avoid infinite loop

% Step 4: Dual Simplex Iteration Process
while run && iteration < max_iterations  % Add an iteration limit to avoid infinite loops
    % Check for negative values in solution column (b)
    if any(A(:, end) < 0)  
        iteration = iteration + 1;
        fprintf('\n\n ========== Iteration No: %d ========== \n', iteration)

        disp('Current Basic Variables = ');
        disp(BV);

        % Step 5: Find the leaving variable (most negative value in b)
        [minValue, pvt_row] = min(A(:, end));  % Pivot row: most negative value in b
        fprintf('Most negative value in the solution column is %f in row %d\n', minValue, pvt_row);
        fprintf('Leaving variable is %d\n', BV(pvt_row));

        % Step 6: Calculate ratios and find the entering variable
        ZjCj = cost(BV) * A - cost;  % Update Zj - Cj row after each iteration
        row = A(pvt_row, 1:end-1);   % Select pivot row for analysis (without the b column)
        ZjCjRow = ZjCj(1:end-1);  % Zj-Cj excluding the b column

        ratios = [];
        for i = 1:length(ZjCjRow)
            if row(i) < 0  % Dual condition: only consider negative elements in the pivot row
                ratios(i) = abs(ZjCjRow(i) / row(i));
            else
                ratios(i) = inf;  % Ignore non-negative elements
            end
        end

        if all(isinf(ratios))  % If all ratios are infinite, no feasible solution exists
            error('The linear programming problem is infeasible.');
        end

        [minRatio, pvt_col] = min(ratios);  % The entering variable corresponds to the smallest ratio
        fprintf('Minimum ratio is %f, so the entering variable is %d\n', minRatio, pvt_col);

        % Step 7: Update Basic Variables (BV)
        BV(pvt_row) = pvt_col; 
        disp('New Basic Variables = ');
        disp(BV);

        % Step 8: Perform Gaussian elimination to update the tableau
        pvt_key = A(pvt_row, pvt_col); 
        A(pvt_row,:) = A(pvt_row,:)./pvt_key; % Divide the pivot row by the pivot key

        for i = 1:size(A,1)
            if i ~= pvt_row
                A(i,:) = A(i,:) - A(i, pvt_col).*A(pvt_row, :); 
            end
        end
        
        % Step 9: Update Zj-Cj row after pivoting
        ZjCj = cost(BV) * A - cost;
        ZCj = [ZjCj; A];
        grid = array2table(ZCj);
        disp('Updated Tableau:');
        disp(grid);

    else
        run = false;
        fprintf('All values in the solution column are >= 0.\n');
        fprintf('The current BFS is optimal.\n');
    end
end

% Step 10: Ensure loop breaks after maximum iterations
if iteration >= max_iterations
    fprintf('Reached the maximum number of iterations (%d). Stopping the process.\n', max_iterations);
end

% Step 11: Display the optimal solution
fprintf('\nThe optimal solution is:\n');
for i = 1:n
    if ismember(i, BV)
        fprintf('x%d = %f\n', i, A(BV == i, end));
    else
        fprintf('x%d = 0\n', i);
    end
end

% Step 12: Calculate and display the optimal value of the objective function Z
optimal_value = cost(BV) * A(:, end);
fprintf('The optimal value of the objective function Z = %f\n', optimal_value(end));