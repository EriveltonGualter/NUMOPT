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
v2 = (J'*J)\(J'*y);  % fitted coeffitiens [a, b] - no outliers
v2o = (J'*J)\(J'*yo);  % fitted coeffitiens [a, b] - outliers

plot(x,v2(1)*x+v2(2),'LineWidth',1.2);  % plot fitted line: no outliers
plot(x,v2o(1)*x+v2o(2),'LineWidth',1.2);  % plot fitted line: outliers

% 1c) Fit data with yalmip:
vv = sdpvar(2,1);  % yalmip optimization variables
f = (J * vv - y)' * (J * vv - y);  % yalmipt optimization function

C = [];  % yalmip constraints
opt = sdpsettings('solver','fmincon','verbose',2);
diagn   = optimize(C, f, opt);
v2y = double(vv);  % yalmip soution

% plot yalmip fitting results:
plot(x,v2y(1)*x+v2y(2),'--','LineWidth',1.2);  % plot fitted line: no outliers

%% Exercise 3:

% 3a) Write down needed vectors and matrices:
f = [0; 0; ones(N,1)];
b = [y; -y; zeros(N,1)];     % no outliers
bo = [yo; -yo; zeros(N,1)];  % outliers

% Bounds:
lb = [-inf; -inf; zeros(N,1)];
ub = [inf; inf; inf * ones(N,1)];

A = [ J,             -eye(N);...
     -J,             -eye(N);
     zeros(size(J)), -eye(N)];

z = linprog(f,A,b,[],[],lb,ub);    % no outliers
zo = linprog(f,A,bo,[],[],lb,ub);  % outliers

v3 = z(1:2);
v3o = zo(1:2);

% plot L1 fitting results:
plot(x,v3(1)*x+v3(2),'-.','LineWidth',1.2);
plot(x,v3o(1)*x+v3o(2),'-..','LineWidth',1.2);

legend('Gaussian noise', 'Gasussian noise and outliers',...
       'L2: no outliers',...
       'L2: outliers',...
       'L2 (yalmip): no outliers',...
       'L1: no outliers',...
       'L1: outliers',...
       'Location', 'northwest');





