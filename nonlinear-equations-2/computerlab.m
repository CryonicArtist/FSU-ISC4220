function lab2_solution()
    
    clc; close all;
    format long;

    % --- PART 1: Nth Root Finder ---
    fprintf('PART 1: Nth Root Finder Results\n');
    fprintf('-------------------------------\n');
    solve_nth_root(3, 2); % sqrt(3)
    solve_nth_root(7, 5); % 7^(1/5)

    % --- PART 2: Newton-Raphson for h(x) = tan(x) - x ---
    fprintf('\nPART 2: Newton-Raphson Analysis\n');
    x_true = 4.493409457909064175;
    
    % 2(b) Perform 5 iterations with x0 = 4.2
    fprintf('\n2(b) Iterations for h(x) with x0 = 4.2:\n');
    x_curr = 4.2; 
    fprintf('Iter |      x_i       |      f(x)      |      Step\n');
    fprintf('-----|----------------|----------------|----------------\n');
    fprintf('  0  | %.12f | %.4e |      --     \n', x_curr, tan(x_curr)-x_curr);
    
    for i = 1:5
        fx = tan(x_curr) - x_curr;
        dfx = (tan(x_curr))^2; % h'(x)
        step = fx / dfx;
        x_new = x_curr - step;
        fprintf('  %d  | %.12f | %.4e | %.4e\n', i, x_new, tan(x_new)-x_new, step);
        x_curr = x_new;
    end

    % 2(c) Perform 9 iterations with x0 = 4.7
    x_curr = 4.7; 
    errors_h = zeros(9, 1);
    
    for i = 1:9
        fx = tan(x_curr) - x_curr;
        dfx = (tan(x_curr))^2;
        x_new = x_curr - fx/dfx;
        errors_h(i) = abs(x_curr - x_true); 
        x_curr = x_new;
    end
    
    % Plot 2(c)
    figure(1);
    semilogy(1:9, errors_h, '-o', 'LineWidth', 2);
    title('2(c) Convergence of h(x) = tan(x)-x');
    xlabel('Iteration Number');
    ylabel('Absolute Error |x_i - x^*|');
    grid on;

    % 2(d) Prefactor Analysis
    h_prime = (tan(x_true))^2;
    h_double_prime = 2 * tan(x_true) * (sec(x_true))^2;
    prefactor_h = abs(h_double_prime / (2 * h_prime)); 
    
    fprintf('\n2(d) Calculated Prefactor for h(x): %.5f\n', prefactor_h);
    
    % Calculate Ratios E_{i+1}/E_i
    ratios_h = zeros(8, 1);
    for i = 1:8
        if errors_h(i) > 0
            ratios_h(i) = errors_h(i+1) / errors_h(i);
        end
    end
    
    % Plot 2(d)
    figure(2);
    plot(1:8, ratios_h, '-s', 'LineWidth', 2);
    title('2(d) Ratio E_{i+1}/E_i for h(x)');
    xlabel('Iteration Number');
    ylabel('Ratio E_{i+1} / E_i');
    grid on;

    % --- PART 2(e): Newton-Raphson for g(x) = x*cos(x) - sin(x) ---
    fprintf('\n2(e) Iterations for g(x) with x0 = 4.2:\n');
    x_curr = 4.2; 
    errors_g = zeros(5, 1);
    
    for i = 1:5
        gx = x_curr * cos(x_curr) - sin(x_curr);
        dgx = -x_curr * sin(x_curr); % g'(x)
        x_new = x_curr - gx/dgx;
        errors_g(i) = abs(x_curr - x_true);
        x_curr = x_new;
    end

    % Plot 2(e)
    figure(3);
    semilogy(1:5, errors_g, '-d', 'LineWidth', 2, 'Color', 'r');
    title('2(e) Convergence of g(x) = x cos(x) - sin(x)');
    xlabel('Iteration Number');
    ylabel('Absolute Error |x_i - x^*|');
    grid on;

    % 2(f) Prefactor Comparison
    g_prime = -x_true * sin(x_true);
    g_double_prime = -(sin(x_true) + x_true * cos(x_true));
    prefactor_g = abs(g_double_prime / (2 * g_prime)); 
    
    fprintf('\n2(f) Calculated Prefactor for g(x): %.5f\n', prefactor_g);
end

function solve_nth_root(a, n)
    tol = 1e-4;
    max_iter = 100;
    x_curr = a / 2;
    if x_curr < 1, x_curr = 1.5; end
    
    for k = 1:max_iter
        fx = x_curr^n - a;
        dfx = n * x_curr^(n-1);
        x_new = x_curr - fx/dfx;
        
        if x_new ~= 0, ea = abs(x_new - x_curr) / abs(x_new); else, ea = 0; end
        
        if ea <= tol
            fprintf('  %d^(1/%d) = %.6f (Converged in %d iters)\n', a, n, x_new, k);
            return;
        end
        x_curr = x_new;
    end
    fprintf('  Did not converge.\n');
end