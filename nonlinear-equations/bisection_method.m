function [xst, erra, iter] = bisection(func, a, b, tol)
    % BISECTION: Solves func(x) = 0 using the bisection method.
    % Inputs:
    %   func - function handle (e.g., @(x) x^2 - 4)
    %   a, b - interval limits [a, b]
    %   tol  - relative error tolerance
    
    % Check if interval is valid (Sign change check) [cite: 14]
    fa = func(a);
    fb = func(b);
    
    if fa * fb > 0
        error('Error: The function must have different signs at points a and b.');
    end
    
    % Initialize variables
    iter = 0;
    xst = (a + b) / 2;
    erra = 100; % Initialize with a large error
    x_old = xst;

    % Main Loop
    while erra > tol
        iter = iter + 1;
        
        % Calculate midpoint
        xst = (a + b) / 2;
        fx = func(xst);
        
        % Calculate approximate relative error (skip for first iteration)
        if iter > 1 && xst ~= 0
            erra = abs((xst - x_old) / xst);
        elseif xst ~= 0
            % Estimation for first iter relative to interval size
            erra = abs((b - a) / (2 * xst)); 
        end
        
        % Check convergence or exact root found
        if fx == 0
            erra = 0;
            return;
        end
        
        % Update the bracket
        if func(a) * fx < 0
            b = xst; % Root is in the left half
        else
            a = xst; % Root is in the right half
        end
        
        x_old = xst;
    end
end

% Define the function based on the assignment equation
f = @(a) cosh(100/a) - 11;

% Run bisection
[sol, err, iter] = bisection(f, 20, 50, 1e-4);

fprintf('Solution a: %.5f\n', sol);
fprintf('Iterations: %d\n', iter);