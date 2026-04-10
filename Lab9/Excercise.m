%% Written Exercise 5: Singularity Removal Visualization
clear; clc; close all;

disp('Generating plots for Exercise 5...');

% Define the integrands
% I7: Integrand with singularity at y=0
f7 = @(y) log(y) .* sin(2*log(y)); 

% I8: Transformed integrand (singularity removed)
f8 = @(t) log(t.^2) .* sin(2*log(t.^2)) .* (2*t);

% Setup domains
% Use a small offset for y to avoid evaluating log(0) which goes to -inf
y_vals = linspace(0.0001, 1, 2000); 
t_vals = linspace(0, 1, 2000);

% Create Figure
figure('Name', 'Exercise 5: Singularity Removal', 'Position', [100, 100, 900, 400]);

% Plot equation (2)
subplot(1, 2, 1);
plot(y_vals, f7(y_vals), 'r', 'LineWidth', 1.5);
title('Equation 2: I_7 Integrand');
xlabel('y'); 
ylabel('f(y)');
grid on;
subtitle('Notice the high frequency oscillation and unbounded amplitude near y=0');

% Plot equation (3)
subplot(1, 2, 2);
plot(t_vals, f8(t_vals), 'b', 'LineWidth', 1.5);
title('Equation 3: I_8 Integrand');
xlabel('t'); 
ylabel('f(t)');
grid on;
subtitle('Singularity removed by t^2 substitution (f(0) approaches 0)');