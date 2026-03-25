% 1. Define the data [cite: 33]
x_data = [0.00; 0.25; 0.50; 0.75; 1.00];
y_data = [2.10; 3.70; 6.26; 10.03; 16.31];

% 2. Optimization setup 
initial_guess = [1.5; 2]; 

% Set optimization options for BFGS and tolerance
options = optimoptions('fminunc', ...
    'Algorithm', 'quasi-newton', ... % BFGS
    'SpecifyObjectiveGradient', true, ...
    'OptimalityTolerance', 1e-4, ... % Tolerance on the norm of the gradient
    'Display', 'iter');

% 3. Define the objective function with Gradient 
% This function returns both Phi and the gradient vector del_Phi
objFun = @(p) cost_with_grad(p, x_data, y_data);

% 4. Run the optimization
[params_opt, final_cost, exitflag, output] = fminunc(objFun, initial_guess, options);

% 5. Display Results
fprintf('\nOptimal a2: %.4f\n', params_opt(1));
fprintf('Optimal b2: %.4f\n', params_opt(2));

% --- Helper Function ---
function [Phi, grad] = cost_with_grad(params, x, y)
    a2 = params(1);
    b2 = params(2);
    
    % Model: m2(x) = a2*x + 2*exp(b2*x) [cite: 36]
    m2 = a2.*x + 2.*exp(b2.*x);
    error = y - m2;
    
    % Cost function: Phi = sum(y - m2)^2 
    Phi = sum(error.^2);
    
    % Gradient components 
    dPhi_da2 = -2 * sum(error .* x);
    dPhi_db2 = -2 * sum(error .* (2 .* x .* exp(b2 .* x)));
    
    grad = [dPhi_da2; dPhi_db2];
end