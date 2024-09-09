% Test problem: 
% 1-D heat equation for a 1m rod: du/dt = alpha * d^2u/dx^2
% 0 < x < 0.04, h(dx) = 0.001, 0 < t < 1.08, k(dt) = 0.01, alpha = 0.000217
tic
L = 0.04-0; % length of rod
T = 1.08-0; % total time
alpha = 0.000217; % diffusivity constant 
dx = 0.001; % spatial step
dt = 0.01; % time step 
d = (alpha*dt)/(2*dx^2); % convergence constant

N = round(L/dx +1); % spatial nodes
M = round(T/dt +1); % time nodes
x = zeros(N,1);
t = zeros(M,1);

for i = 1:N 
    x(i) = 0 + (i-1)*dx; 
end 
for n = 1:M 
    t(n) = 0 + (n-1)*dt; 
end

U = zeros(M, N); % initializing given boundary and initial conditions
U(:,1) = 40; 
U(:,N) = 0; 
U(1,2:N-1) = sin(pi*x(2:N-1));

W = zeros(N-2, 1);
gamma = zeros(N-3,1); 
rho = zeros(N-2,1); 

for n = 1:M-1
    W(1) = (1-2*d)*U(n,2) + d*U(n,3) + d*(U(n,1)+U(n+1,1));
    for i = 2:N-3
        W(i) = d*U(n,i) + (1-2*d)*U(n,i+1) + d*U(n,i+2);
    end 
    W(N-2) = d*U(n,N-2) + (1-2*d)*U(n,N-1) + d*(U(n,N) + U(n+1,N));
    %Z = A\W; % LU decomposition is significantly more efficient here. 
    % Thomas' Algorithm
    rho(1) = W(1)/(1+2*d); 
    gamma(1) = -d/(1+2*d);
    for i = 2:N-3
        rho(i) = (W(i) + d*rho(i-1)) / (1+2*d + d*gamma(i-1)); 
        gamma(i) = (-d) / (1+2*d + d*gamma(i-1));
    end 
    rho(N-2) = (W(N-2) + d*rho(N-3)) / (1+2*d + d*gamma(N-3)); 
    Z(N-2) = rho(N-2); 
    for k = N-3:-1:1
        Z(k) = rho(k) - gamma(k)*Z(k+1); 
    end 
    U(n+1,2:N-1) = Z
end

figure(1)
plot(x,U(M,:))
title('x vs U at t = t_n')
xlabel('x')
ylabel('Temperature')
figure(2)
plot(t,U(:,round(N/2)))
title('t vs U, at x = x_c')
xlabel('Time')
ylabel('Temperature')
toc