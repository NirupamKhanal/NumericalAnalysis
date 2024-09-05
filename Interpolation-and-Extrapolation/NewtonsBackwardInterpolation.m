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
    B = zeros(n,n)
    B(:,1) = Y; 
    for j = 2:n 
        for i = 1:(n-j+1) 
            B(i,j) = B(i+1, j-1) - B(i, j-1); 
        end
    end
    B
    C = B(1, n); 
    for k = n-1:-1:1
        p = poly(X(n))/h;
        p(2) = p(2) + (k-1); 
        p
        C = conv(C, p)/k
        m = length(C);
        C(m) = C(m) + B(n-k+1, k); 
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
