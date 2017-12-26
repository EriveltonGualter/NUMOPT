
% Derivatives using CASADI
clear variables; close all; clc

% Import module (add casadi folder and subfolders in matlab path before)
addpath('/Applications/MATLAB_R2017b.app/casadi-matlabR2015a-v3.3.0');
import casadi.*

% Setup problem parameters
param.N  = 50;
param.x0 = 2;
param.T  = 5;
param.q  = 50;
h = param.T/param.N;

% % Generate random control trajectory
% Utst = rand(param.N,1);
% 
% % Declare symbolic variables
% U  = MX.sym('u',param.N);
% 
% % TODO: build Phi expression
% Phi_expr = 1;
% 
% Phi_function = MXFunction('Phi',{U},{Phi_expr});
% J_function   = MXFunction('J',{U},{jacobian(Phi_expr,U)});
% 
% Phitst = Phi_function({Utst});
% F1 = full(Phitst{1});
% J1 = J_function({Utst});
% J1 = full(J1{1});
% 
% % Compare accuracy with imaginary trick
% [F2, J2] = i_trick(@Phi, Utst, param);
% 
% disp('Error between imaginary trick and casadi:')
% disp(' ')
% disp(max(max(abs(J1-J2))))
