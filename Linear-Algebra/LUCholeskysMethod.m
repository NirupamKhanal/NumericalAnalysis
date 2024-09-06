A = input('Enter your coefficient matrix: '); 
b = input('Enter your source vector: '); 
N = length(b); 
L = zeros(N, N); 
U = zeros(N, N); 
L(1,1) = sqrt(A(1,1)); 
U(1,1) = L(1,1);
for a = 2:N 
    L(a,1) = A(a,1) / L(1,1);
    U(1,a) = A(1,a) / L(1,1);
end 
for i = 2:N 
    for j = i:N 
        if i == j
            L(j,i) = sqrt(A(j,i) - L(j,1:i-1)*U(1:i-1,i));
            U(j,i) = L(j,i);
        else 
            L(j,i) = (A(j,i) - L(j,1:i-1)*U(1:i-1,i))/L(i,i);
        end 
    end
    for k = i+1:N
        U(i,k) = (A(i,k) - L(i,1:i-1)*U(1:i-1,k))/L(i,i);
    end 
end 
L, U
Y = zeros(N,1); 
Y(1) = B(1)/L(1,1); 
for k = 2:N 
    Y(k) = (B(k) - L(k,1:k-1)*Y(1:k-1)) / L(k,k);
end 
Y 
X = zeros(N,1);
X(N) = Y(N) / U(N,N); 
for k = N-1:-1:1
    X(k) = (Y(k) - U(k,k+1:N)*X(k+1:N)) / U(k,k);
end 
X