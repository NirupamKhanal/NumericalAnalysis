n = input('Enter the number of variables: '); 
c = input('Enter the coefficients of the objective functions: '); 
t = input('Enter slack variables as a matrix: ');
b = input('Enter resultant vector: '); 

s = eye(size(t, 1)); 
A = [t s b]; 

cost = zeros(1, size(A, 2)); 
cost(1:n) = c; 

BV = n+1:1:size(A,2)-1; 
ZjCj = cost(BV)*A - cost;

ZCj = [ZjCj ; A]; 
grid = array2table(ZCj)

run = true;
iteration = 0; 
while run 
    if any(ZjCj < 0)
        iteration = iteration + 1;
        fprintf('       The current BFS is not optimal.     ')
        fprintf('\n ========== Iteration No: %d ========== \n', iteration)

        disp('Old Basic Variables = ')
        disp(BV);

        ZC = ZjCj(1:end-1); 
        [EnterCol, pvt_col] = min(ZC)
        fprintf('The minimum element in Zj-Cj row is %d corresponding to column %d\n', EnterCol, pvt_col);
        fprintf('Entering variable is %d\n', pvt_col);

        sol = A(:,end); 
        column = A(:,pvt_col);

        if all(column <= 0)
            error('LPP is unbounded! All entries <= 0 in column %d\n', pvt_col); 
        else 
            for i = 1:size(column, 1)
                if column(i) > 0
                    ratio(i) = sol(i)./column(i);
                else 
                    ratio(i) = inf;
                end 
            end 

            [minRatio, pvt_row] = min(ratio); 
            fprintf('Minimum ratio corresponding to pivot row is %d\n', pvt_row);
            fprintf('Leaving variable is %d\n', BV(pvt_row));
        end 

        BV(pvt_row) = pvt_col; 
        disp('New basic variable = ');
        disp(BV);

        pvt_key = A(pvt_row, pvt_col); 
        A(pvt_row,:) = A(pvt_row,:)./pvt_key;

        for i = 1:size(A,1)
            if i ~= pvt_row
                A(i,:) = A(i,:) - A(i, pvt_col).*A(pvt_row, :); 
            end 
            ZjCj = ZjCj - ZjCj(pvt_col).*A(pvt_row, :);
            ZCj = [ZjCj ; A]; 
            grid = array2table(ZCj)
        end 
    else 
        run = false; 
        fprintf('The current BFS is optimal.\n'); 
    end 
end 
