clear; clc; close all;

% --- Define Function and Gradients ---
f = @(x) (x(1) + 2*x(2) - 7)^2 + (2*x(1) + x(2) - 5)^2;

% Gradient Function (returns column vector)
grad_f = @(x) [10*x(1) + 8*x(2) - 34; 
               8*x(1) + 10*x(2) - 38];

% Hessian Function (Constant for this problem)
hess_f = @(x) [10, 8; 
               8, 10];

tol = 1e-6;

%% --- Part (b): Plotting ---
fprintf('Generating plot...\n');
[X, Y] = meshgrid(-5:0.1:5, -5:0.1:10); % Centered roughly around (1,3)
Z = (X + 2.*Y - 7).^2 + (2.*X + Y - 5).^2;

figure;
surf(X, Y, Z);
xlabel('x_1'); ylabel('x_2'); zlabel('f(x)');
title('Surface Plot of f(x_1, x_2)');
colorbar;
view(45, 30);

%% --- Part (c): Newton's Method ---
fprintf('\n--- Part (c): Newton''s Method ---\n');

guesses = [0, 0; 5, 5]; % Two different initial guesses

for k = 1:2
    x_curr = guesses(k, :)'; % Transpose to column vector
    iter = 0;
    err = 100;
    
    fprintf('Start Guess: [%.1f, %.1f]\n', x_curr(1), x_curr(2));
    
    while err > tol
        iter = iter + 1;
        
        g = grad_f(x_curr);
        H = hess_f(x_curr);
        
        % Newton Step: x_new = x - H\g
        % Note: For a quadratic function, this finds exact min in 1 step
        step = H \ g;
        x_new = x_curr - step;
        
        err = norm(x_new - x_curr);
        x_curr = x_new;
        
        if iter > 50, break; end 
    end
    fprintf('  Minima: [%.6f, %.6f]\n', x_curr(1), x_curr(2));
    fprintf('  Iterations: %d\n', iter);
end

%% --- Part (d): BFGS Method ---
fprintf('\n--- Part (d): BFGS Method ---\n');

for k = 1:2
    x_curr = guesses(k, :)';
    iter = 0;
    n = length(x_curr);
    I = eye(n);
    B_inv = I; % Initial Inverse Hessian Approximation
    err = 100;
    
    fprintf('Start Guess: [%.1f, %.1f]\n', x_curr(1), x_curr(2));
    
    while err > tol && iter < 50
        iter = iter + 1;
        
        grad = grad_f(x_curr);
        
        % Search direction
        p = -B_inv * grad;
        
        % In full BFGS we do a line search here. 
        % For simplicity/demonstration, we use step size alpha = 1 
        % (works well for quadratic-like problems near minimum)
        alpha = 1; 
        
        x_new = x_curr + alpha * p;
        
        % Update data for BFGS
        s = x_new - x_curr;        % Change in position
        y = grad_f(x_new) - grad;  % Change in gradient
        
        % Check for convergence before update to avoid division by zero if s is tiny
        if norm(s) < tol
            x_curr = x_new;
            break; 
        end
        
        % BFGS Update Formula (for Inverse Hessian)
        rho = 1 / (y' * s);
        
        term1 = (I - rho * s * y');
        term2 = (I - rho * y * s');
        B_inv = term1 * B_inv * term2 + rho * (s * s');
        
        err = norm(grad_f(x_new)); % Gradient norm as stopping criterion usually better
        x_curr = x_new;
    end
    fprintf('  Minima: [%.6f, %.6f]\n', x_curr(1), x_curr(2));
    fprintf('  Iterations: %d\n', iter);
end
