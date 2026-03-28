h_vals = [1e-9, 1e-5, 1e-1];
t_target = 30;
true_deriv = 674.52817969484;

G = @(t) exp(10 * (1 - exp(-b_fit * t)));

fprintf('\nh \t\t Numerical Deriv \t Error\n');
for h = h_vals
    dndt = (G(t_target + h) - G(t_target - h)) / (2 * h);
    fprintf('%e \t %f \t %e\n', h, dndt, abs(dndt - true_deriv));
end