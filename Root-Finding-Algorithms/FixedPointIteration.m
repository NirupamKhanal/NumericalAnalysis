g = input('Enter your function: '); 
x0 = input('Enter initial guess: ');
e = input('Enter tolerance: '); 
n = input('Enter the number of desired iterations: '); 

for i = 1:n 
    x1 = g(x0);
    fprintf('x%d = %.4f\n', i, x1) %change.()f as per requirements
    if abs(x1-x0) < e 
        break
    end 
    x0 = x1;
end;