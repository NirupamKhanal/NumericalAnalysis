X = input('Enter list of abscissas: '); 
Y = input('Enter list of ordinates: ');
p0 = input('Enter point of approximation: '); 
n = length(X);
h = X(2) - X(1);
count = 0; 
for a = 2:n-1
    b = X(a+1) - X(a);
    if b ~= h 
        count += count; 
    end 
end
if count == 0
    disp('Data is uniformly spaced.')
    F = zeros(n,n)
    F(:,1) = Y; 
    for j = 2:n 
        for i = j:n 
            F(i,j) = F(i, j-1) - F(i-1, j-1); 
        end
    end
    F 
    C = F(n, n); 
    for k = n-1:-1:1
        p = poly(X(1))/h;
        p(2) = p(2) - (k-1); 
        C = conv(C, p)/k;
        m = length(C);
        C(m) = C(m) + F(k, k); 
    end 
    C 
    A = polyval(C, p0);
    
    fprintf('Approximate value at given data point is %.4f.\n', A);
    x = linspace(X(1), X(n), 100);
    y = polyval(C, x); 
    plot(x, y, 'r') 
    hold on
    plot(X, Y, 'o')
else 
    disp('Data is not uniformly spaced. The interpolation may be inaccurate.')
end 
