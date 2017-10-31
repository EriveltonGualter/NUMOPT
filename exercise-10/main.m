% Clean workspace
clear all; close all; clc

% Import casadi module 
% (add first casadi folder and subfolders to matlab path) 
import casadi.*

% Simulation parameters
N  = 40;
mi = 4/N;
Di = (70/40)*N;
g0 = 9.81;

% Declare symbolic variables
y = MX.sym('y',N);
z = MX.sym('z',N);
x = [y;z];

% Build objective
f = 0;
% TODO WRITE CASADI EXPRESSION FOR OBJECTIVE (IN FOR LOOP: f = f + ...)

% Define nonlinear constraints 
% TODO WRITE CASADI EXPRESSION FOR NONLINEAR CONSTRAINTS (IN ONE COMMAND)
g = ...

% Create NLP and solver object
%
% ----------------------------
%  min f
%  s.t lbx <= x <= ubx
%      lbg <= g <= ubg
% ----------------------------

nlp    = MXFunction('nlp', nlpIn('x',[y;z]),nlpOut('f',f,'g',g));
solver = NlpSolver('solver','ipopt', nlp);

% Setup bounds on variables and nonlinear constraints
% TODO SETUP BOUNDS (FIXED END POINTS CAN BE EXPRESSED BY APPROPRIATE lbx ubx VALUES)
lbx = -inf(2*N,1);
ubx =  inf(2*N,1);
lbg = ...
ubg = ...

lbx(1)   = -2;
ubx(1)   = -2;
...

% Setup structure of NLP parameters
arg     = struct;
arg.lbx = lbx; 
arg.ubx = ubx; 
arg.lbg = lbg;
arg.ubg = ubg;

% Solve NLP
res  = solver(arg);
sol  = full(res.x);
ysol = sol(1:N);
zsol = sol(N+1:end);

% Plot chain
figure(1)
plot(ysol, zsol,'b--');hold on;
plot(ysol, zsol, 'Or'); hold off;
title('Optimal position of chain')
xlabel('y')
ylabel('z')
