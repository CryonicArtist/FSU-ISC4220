% Clear workspace and close figures
clear; clc; close all;

% Create a figure window with a BLACK background
figure('Name', 'Nonlinear Equations (Dark Mode)', 'Color', 'k', 'Position', [100, 100, 1000, 800]);

% --- Define "Dark Mode" Styling Settings ---
% Text is set to white ('w')
titleStyle = {'FontSize', 14, 'FontWeight', 'bold', 'Color', 'w'};
labelStyle = {'FontSize', 12, 'FontWeight', 'bold', 'Color', 'w'};
% Legend background is black, text is white
legendStyle = {'FontSize', 11, 'Box', 'on', 'Color', 'k', 'TextColor', 'w', 'EdgeColor', 'w', 'Location', 'best'};
axisFontSize = 11;
lineWidth = 2.5; 

%% --- Exercise 1: Two examples with at least one root ---

% Example 1: f(x) = x^2 - 2
subplot(2, 2, 1);
f1 = @(x) x.^2 - 2;
x1 = linspace(0, 3, 100);

% Plot Function in CYAN for visibility on black
plot(x1, f1(x1), 'c-', 'LineWidth', lineWidth); hold on;
yline(0, 'w-', 'LineWidth', 1.5); % White x-axis

% Mark the bracket [1, 2] in Red
x_bracket1 = [1, 2];
plot(x_bracket1, f1(x_bracket1), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
line([1 1], [0 f1(1)], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);
line([2 2], [0 f1(2)], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);

% Apply Dark Mode Axes Styling
title('Ex 1.1: f(x) = x^2 - 2', titleStyle{:});
xlabel('x', labelStyle{:}); 
ylabel('f(x)', labelStyle{:});
legend({'Function', 'Bracket [1, 2]'}, legendStyle{:});
set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', ...
    'FontSize', axisFontSize, 'LineWidth', 1.5, ...
    'GridColor', 'w', 'GridAlpha', 0.3);
grid on; axis tight;

% Example 2: f(x) = cos(x) - x
subplot(2, 2, 2);
f2 = @(x) cos(x) - x;
x2 = linspace(-0.5, 1.5, 100);

% Plot Function in CYAN
plot(x2, f2(x2), 'c-', 'LineWidth', lineWidth); hold on;
yline(0, 'w-', 'LineWidth', 1.5); % White x-axis

% Mark the bracket [0, 1]
x_bracket2 = [0, 1];
plot(x_bracket2, f2(x_bracket2), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
line([0 0], [0 f2(0)], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);
line([1 1], [0 f2(1)], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 2);

% Apply Dark Mode Axes Styling
title('Ex 1.2: f(x) = cos(x) - x', titleStyle{:});
xlabel('x', labelStyle{:}); 
ylabel('f(x)', labelStyle{:});
legend({'Function', 'Bracket [0, 1]'}, legendStyle{:});
set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', ...
    'FontSize', axisFontSize, 'LineWidth', 1.5, ...
    'GridColor', 'w', 'GridAlpha', 0.3);
grid on; axis tight;

%% --- Exercise 2: Specific Root Counts ---

% Example (a): Three roots
subplot(2, 2, 3);
f3 = @(x) x.^3 - 4*x;
x3 = linspace(-3, 3, 100);

% Plot Function in YELLOW for contrast
plot(x3, f3(x3), 'y-', 'LineWidth', lineWidth); hold on;
yline(0, 'w-', 'LineWidth', 1.5); % White x-axis

% Mark the 3 roots (Green works well on black)
roots3 = [-2, 0, 2];
plot(roots3, f3(roots3), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 12);

% Apply Dark Mode Axes Styling
title('Ex 2(a): 3 Roots (x^3 - 4x)', titleStyle{:});
xlabel('x', labelStyle{:}); 
ylabel('f(x)', labelStyle{:});
legend({'Function', 'Roots (-2, 0, 2)'}, legendStyle{:});
set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', ...
    'FontSize', axisFontSize, 'LineWidth', 1.5, ...
    'GridColor', 'w', 'GridAlpha', 0.3);
grid on; axis tight;

% Example (b): Zero roots
subplot(2, 2, 4);
f4 = @(x) x.^2 + 1;
x4 = linspace(-2, 2, 100);

% Plot Function in YELLOW
plot(x4, f4(x4), 'y-', 'LineWidth', lineWidth); hold on;
yline(0, 'w-', 'LineWidth', 1.5); % White x-axis

% Apply Dark Mode Axes Styling
title('Ex 2(b): 0 Roots (x^2 + 1)', titleStyle{:});
xlabel('x', labelStyle{:}); 
ylabel('f(x)', labelStyle{:});
legend({'Function (No intersection)'}, legendStyle{:});
set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w', ...
    'FontSize', axisFontSize, 'LineWidth', 1.5, ...
    'GridColor', 'w', 'GridAlpha', 0.3);
grid on; axis tight;