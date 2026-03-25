clear; clc; close all;

f = @(x) cos(x);
a = 0;
b = pi/2;
true_val = 1;

n_vals = [4, 8, 16, 32, 64];
errors = zeros(size(n_vals));

figure('Name', 'Simpson''s Rule Evaluation', 'Position', [100, 100, 1200, 800]);

fprintf('Simpson''s 1/3 Rule Results:\n');
fprintf(' n  |    Approximation    |        Error       \n');
for i = 1:length(n_vals)
    n = n_vals(i);

    I_approx = simpsons(f, n, a, b);
    
    errors(i) = abs(true_val - I_approx);

    fprintf('%2d  |  %.15f  |  %.10e \n', n, I_approx, errors(i));
   
    subplot(2, 3, i); 
    fplot(f, [a, b], 'b-', 'LineWidth', 1.5); hold on;

    x_pts = linspace(a, b, n+1);
    y_pts = f(x_pts);
    plot(x_pts, y_pts, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 4);

    stem(x_pts, y_pts, 'r--', 'Marker', 'none');
    
    title(sprintf('Nodes for n = %d', n));
    xlabel('x'); ylabel('cos(x)');
    grid on; hold off;
end

subplot(2, 3, 6);
loglog(n_vals, errors, 'bo-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
hold on;

C = errors(1) / (n_vals(1)^-4);
ref_line = C * (n_vals.^-4);
loglog(n_vals, ref_line, 'k--', 'LineWidth', 1.5);

title('Error Convergence Rate');
xlabel('Number of intervals (n)');
ylabel('Absolute Error');
legend('Actual Error', 'O(n^{-4}) Reference', 'Location', 'southwest');
grid on; hold off;


function I1 = simpsons(f, n, a, b)
    if mod(n, 2) ~= 0
        error('n has to be even')
    end
   
    x = linspace(a, b, n+1);
    h = (b - a)/n;

    term1 = f(x(1)) + f(x(n+1));
    
    term2 = 4 * sum(f(x(2:2:n)));
    
    term3 = 2 * sum(f(x(3:2:n-1)));
    
    I1 = (h / 3) * (term1 + term2 + term3);
end