% NUMOPT, WS17/18
% Copyright: Alexander Kozhinov
%            AlexanderKozhinov@yandex.com

clc;
close all;
clear variables;

% Test derivatives:
disp('*** Testing derivatives ***');
test_derivatives(50);

% Runtime of methods:
disp('*** Derivatives runtime ***')
test_derivatives(200);

% Solve optimization problem:
param.N = 200;  % number of discretization steps
param.x0 = 2;  % init condition
param.T  = 5;  % terminal time
param.q  = 50;  % terminal weight
h = param.T/param.N;  % interval length
U = rand(param.N,1);  % random control trajectory

[F1, J1] = finite_difference(@Phi, U, param);
J1 = 2*sum(U) + J1;   % add derivative of the quadratic term

X    = zeros(param.N+1,1);
X(1) = param.x0;
for k = 1:param.N
    X(k+1) = X(k) + h*((1 - X(k))*X(k) + U(k));
end

plot_state_controls('Finite Differences',X,U);

