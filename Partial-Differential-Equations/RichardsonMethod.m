% Test problem: 
% 1-D heat equation for a 1m rod: du/dt = alpha * d^2u/dx^2
% 0 < x < 1, h(dx) = 0.2, 0 < t < 0.6, k(dt) = 0.2
tic
L = 1-0; % length of rod
T = 0.06-0; % total time
alpha = 1; % diffusivity constant 
dx = 0.2; % spatial step
dt = 0.02; % time step 
d = (alpha*dt)/(dx^2); % convergence constant

N = L/dx +1; % spatial nodes
M = floorDiv(T,dt) +1; % time nodes
x = zeros(N,1);
t = zeros(M,1);

for i = 1:N 
    x(i) = 0 + (i-1)*dx; 
end 
for n = 1:M 
    t(n) = 0 + (n-1)*dt; 
end

U = zeros(M, N); % initializing given boundary and initial conditions
U(:,1) = 0; 
U(:,N) = 0; 
U(1,2:N-1) = sin(pi*x(2:N-1));

for i = 2:N-1
    U(2,i) = d*U(1,i+1) + (1-2*d)*U(1,i) + d*U(1,i-1); %FTCS method used to find needed initial conditions.
end 
for n = 2:M-1
    fprintf('   t     x    U\n')
    for i = 2:N-1
        U(n+1,i) = U(n-1,i) + 2*d*(U(n,i+1) + 2*U(n,i) + U(n,i-1));
        fprintf('%.4f   %.4f    %.4f\n', t(n+1), x(i), U(n+1,i))
    end 
end 
U 

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