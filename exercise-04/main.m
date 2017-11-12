% Numerical Optimization: Exercise Sheet - 04
% Copyright: Alexander Kozhinov, 11.11.2017

clc;
close all;
clear variables;

%% Exercise 2:
% 1a) Create and plot data:
N = 30;  % number of points
[y, yo, x] = create_data(N, 3, [3; 4], [0; 5], 1);

figure('Name', 'Data to fit');
plot(x, y, 'o', x, yo, '*');
grid('on');
xlabel('x');
ylabel('y');
title('Inout data and fit.');
hold('on');

% 1b) Fit data with equation (3): 
J = [x, ones(size(x))];
v = (J'*J)\(J'*y);  % fitted coeffitiens [a, b] - no outliers
vo = (J'*J)\(J'*yo);  % fitted coeffitiens [a, b] - outliers

plot(x,v(1) * x + v(2), 'LineWidth', 1.2);  % plot fitted line: no outliers
plot(x,vo(1) * x + vo(2), 'LineWidth', 1.2);  % plot fitted line: outliers

legend('Gaussian noise', 'Gasussian noise and outliers',...
       'Fitted line: no outliers',...
       'Fitted line: outliers',...
       'Location', 'northwest');

% 1c) Fit data with yalmip:
% yalmip optimization variables
yy = sdpvar(N,1);
xx = sdpvar(N,1);
vv = sdpvar(2,1);

C = [xx == x, yy == y];  % yalmip constraints
opt = sdpsettings('solver', 'fmincon','verbose',2,'usex0',0);
diagn   = optimize(C, vv, opt);
X = double(xx);
Y = double(yy);
V = double(vv);



