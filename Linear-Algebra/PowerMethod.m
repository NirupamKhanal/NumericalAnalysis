A = input('Enter matrix A: ');
v = input('Enter normalized initial guess vector: ');
n = input('Enter number of iterations: '); 
e = input('Enter tolerance: '); 
v0 = v 

for i = 1:n 
    v = A*v0; 
    M = max(v);
    v = v/M; 
    if abs(v-v0) < e
        break 
    end 
    v0 = v; 
    fprintf('Iteration no.: %d\n', i)
    fprintf('Current eigenvalue is: %.4f\n', M)
    fprintf('Current eigenvector is: ')
    v 
end 