%% Main Script Execution
clear; clc;

% 1. Define the equation f(a) = 0
% We use an anonymous function handle for f(a) = cosh(100/a) - 11
func = @(a) cosh(100./a) - 11;

% 2. Define input parameters
lower_bound = 20;
upper_bound = 50;
tolerance = 1e-4; % Stopping criteria

fprintf('--- Bisection Method Assignment ---\n\n');

% 3. Call the local function defined at the bottom of this file
[root, error, iterations] = bisection(func, lower_bound, upper_bound, tolerance);

% 4. Print the final results
fprintf('----------------------------------------------------------------------\n');
fprintf('\nFinal Solution:\n');
fprintf('Root found (xst)   = %.6f\n', root);
fprintf('Relative Error     = %.6e %%\n', error);
fprintf('Total Iterations   = %d\n', iterations);


%% Local Function Definition
% This function must be placed at the end of the file.

function [xst, erra, iter] = bisection(func, xl, xu, tol)
    % Check for valid interval (Sign change)
    if func(xl) * func(xu) >= 0
        error('Error: f(a) and f(b) must have opposite signs. Invalid interval.');
    end

    iter = 0;
    xm_old = xl; 
    erra = 100; % Initialize error > tol to ensure loop starts

    % Print Table Header
    fprintf('First 3 Iterations:\n');
    fprintf('%-5s | %-12s | %-12s | %-12s | %-12s\n', 'Iter', 'Lower (a)', 'Upper (b)', 'Root Est', 'Error (%)');
    fprintf('----------------------------------------------------------------------\n');

    % Main Bisection Loop
    while erra > tol
        iter = iter + 1;
        
        % Calculate midpoint
        xm = (xl + xu) / 2;
        
        % Calculate Error
        if iter == 1
            erra = 100; % No error calculation for first step
        else
            erra = abs((xm - xm_old) / xm) * 100;
        end
        
        % Print first 3 iterations as requested
        if iter <= 3
            fprintf('%-5d | %-12.6f | %-12.6f | %-12.6f | %-12.6f\n', iter, xl, xu, xm, erra);
        end
        
        % Determine which subinterval contains the root
        test = func(xl) * func(xm);
        
        if test < 0
            xu = xm; % Root is in the lower half
        elseif test > 0
            xl = xm; % Root is in the upper half
        else
            erra = 0; % Found exact root
        end
        
        xm_old = xm;
    end
    
    xst = xm;
end