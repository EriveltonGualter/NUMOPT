% Numerical Optimization: Exercise Sheet - 05
% Copyright: Alexander Kozhinov, 25.11.2017

clc;
close all;
clear variables;

%% Exercise 1
% 1b) Newton method:
zN_log = Newton();
plot_results(zN_log,'Newton Method');

% 1b) Gauss-Newton method:
zGN_log = GN();
plot_results(zGN_log,'GN Method');