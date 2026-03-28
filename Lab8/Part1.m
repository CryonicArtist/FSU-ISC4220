% Parameters
x = pi/3;
true_val = 0.5;
h = logspace(-15, -1, 100);

% Numerical Formulas
f = @(x) sin(x);
forward_diff = (f(x + h) - f(x)) ./ h;
centered_diff = (f(x + h) - f(x - h)) ./ (2 * h);

% Absolute Errors
err_forward = abs(forward_diff - true_val);
err_centered = abs(centered_diff - true_val);

% Plotting
figure;
loglog(h, err_forward, 'r', 'LineWidth', 1.5); hold on;
loglog(h, err_centered, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Step size (h)');
ylabel('Absolute Error');
legend('Forward-difference', 'Centered-difference');
title('Error vs Step-size for Numerical Differentiation');