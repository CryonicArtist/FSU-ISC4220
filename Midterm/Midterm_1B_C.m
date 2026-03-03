function [x_min] = minimize_cost(alpha, x_initial, epsilon)
    % x_initial is a 2x1 vector [x; y]
  
    curr_x = x_initial;
    
    while true
        x = curr_x(1);
        y = curr_x(2);
        
        % Define Gradient
        grad = [(1 + alpha)*y - 2/x^2; 
                (1 + alpha)*x - 2/y^2];
        
        % Check stopping criteria: norm of gradient < epsilon
        if norm(grad) < epsilon
            break;
        end
        
        % Define Hessian
        Hess = [4/x^3,       1 + alpha; 
                1 + alpha,   4/y^3];
        
        % Newton update: x_next = x_curr - H^-1 * grad
        % Using backslash operator for better numerical stability
        curr_x = curr_x - Hess \ grad;
    end
    x_min = curr_x;
end

% Part C value inputs below:

alphas = [0, 1, 10000];
initial_guess = [2; 3];
epsilon = 1e-4;

fprintf('\nAlpha\t\t x\t\t y\t\t z\t\t Cost\n');
fprintf('------------------------------------------------------------\n');

for a = alphas
    sol = minimize_cost(a, initial_guess, epsilon);
    
    x_val = sol(1);
    y_val = sol(2);
    z_val = 1 / (x_val * y_val);
    total_cost = (1 + a)*x_val*y_val + 2/x_val + 2/y_val;

    fprintf('%-8d\t %1.4f\t %1.4f\t %1.4f\t %1.4f\n', a, x_val, y_val, z_val, total_cost);
end