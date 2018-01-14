% NUMOPT, WS17/18
% Copyright: Alexander Kozhinov
%            AlexanderKozhinov@yandex.com

clc;
close all;
clear variables;
addpath('/Applications/MATLAB_R2017b.app/casadi-matlabR2015a-v3.3.0');

%% Test derivatives:
disp('*** Testing derivatives ***');
test_derivatives(50);

%% Runtime of methods:
disp('*** Derivatives runtime ***')
test_derivatives(200);

%% Solve optimization problem:
param.N = 50;  % number of discretization steps
param.x0 = 2;  % init condition
param.T  = 5;  % terminal time
param.q  = 50;  % terminal weight

h = param.T/param.N;  % interval length
N = param.N;

%% CasADi solution of problem (1):
opti = casadi.Opti();

u = opti.variable(N,1);
x = opti.variable(N+1,1);

opti.minimize(u'*u + param.q*x(end)^2);
opti.subject_to(x(1) == param.x0);
for k=1:param.N
    opti.subject_to(x(k+1) == x(k) + h*((1-x(k))*x(k) + u(k)));
end

opti.solver('ipopt');
sol = opti.solve();

U = sol.value(u);
X = sol.value(x);

plot_state_controls('CasADi: State vs. Controls',X,U);

%% BFGS solutions for different AD approaches:
% BFGS breaking criteria:
TOL = 1e-3;
maxIter = 2000;

%% BFGS with FD of (1):
disp('Running BFGS with FD:');
[X,U] = BFGS(@finite_difference, @Phi, param, maxIter, TOL);
plot_state_controls('BFGS with FD',X,U);
disp(' ');

%% BFGS with ImT of (1):
disp('Running BFGS with ImT:');
[X,U] = BFGS(@i_trick, @Phi, param, maxIter, TOL);
plot_state_controls('BFGS with ImTrick',X,U);
disp(' ');

%% BFGS with FAD of (1):
disp('Running BFGS with FAD:');
[X,U] = BFGS(@Phi_FAD, @Phi, param, maxIter, TOL);
plot_state_controls('BFGS with FAD',X,U);
disp(' ');

%% BFGS with BAD of (1):
disp('Running BFGS with BAD:');
[X,U] = BFGS(@Phi_BAD, @Phi, param, maxIter, TOL);
plot_state_controls('BFGS with BAD',X,U);
disp(' ');

