% NUMOPT, WS17/18
% Copyright: Alexander Kozhinov
%            AlexanderKozhinov@yandex.com

clc;
close all;
clear variables;

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
U = zeros(N,1);  % clear solution control
X = zeros(N,1);  %  clear solution state

%% CasADi solution of problem (1):
opti = casadi.Opti();

u = opti.variable(N,1);
x = opti.variable(N,1);

opti.minimize(sum(u.^2) + param.q*x(end)^2);
opti.subject_to(x(1) == param.x0);
for k=1:param.N-1
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

[X,U] = BFGS(@finite_difference, @Phi, param, maxIter, TOL);
plot_state_controls('BFGS with FD',X,U);

