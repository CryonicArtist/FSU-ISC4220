%% System Definition from Lab 04
A = [-2, 1, 0, 0, 0, 0; 
      1,-2, 1, 0, 0, 0; 
      0, 1,-2, 1, 0, 0; 
      0, 0, 1,-2, 1, 0; 
      0, 0, 0, 1,-2, 1; 
      0, 0, 0, 0, 1,-2]; % 

b = [-2.017; -0.01; -0.01; -0.01; -0.01; -3.01];
tol = 1e-5;
v0 = zeros(6, 1); 
n = length(b);

%% 1. Gauss-Seidel: First Three Iterations 
fprintf('--- Gauss-Seidel: First Three Iterations ---\n');
fprintf('%-5s | %-45s | %-10s\n', 'Iter', 'Vector V', 'Rel. Error');
fprintf('--------------------------------------------------------------------------\n');

V = v0;
gs_errors = [];
for k = 1:3
    V_old = V;
    for i = 1:n
        sum_val = b(i) - A(i, 1:i-1)*V(1:i-1) - A(i, i+1:n)*V_old(i+1:n);
        V(i) = sum_val / A(i,i);
    end
    rel_error = norm(V - V_old) / norm(V);
    gs_errors(k) = rel_error;
    fprintf('%-5d | [%.4f, %.4f, %.4f, %.4f, %.4f, %.4f] | %.6f\n', ...
            k, V(1), V(2), V(3), V(4), V(5), V(6), rel_error);
end

%% 2. Run All Solvers for Summary and Plotting
omegas = [1.0, 1.2, 1.4, 1.6]; 
results = zeros(length(omegas), 1);
figure; hold on;

for idx = 1:length(omegas)
    w = omegas(idx);
    V = v0;
    errors = [];
    for k = 1:500
        V_old = V;
        for i = 1:n
            sum_val = b(i) - A(i, 1:i-1)*V(1:i-1) - A(i, i+1:n)*V_old(i+1:n);
            V(i) = (1 - w) * V_old(i) + (w / A(i,i)) * sum_val;
        end
        rel_error = norm(V - V_old) / norm(V);
        errors = [errors, rel_error];
        if rel_error <= tol, break; end
    end
    results(idx) = k;
    
    % Plotting logic
    label = sprintf('\\omega = %.1f', w);
    if w == 1.0, label = 'Gauss-Seidel'; end
    semilogy(errors, 'LineWidth', 1.5, 'DisplayName', label);
end

%% 3. Print Summary Table 
fprintf('\n--- Total Iterations to Converge ---\n');
SummaryTable = table(omegas', results, 'VariableNames', {'Omega_Value', 'Iterations'});
disp(SummaryTable);

%% 4. Format Plot
grid on;
xlabel('Iteration Number');
ylabel('Relative Error (||V_{k+1}-V_k|| / ||V_{k+1}||)');
title('Convergence of Gauss-Seidel vs SOR');
legend('show');
yline(tol, '--r', 'Convergence Criterion (10^{-5})');