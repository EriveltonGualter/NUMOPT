% Numerical Optimization: Exercise Sheet - 05
% Copyright: Alexander Kozhinov, 25.11.2017

clc;
close all;
clear variables;

%% Exercise 2: Unconstrained minimization
% 2b) Newton method:
zN_log = Newton();
plot_results(zN_log,'Newton Method');

% 2c) Gauss-Newton method:
zGN_log = GN();
plot_results(zGN_log,'GN Method');

% Compare performance of Newton and GN:
figPerf = figure('Name', '1b) Performance comparison of Newton and GN');
plot(vecnorm(zN_log,2,2));
hold('on');
plot(vecnorm(zGN_log,2,2));
grid('on');
xlabel('# Iteration - k');
ylabel('||(x_k,y_x)||^2_2');
legend('Newton','Gauss-Newton');
title('Performance comparison of Newton and GN');

% 2d) Steepest descent method:
zSD100_log = SteepestDescent(100);
zSD200_log = SteepestDescent(200);
zSD500_log = SteepestDescent(500);

% Plot results:
plot_results(zSD100_log,'Steepest descent: alpha = 100');
plot_results(zSD200_log,'Steepest descent: alpha = 200');
plot_results(zSD500_log,'Steepest descent: alpha = 500');

%% Exercise 3: Lifted Newton method for root finding problems
% 3a) Newton method:


