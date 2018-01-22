
% Derivatives using CASADI
clear variables; close all; clc

% Add casadi installation path:
addpath('/Applications/MATLAB_R2017b.app/casadi-matlabR2015a-v3.3.0');

% Import module (add casadi folder and subfolders in matlab path before): 
import casadi.*

% Setup problem parameters:
param.N  = 200;
param.x0 = 0.6;
param.T  = 5;
param.q  = 80;
param.h = param.T/param.N;

% Generate random control trajectory:
Utst = rand(param.N,1);

% Declare symbolic variables:
U = MX.sym('u',param.N);

% TODO: Build Phi expression:
Phi_expr = Phi_casadi(U,param);

Phi_function = Function('Phi',{U},{Phi_expr});
J_function   = Function('J',{U},{jacobian(Phi_expr,U)});

Phitst = Phi_function(Utst);
F1 = full(Phitst);
J1 = J_function(Utst);
J1 = full(J1)';

% Compare accuracy with imaginary trick:
[F2, J2] = i_trick(@Phi, Utst, param);

disp('Function values: ');
disp(['Im Trick: F1 = ', num2str(F1)]);
disp(['CasADi:   F2 = ', num2str(F2)]);
disp(' ');
disp(['Error between imaginary trick and casadi: ',...
      num2str(max(max(abs(J1-J2))))])
disp(['Im Trick: J1 = ', num2str(max(abs(J1)))]);
disp(['CasADi:   J2 = ', num2str(max(abs(J2)))]);

% Plot Jacobians:
figure('Name','CasADi vs. Im-Trick');
plot(J1);
hold('on');
plot(J2);
xlabel('#Elem');
ylabel('Value of Jacobian');
legend('J1 - Im-Trick','J2 - CasADi','Location','best');



