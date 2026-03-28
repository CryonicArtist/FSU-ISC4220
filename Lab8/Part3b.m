% Data from gompertz.dat
t = [0.00; 6.67; 13.33; 20.00; 26.67; 33.33; 40.00; 46.67; 53.33; 60.00];
N = [2.6281e+01; 3.7975e+02; 1.0802e+03; 6.0378e+03; 1.0786e+04; ...
     1.4625e+04; 1.8016e+04; 2.0349e+04; 2.1154e+04; 2.0913e+04];

% Linearize
y = log(1 - log(N)/10);

% Solve Normal Equations: (t'*t)b = t'*y
% Note: b = -slope
b_fit = -(t' * t) \ (t' * y);
fprintf('Estimated b: %f\n', b_fit);

% Plotting Fit
t_fine = linspace(0, 60, 100);
N_fit = exp(10 * (1 - exp(-b_fit * t_fine)));

figure;
plot(t, N, 'ro', 'MarkerFaceColor', 'r'); hold on;
plot(t_fine, N_fit, 'b-');
xlabel('Time (t)'); ylabel('Population (N)');
legend('Data', 'Gompertz Fit');
title('Gompertz Population Model Fit');