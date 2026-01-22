function nth_root_finder()
    % Define the cases: [a, n]
    cases = [3, 2; 7, 5]; 
    tol = 1e-4; % Error tolerance
    
    for k = 1:size(cases, 1)
        a = cases(k, 1);
        n = cases(k, 2);
        
        % Initial Guess (generic guess)
        x_current = a/2; 
        if x_current < 1, x_current = 1; end
        
        err = 1.0;
        iter = 0;
        
        fprintf('Finding %d-th root of %d:\n', n, a);
        fprintf('Iter | x_value    | Rel Error\n');
        fprintf('-----|------------|----------\n');
        
        while err > tol
            iter = iter + 1;
            x_prev = x_current;
            
            % Newton's Update
            f = x_prev^n - a;
            df = n * x_prev^(n-1);
            x_current = x_prev - f/df;
            
            % Relative Error Calculation
            if x_current ~= 0
                err = abs(x_current - x_prev) / abs(x_current);
            else
                err = 0;
            end
            
            fprintf('%4d | %.8f | %.2e\n', iter, x_current, err);
        end
        fprintf('Final Result: %.8f\n\n', x_current);
    end
end