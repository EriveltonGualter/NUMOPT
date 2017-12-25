
% testing the different functions
clear variables; close all; clc

% number of discretization steps
param.N = 50;

% init condition
param.x0 = 2;

% terminal time
param.T  = 5;

% terminal weight
param.q  = 50;

% interval length
h = param.T/param.N;

% random control trajectory
Utst = rand(param.N,1);

% a) finite differences on nonlinear part 
[F1, J1] = finite_difference(@Phi, Utst, param);
J1 = 2*sum(Utst) + J1;  % add derivative of the quadratic term

% b) imaginary trick 
[F2, J2] = i_trick(@Phi, Utst, param);
J2 = 2*sum(Utst) + J2;   % add derivative of the quadratic term

% d) forward AD
[F3, J3] = Phi_FAD(Utst, param);

% e) backward AD
[F4, J4] = Phi_BAD(Utst, param);

% check results
disp('Error between imaginary trick and finite differences:')
disp(' ')
disp(max(max(abs(J2-J1))))

disp('Error between imaginary trick and forward AD:')
disp(' ')
disp(max(max(abs(J2-J3))))

disp('Error between imaginary trick and backward AD:')
disp(' ')
disp(max(max(abs(J2-J4))))


