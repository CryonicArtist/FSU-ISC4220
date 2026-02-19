clear; clc; format long;

f = @(x) 1 - (x-1).^2 + sin(x);
% For Newton's, we find roots of f'(x) = 0
df = @(x) -2*(x-1) + cos(x);
% Second derivative for Newton update
d2f = @(x) -2 - sin(x);

tol = 1e-6;
true_max = 1.18715; 

fprintf('--- Part (a): Golden Section Search ---\n');
a = 0; 
b = 3;
phi = (sqrt(5) - 1) / 2;

% Initialize interior points
c = b - phi * (b - a);
d = a + phi * (b - a);
fc = f(c);
fd = f(d);
iter_gold = 0;

while (b - a) > tol
    iter_gold = iter_gold + 1;
    if fc > fd
        % Max is in [a, d]
        b = d;
        d = c;
        fd = fc;
        c = b - phi * (b - a);
        fc = f(c);
    else
        % Max is in [c, b]
        a = c;
        c = d;
        fc = fd;
        d = a + phi * (b - a);
        fd = f(d);
    end
end
xmax_gold = (a + b) / 2;
fprintf('Maxima found: %.8f\n', xmax_gold);
fprintf('Iterations: %d\n', iter_gold);
fprintf('Error: %.2e\n\n', abs(xmax_gold - true_max));


fprintf('--- Part (b): Newton''s Method ---\n');
x0 = 0;
iter_newt = 0;
err = 100; % arbitrary large start

while err > tol
    iter_newt = iter_newt + 1;
    
    % Newton update for OPTIMIZATION: x = x - f'(x)/f''(x)
    x_new = x0 - df(x0) / d2f(x0);
    
    err = abs(x_new - x0);
    x0 = x_new;
end
fprintf('Maxima found: %.8f\n', x0);
fprintf('Iterations: %d\n', iter_newt);
fprintf('Error: %.2e\n\n', abs(x0 - true_max));


fprintf('--- Part (c): Quadratic Interpolation ---\n');
x0 = 0;
x1 = 1.5;
x2 = 3;
iter_quad = 0;
err = 100;

while err > tol
    iter_quad = iter_quad + 1;
    
    f0 = f(x0); f1 = f(x1); f2 = f(x2);
    
    % Numerator
    num = f0*(x1^2 - x2^2) + f1*(x2^2 - x0^2) + f2*(x0^2 - x1^2);
    % Denominator
    den = 2 * (f0*(x1 - x2) + f1*(x2 - x0) + f2*(x0 - x1));
    
    if den == 0
        warning('Denominator zero in Quadratic Interpolation');
        break;
    end
    
    x3 = num / den;
    
    err = abs(x3 - x1); % Check convergence based on change in estimate
    
    % Update points (simple shift for this specific unimodal problem)
    % A robust implementation would bracket the max, but we follow standard iter
    x0 = x1;
    x1 = x2;
    x2 = x3; 
    
    % Safety break
    if iter_quad > 100
        break; 
    end
end
fprintf('Maxima found: %.8f\n', x3);
fprintf('Iterations: %d\n', iter_quad);
fprintf('Error: %.2e\n\n', abs(x3 - true_max));


