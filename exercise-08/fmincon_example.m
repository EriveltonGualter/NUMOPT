
% a simple example using fmincon
clear variables; close all; clc

param.R = 1; % radius of constraint
x0 = [1;1];  % initial condition for solver

% Objective f = x_2:
obj = @(x)(x(2));

% Nonlinear constraints:
% (we need to create a function that takes only the optimization variables
% as input and keeps the parameters in param fixed)
con = @(x)(fmincon_constraints(x, param));

% Load default options for fmincon:
opts = optimoptions('fmincon');

% Example on how to change an option:
opts.MaxFunEvals = 5000;

% Call fmincon:
[x_opt,~,~,~,lambdas] = fmincon(obj,x0,[],[],[],[],[],[],con,opts);

% Dual multiplier of nonlinear equality constraint: lambdas.eqnonlin:

% Plot result:
ang = 0:0.01:2*pi; 
xp  = param.R*cos(ang);
yp  = param.R*sin(ang);
plot(xp, yp);
hold('on');
plot(x_opt(1),x_opt(2),'rx','MarkerSize',10);
axis(param.R*[-1.1 1.1 -1.1 1.1]);
title('A simple example on equality constrained optimization');
legend('Equality constraint','Optimal solution');

disp('Optimal solution:');
disp(x_opt);

% check constraint violation at solution
[C, Ceq] = con(x_opt);
disp('Constraint violation at solution:');
disp(abs(Ceq));
