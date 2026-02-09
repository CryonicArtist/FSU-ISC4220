%% Newton's Method Analysis Script
% This script implements Newton's method for n-th root finding and compares
% two formulations for finding the root of tan(x) = x near 4.5.
clear; clc; close all;
format long;

%% Part 1: N-th Root Finder
% We solve x^n - A = 0 using Newton's method.
% Update rule: x_{k+1} = x_k - (x_k^n - A) / (n * x_k^(n-1))

disp('--------------------------------------------------');
disp('Part 1: N-th Root Finder Results');
disp('--------------------------------------------------');

% 1a. Calculate cubic root of 3 (n=3, A=3)
n1 = 3; A1 = 3;
x0_1 = 1.5; % Initial guess
root1 = nth_root_newton(n1, A1, x0_1);
fprintf('Cubic root of 3:   %.15f (MATLAB Ref: %.15f)\n', root1, 3^(1/3));

% 1b. Calculate 5th root of 7 (n=5, A=7)
n2 = 5; A2 = 7;
x0_2 = 1.5; % Initial guess
root2 = nth_root_newton(n2, A2, x0_2);
fprintf('5th root of 7:     %.15f (MATLAB Ref: %.15f)\n', root2, 7^(1/5));
fprintf('\n');

%% Part 2: Root of h(x) = tan(x) - x
% Target root near 4.5.
% h'(x) = sec^2(x) - 1 = tan^2(x)
% h''(x) = 2*tan(x)*sec^2(x)

disp('--------------------------------------------------');
disp('Part 2: Solving h(x) = tan(x) - x');
disp('--------------------------------------------------');

% Define functions
h = @(x) tan(x) - x;
dh = @(x) tan(x).^2;
ddh = @(x) 2 * tan(x) .* (sec(x).^2);

% Find exact root for error calculation using fzero (high precision built-in)
x_star = fzero(h, 4.5);
fprintf('Reference Root x*: %.15f\n', x_star);

% Calculate Theoretical Prefactor M = |h''(x*) / 2h'(x*)|
M_h = abs(ddh(x_star) / (2 * dh(x_star)));
fprintf('Theoretical Prefactor M (h(x)): %.15f\n', M_h);

% Run iterations for different starting points
start_points = [4.2, 4.7];
colors = {'b', 'r'};
markers = {'-o', '-s'};

figure('Name', 'Convergence Analysis: h(x) = tan(x) - x');

for i = 1:length(start_points)
    x0 = start_points(i);
    [roots, iters] = newton_solver_history(h, dh, x0, 1e-12, 20);
    
    % Calculate errors
    errors = abs(roots - x_star);
    % Remove zero errors for log plotting
    valid_mask = errors > 0;
    errors = errors(valid_mask);
    iter_indices = 0:(length(errors)-1);
    
    % Calculate Error Ratio: e_{k+1} / e_k^2
    if length(errors) > 1
        ratios = errors(2:end) ./ (errors(1:end-1).^2);
    else
        ratios = [];
    end
    
    % Plot Convergence Error
    subplot(2, 1, 1);
    semilogy(iter_indices, errors, markers{i}, 'DisplayName', sprintf('x_0 = %.1f', x0));
    hold on; grid on;
    title('Convergence Error |x_k - x^*| for h(x)');
    xlabel('Iteration k'); ylabel('Error');
    legend('Location', 'ne');
    
    % Plot Error Ratio
    subplot(2, 1, 2);
    if ~isempty(ratios)
        plot(iter_indices(1:end-1), ratios, markers{i}, 'DisplayName', sprintf('x_0 = %.1f', x0));
    end
    hold on; grid on;
    title('Error Ratio e_{k+1} / e_k^2');
    xlabel('Iteration k'); ylabel('Ratio');
    legend('Location', 'ne');
end

% Add theoretical line to ratio plot
yline(M_h, '--k', 'Theoretical M', 'LineWidth', 1.5);
fprintf('\n');

%% Part 3: Root of g(x) = x*cos(x) - sin(x)
% Alternative formulation for the same root.
% g'(x) = cos(x) - sin(x) - x*sin(x) - cos(x) = -x*sin(x)
% g''(x) = -sin(x) - x*cos(x)

disp('--------------------------------------------------');
disp('Part 3: Solving g(x) = x*cos(x) - sin(x)');
disp('--------------------------------------------------');

g = @(x) x.*cos(x) - sin(x);
dg = @(x) -x.*sin(x);
ddg = @(x) -sin(x) - x.*cos(x);

% Calculate Theoretical Prefactor M = |g''(x*) / 2g'(x*)|
M_g = abs(ddg(x_star) / (2 * dg(x_star)));
fprintf('Theoretical Prefactor M (g(x)): %.15f\n', M_g);

figure('Name', 'Convergence Analysis: g(x) = x*cos(x) - sin(x)');

for i = 1:length(start_points)
    x0 = start_points(i);
    [roots, iters] = newton_solver_history(g, dg, x0, 1e-12, 20);
    
    % Calculate errors
    errors = abs(roots - x_star);
    valid_mask = errors > 0;
    errors = errors(valid_mask);
    iter_indices = 0:(length(errors)-1);
    
    % Calculate Error Ratio
    if length(errors) > 1
        ratios = errors(2:end) ./ (errors(1:end-1).^2);
    else
        ratios = [];
    end
    
    % Plot Convergence
    subplot(2, 1, 1);
    semilogy(iter_indices, errors, markers{i}, 'DisplayName', sprintf('x_0 = %.1f', x0));
    hold on; grid on;
    title('Convergence Error |x_k - x^*| for g(x)');
    xlabel('Iteration k'); ylabel('Error');
    legend('Location', 'ne');
    
    % Plot Ratio
    subplot(2, 1, 2);
    if ~isempty(ratios)
        plot(iter_indices(1:end-1), ratios, markers{i}, 'DisplayName', sprintf('x_0 = %.1f', x0));
    end
    hold on; grid on;
    title('Error Ratio e_{k+1} / e_k^2');
    xlabel('Iteration k'); ylabel('Ratio');
    legend('Location', 'ne');
end

% Add theoretical line
yline(M_g, '--k', 'Theoretical M', 'LineWidth', 1.5);

%% Local Functions

function x = nth_root_newton(n, A, x0)
    % Solves x^n - A = 0
    % Using simplified Newton step: x_new = ((n-1)*x + A/x^(n-1)) / n
    x = x0;
    tol = 1e-12;
    max_iter = 100;
    
    for k = 1:max_iter
        x_prev = x;
        % Newton step for x^n - A
        x = ((n - 1) * x + A / (x^(n - 1))) / n;
        
        if abs(x - x_prev) < tol
            return;
        end
    end
end

function [x_history, k] = newton_solver_history(func, dfunc, x0, tol, max_iter)
    % General Newton solver that returns the history of approximations
    x_history = zeros(max_iter + 1, 1);
    x_history(1) = x0;
    x = x0;
    k = 0;
    
    for iter = 1:max_iter
        f_val = func(x);
        df_val = dfunc(x);
        
        if df_val == 0
            warning('Derivative is zero at x = %f', x);
            break;
        end
        
        x_new = x - f_val / df_val;
        x_history(iter + 1) = x_new;
        x = x_new;
        k = k + 1;
        
        if abs(x_new - x_history(iter)) < tol
            % Trim unused pre-allocated zeros
            x_history = x_history(1:iter+1);
            return;
        end
    end
    x_history = x_history(1:k+1);
end