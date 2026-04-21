% LAB 1: Mass on a Spring
h = 0.01;
t = 0:h:4*pi;
m = 1; k = 1;
mu_vals = [0, 0.5, 2];

figure; hold on;
for i = 1:length(mu_vals)
    mu = mu_vals(i);
    X = zeros(2, length(t));
    X(:,1) = [1; 0]; % x(0)=1, x'(0)=0
    
    for n = 1:length(t)-1
        % Midpoint step
        k1_1 = X(2, n);
        k1_2 = -(k/m)*X(1, n) - (mu/m)*X(2, n);
        
        mid_x1 = X(1, n) + (h/2)*k1_1;
        mid_x2 = X(2, n) + (h/2)*k1_2;
        
        k2_1 = mid_x2;
        k2_2 = -(k/m)*mid_x1 - (mu/m)*mid_x2;
        
        X(1, n+1) = X(1, n) + h*k2_1;
        X(2, n+1) = X(2, n) + h*k2_2;
    end
    plot(t, X(1,:), 'DisplayName', ['\mu = ', num2str(mu)]);
end
legend; xlabel('Time (t)'); ylabel('Position (x)');
title('Exercise 2a: Mass-Spring System with Midpoint Method');