% LAB 2: Shooting Method
opts = odeset('RelTol', 1e-4);
% Bisection search parameters
s_left = -1; s_right = 1; 
tol = 1e-5;

% Bisection Loop
while (s_right - s_left) > tol
    s_mid = (s_left + s_right) / 2;
    
    [~, Y_left] = ode45(@(t,y) [y(2); y(1)-t], [0, 1], [0; s_left], opts);
    [~, Y_mid] = ode45(@(t,y) [y(2); y(1)-t], [0, 1], [0; s_mid], opts);
    
    g_left = Y_left(end, 1);
    g_mid = Y_mid(end, 1);
    
    if sign(g_left) == sign(g_mid)
        s_left = s_mid;
    else
        s_right = s_mid;
    end
end

% Final solution with best slope
s_final = (s_left + s_right) / 2;
[t_comp, Y_comp] = ode45(@(t,y) [y(2); y(1)-t], [0, 1], [0; s_final], opts);

% Exact Solution
t_exact = linspace(0, 1, 100);
C = exp(1) / (exp(2) - 1);
y_exact = t_exact + C*(exp(-t_exact) - exp(t_exact));

figure;
plot(t_exact, y_exact, 'b-', 'LineWidth', 2, 'DisplayName', 'Exact'); hold on;
plot(t_comp, Y_comp(:,1), 'ro--', 'DisplayName', 'Computed (Bisection)');
legend; xlabel('t'); ylabel('y(t)');
title('Exercise 4: Shooting Method vs Exact Solution');