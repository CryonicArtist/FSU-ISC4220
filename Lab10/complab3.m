% LAB 3: Flame Propagation
deltas = [0.1, 1e-5]; 
opts = odeset('RelTol', 1e-4);

for i = 1:length(deltas)
    delta = deltas(i);
    t_end = 2/delta;
    
    % ode45
    tic;
    [t45, y45] = ode45(@(t,r) r^2 - r^3, [0, t_end], delta, opts);
    time45 = toc;
    fprintf('ode45 with delta=%g took %f seconds.\n', delta, time45);
    
    % ode23s 
    tic;
    [t23s, y23s] = ode23s(@(t,r) r^2 - r^3, [0, t_end], delta, opts);
    time23s = toc;
    fprintf('ode23s with delta=%g took %f seconds.\n', delta, time23s);
end