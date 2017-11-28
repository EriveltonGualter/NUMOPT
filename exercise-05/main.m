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
figPerf = figure('Name', '2b) Performance comparison of Newton and GN');
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
w0s = [1; 0.1; 100];  % initial points
zNR1_log = NewtonRoot(1,'',10^6);
zNR2_log = NewtonRoot(0.1,'',10^6);
zNR3_log = NewtonRoot(100,'',10^6);
disp('Newton Root');
disp(['Start point: ',num2str(w0s(1)),...
      ' --> w_opt = ',num2str(zNR1_log(end)),...
      '; # Iter = ',num2str(length(zNR1_log))]);
disp(['Start point: ',num2str(w0s(2)),...
      ' --> w_opt = ',num2str(zNR2_log(end)),...
      '; # Iter = ',num2str(length(zNR2_log))]);
disp(['Start point: ',num2str(w0s(3)),...
      ' --> w_opt = ',num2str(zNR3_log(end)),...
      '; # Iter = ',num2str(length(zNR3_log))]);

% 3b) Fixed gradient root finding:
a = 1;
b = 2;
zNRa_fixed_log = NewtonRoot(a,'fixed',10^6);
zNRb_fixed_log = NewtonRoot(b,'fixed',10^6);
disp('Newton Root: Fixed Jacobian');
disp(['Start point: ',num2str(a),...
      ' --> w_opt = ',num2str(zNRa_fixed_log(end)),...
      '; # Iter = ',num2str(length(zNRa_fixed_log))]);
disp(['Start point: ',num2str(b),...
      ' --> w_opt = ',num2str(zNRb_fixed_log(end)),...
      '; # Iter = ',num2str(length(zNRb_fixed_log))]);


