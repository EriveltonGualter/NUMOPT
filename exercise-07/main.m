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