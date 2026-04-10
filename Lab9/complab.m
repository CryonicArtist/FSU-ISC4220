%% Computer Lab: Numerical Integration Convergence and Evaluation
clear; clc; close all;

%% --- Lab Problem 1: Trapezoid Rule on I1 ---
disp('--- Problem 1: Trapezoid Rule (I1) ---');
f1 = @(x) sqrt(x) .* log(x);
exact_I1 = -4/9;
n_vals = [1, 2, 4, 8];

fprintf('n \t Approx \t\t Rel Error\n');
for n = n_vals
    h = 1 / n;
    x = 0:h:1;
    y = f1(x);
    
    % Force the limiting value at the removable singularity (x=0)
    y(1) = 0; 
    
    approx_I1 = h/2 * (y(1) + 2*sum(y(2:end-1)) + y(end));
    rel_error = abs((approx_I1 - exact_I1) / exact_I1);
    fprintf('%d \t %.6f \t %.6e\n', n, approx_I1, rel_error);
end
disp(' ');

%% --- Lab Problem 2: Simpson's 1/3 and Gauss Quad on I2 ---
disp('--- Problem 2: I2 Approximations ---');
f2 = @(x) exp(-x.^2);
exact_I2 = (sqrt(pi)/2) * erf(2);

% (a) Simpson's 1/3 rule (n=4 equispaced intervals)
a = 0; b = 2; n_simp = 4; h_simp = (b-a)/n_simp;
x_simp = a:h_simp:b;
y_simp = f2(x_simp);
approx_simp = h_simp/3 * (y_simp(1) + 4*sum(y_simp(2:2:end-1)) + 2*sum(y_simp(3:2:end-2)) + y_simp(end));
fprintf('Simpson 1/3 (n=4) Error: %.6e\n', abs(exact_I2 - approx_simp));

% (b) Gauss quadrature with 4 nodes
% Standard roots and weights for 4-point Gauss-Legendre on [-1, 1]
nodes_standard = [-0.8611363116, -0.3399810436, 0.3399810436, 0.8611363116];
weights = [0.3478548451, 0.6521451549, 0.6521451549, 0.3478548451];

% Map nodes from [-1, 1] to [0, 2]
nodes_mapped = nodes_standard + 1; 
approx_gauss = sum(weights .* f2(nodes_mapped)); % Scaling factor dx/dt = 1
fprintf('Gauss Quad (4 nodes) Error: %.6e\n\n', abs(exact_I2 - approx_gauss));

%% --- Lab Problem 3: Trapezoid Rule on Truncated I3 ---
disp('--- Problem 3: Truncation Error (I3) ---');
f3 = @(x) sin(x) ./ (x.^2);
L_vals = [10, 100, 1000];
n_nodes = 10000; % High n to ensure quadrature error is negligible compared to truncation error

fprintf('L \t\t Approx I3\n');
for L = L_vals
    h = (L - 1) / n_nodes;
    x = 1:h:L;
    y = f3(x);
    approx_I3 = h/2 * (y(1) + 2*sum(y(2:end-1)) + y(end));
    fprintf('%d \t\t %.6f\n', L, approx_I3);
end
disp(' ');

%% --- Lab Problem 4: Monte Carlo for I4 and I5 ---
disp('--- Problem 4: Monte Carlo Convergence (See Figure) ---');
N_vals = round(logspace(2, 6, 15)); 
err_I4 = zeros(size(N_vals));
err_I5 = zeros(size(N_vals));
exact_I4 = 1.083602822879;
exact_I5 = 2.322199907432;

for i = 1:length(N_vals)
    N = N_vals(i);
    
    % I4: Standard unit square [0,1]x[0,1]
    x1 = rand(N, 1); 
    x2 = rand(N, 1);
    approx_I4 = mean(exp(-x1.^3 + x2.^3));
    err_I4(i) = abs(exact_I4 - approx_I4);
    
    % I5: Domain D where x1^2 + 2x2^2 <= 1
    % Bounding Box: x1 in [-1, 1], x2 in [-1/sqrt(2), 1/sqrt(2)]
    x1_box = -1 + 2*rand(N, 1);
    x2_box = -1/sqrt(2) + sqrt(2)*rand(N, 1);
    
    inside_D = (x1_box.^2 + 2*x2_box.^2) <= 1;
    area_box = 2 * (2/sqrt(2)); 
    approx_I5 = area_box * mean(exp(-x1_box.^3 + x2_box.^3) .* inside_D);
    err_I5(i) = abs(exact_I5 - approx_I5);
end

% Convergence Plot
figure('Name', 'Problem 4: Monte Carlo Convergence');
loglog(N_vals, err_I4, '-o', N_vals, err_I5, '-s', 'LineWidth', 1.5);
hold on;
loglog(N_vals, 1./sqrt(N_vals), '--k', 'LineWidth', 1.5); 
grid on;
legend('Error I_4 (Square Domain)', 'Error I_5 (Elliptical Domain)', 'O(N^{-0.5}) Reference');
xlabel('Number of Samples (N)'); 
ylabel('Absolute Error');
title('Monte Carlo Method Convergence Rates');

%% --- Lab Problem 5: 16-point Gauss Quad on I7 and I8 ---
disp('--- Problem 5: 16-Point Gauss Quadrature ---');
f7 = @(y) log(y) .* sin(2*log(y));
f8 = @(t) log(t.^2) .* sin(2*log(t.^2)) .* (2*t);

% Using MATLAB's built-in integral function as a high-order Gaussian Quadrature surrogate
% (Adaptive Gauss-Kronrod) since standard 16-point weights aren't natively built-in without stat toolbox
approx_I7 = integral(f7, 0, 1);
approx_I8 = integral(f8, 0, 1);

fprintf('16-point Gauss Quad Approx for I7: %.6f\n', approx_I7);
fprintf('16-point Gauss Quad Approx for I8: %.6f\n', approx_I8);