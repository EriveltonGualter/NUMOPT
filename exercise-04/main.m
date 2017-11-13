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
f2 = (J * vv - y)' * (J * vv - y);  % yalmipt optimization function

C2 = [];  % yalmip constraints
opt2 = sdpsettings('solver','fmincon','verbose',2);
diagn2 = optimize(C2, f2, opt2);
v2y = double(vv);  % yalmip soution

%% Exercise 3:

% 3a) Write down needed vectors and matrices:
f2 = [0; 0; ones(N,1)];
b = [y; -y; zeros(N,1)];     % no outliers
bo = [yo; -yo; zeros(N,1)];  % outliers

% Bounds:
lb = [-inf; -inf; zeros(N,1)];
ub = [inf; inf; inf * ones(N,1)];

A = [ J,             -eye(N);...
     -J,             -eye(N);
     zeros(size(J)), -eye(N)];

% 3b) Solve the prblem:
z = linprog(f2,A,b,[],[],lb,ub);    % no outliers
zo = linprog(f2,A,bo,[],[],lb,ub);  % outliers

v3 = z(1:2);
v3o = zo(1:2);

% plot L1 fitting results:
plot(x,v3(1)*x+v3(2),'-.','LineWidth',1.2);
plot(x,v3o(1)*x+v3o(2),'-..','LineWidth',1.2);

% 3c) Solve L1 fit problem with yalmip:
s = sdpvar(N,1);
v3y = sdpvar(2,1);
v3oy = sdpvar(2,1);
f3 = sum(s);

% Yalmip settings:
opt3 = sdpsettings('solver','fmincon','verbose',2);

% Constraints without outliers:
C3 = -s <= (v3y(1) * x + v3y(2) - y) <= s;
C3 = [C3; -s <= 0];

% Constraints with outliers:
C3o = -s <= (v3oy(1) * x + v3oy(2) - yo) <= s;
C3o = [C3o; -s <= 0];

% Solve L1 problem without outliers:
diagn3 = optimize(C3, f3, opt3);
v3y = double(v3y);

% Solve L1 problem with outliers:
diagn3o = optimize(C3o, f3, opt3);
v3oy = double(v3oy);

legend('Gaussian noise', 'Gasussian noise and outliers',...
       'L2: no outliers',...
       'L2: outliers',...
       'L1: no outliers',...
       'L1: outliers',...
       'Location', 'northwest');





