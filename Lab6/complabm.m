% Data points for interpolation
x_data = [1, 2, 3, 4, 5];
f_data = [1, 1, 2, 6, 24];

% Domain for plotting
xx = linspace(0.5, 5.5, 1000);

% (a) Evaluate the 4th Degree Interpolating Polynomial P4(x)
% Using the coefficients derived from the divided differences table
P4_vals = 1 + 0.*(xx - 1) + ...
          (0.5).*(xx - 1).*(xx - 2) + ...
          (1/3).*(xx - 1).*(xx - 2).*(xx - 3) + ...
          (3/8).*(xx - 1).*(xx - 2).*(xx - 3).*(xx - 4);

% (b) Built-in Cubic Spline Interpolation
spline_vals = interp1(x_data, f_data, xx, 'spline');

% Intrinsic Gamma Function
true_gamma = gamma(xx);

% (c) Plotting the Functions and Absolute Errors
figure('Position', [100, 100, 800, 600]);

% --- Top Plot: Function Comparisons ---
subplot(2,1,1);
plot(xx, true_gamma, 'k-', 'LineWidth', 2); hold on;
plot(xx, P4_vals, 'b--', 'LineWidth', 1.5);
plot(xx, spline_vals, 'r-.', 'LineWidth', 1.5);
plot(x_data, f_data, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
grid on;
title('Gamma Function Interpolation');
xlabel('x'); ylabel('\Gamma(x)');
legend('Intrinsic \Gamma(x)', '4th Degree Polynomial', 'Cubic Spline', 'Data Nodes', 'Location', 'northwest');

% --- Bottom Plot: Absolute Errors ---
subplot(2,1,2);
error_P4 = abs(P4_vals - true_gamma);
error_spline = abs(spline_vals - true_gamma);

% Using semilogy for better visibility of error ranges
semilogy(xx, error_P4, 'b-', 'LineWidth', 1.5); hold on;
semilogy(xx, error_spline, 'r-', 'LineWidth', 1.5);
grid on;
title('Absolute Errors of Interpolants');
xlabel('x'); ylabel('Absolute Error (Log Scale)');
legend('Error: 4th Degree Polynomial', 'Error: Cubic Spline', 'Location', 'north');