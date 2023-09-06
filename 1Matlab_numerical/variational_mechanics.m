% Define the potential energy function
V = @(x) 0.5*x.^2;

% Define the time interval
tspan = [0, 10];

% Define the initial position and velocity
x0 = 1;
v0 = 0;

% Define the Lagrangian function
L = @(x,v) 0.5*m*v.^2 - V(x);

% Define the equations of motion
f = @(t,x) [x(2); -dVdx(x(1))/m];

% Solve the equations of motion
[t,x] = ode45(f, tspan, [x0, v0]);

% Plot the position of the particle
plot(t, x(:,1))
xlabel('Time')
ylabel('Position')
title('Motion of a Particle under the Influence of a Potential')