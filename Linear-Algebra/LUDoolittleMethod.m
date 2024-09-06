A = input('Enter your coefficient matrix: '); 
B = input('Enter your source vector: '); 
N = length(A); 
L = zeros(N, N); 
U = zeros(N, N); 
for a = 1:N 
    L(a, a) = 1;
end 
U(1,:) = A(1,:); 
L(:,1) = A(:,1)/U(1,1); 
for i = 2:N 
    for j = i:N
        U(i,j) = A(i,j) - L(i,1:i-1)*U(1:i-1,j)
    end 
    for k = i+1:N 
        L(k,i) = (A(k,i) - L(k,1:i-1)*U(1:i-1,i))/U(i,i)
    end
end 
L, U
Y = zeros(N,1); 
Y(1) = B(1)/L(1,1); 
for k = 2:N 
    Y(k) = (B(k) - L(k,1:k-1)*Y(1:k-1)) / L(k,k)
end 
Y 
X = zeros(N,1);
X(N) = Y(N) / U(N,N); 
for k = N-1:-1:1
    X(k) = (Y(k) - U(k,k+1:N)*X(k+1:N)) / U(k,k)
end 
X