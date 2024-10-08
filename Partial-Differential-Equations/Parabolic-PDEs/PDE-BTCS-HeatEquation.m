% Test problem: 
% 1-D heat equation for a 1m rod: du/dt = alpha * d^2u/dx^2
% 0 < x < 1, h(dx) = 0.2, 0 < t < 0.02, k(dt) = 0.01
tic
L = 1-0; % length of rod
T = 0.02-0; % total time
alpha = 1; % diffusivity constant 
dx = 0.1; % spatial step
dt = 0.01; % time step 
d = (alpha*dt)/(dx^2); % convergence constant

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
U(:,1) = 0; 
U(:,N) = 0; 
U(1,2:N-1) = sin(pi*x(2:N-1));

A = zeros(N-2, N-2); 
B = zeros(N-2, 1);
A(1,1) = -(1+2*d); 
A(1,2) = d; 
A(N-2,N-3) = d; 
A(N-2,N-2) = -(1+2*d);

for i = 2:N-3
    A(i,i-1) = d; 
    A(i,i) = -(1+2*d); 
    A(i,i+1) = d; 
end 

for n = 1:M-1
    B(1) = -(U(n,2)+U(n+1,1));
    B(N-2) = -(U(n,N-1)+U(n+1,N));
    for i = 2:N-3
        B(i) = -U(n,i+1); 
    end 
    W = A\B;
    U(n+1,2:N-1) = W; 
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
