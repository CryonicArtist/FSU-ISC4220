function c_num = compute_condition_number(x1)
    % Verify x1 is within the open interval (0, 1)
    if x1 <= 0 || x1 >= 1
        error('x1 must be strictly between 0 and 1');
    end

    A = [1, 0, 0, 0, 0, 0, 0, 0;
         0, 1, 0, 0, 0, 0, 0, 0;
         0, 0, 2, 6*x1, 0, 0, 0, 0;
         0, 0, 0, 0, 1, 1, 1, 1;
         0, 0, 0, 0, 0, 1, 2, 3;
         0, 0, 0, 0, 0, 0, 2, 6*x1;
         1, x1, x1^2, x1^3, -1, -x1, -x1^2, -x1^3;
         0, 1, 2*x1, 3*x1^2, 0, -1, -2*x1, -3*x1^2];
         
    c_num = cond(A);
end

x1_vals = linspace(0.01, 0.99, 200);
cond_vals = zeros(size(x1_vals));

for i = 1:length(x1_vals)
    cond_vals(i) = compute_condition_number(x1_vals(i));
end

% For Part C:

plot(x1_vals, cond_vals, 'LineWidth', 2);
xlabel('Junction Point x_1');
ylabel('Condition Number \kappa(A)');
title('Matrix Condition Number vs. Junction Point');
grid on;

% Find the minimum
[min_cond, idx] = min(cond_vals);
fprintf('Minimum condition number is approximately %.2f at x1 = %.2f\n', min_cond, x1_vals(idx));