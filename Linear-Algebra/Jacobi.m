A = input('Enter a coefficient matrix A: '); 

R = sum(abs(A), 2); 
D = abs(diag(A)); 
W = R-D; 
check = D>=W 
DD = all(check)

if DD == 1
    B = input('Enter a source vector B: '); 
    P = input('Enter an initial guess vector: '); 
    n = input('Enter the no. of iterations: '); 
    e = input('Enter your tolerance: '); 
    N = length(B); 
    X = zeros(N,1); 
    
    for j = 1:n
        for i = 1:N 
            X(i) = (B(i)/A(i,i)) - (A(i, [1:i-1,i+1:N])*P([1:i-1,i+1:N])) / A(i,i)
        end 
        fprintf('Iteration no. %d\n', j)
        X 
        if abs(X-P) < e 
            break 
        end 
        P = X; 
    end 
elseif DD == 0 
    disp('Matrix is not diagonally dominant.')
else 
    disp('Matrix is not a square matrix.')
end 
