% Clean workspace
clear variables; close all; clc

% Add casadi installation path:
addpath('/Applications/MATLAB_R2017b.app/casadi-matlabR2015a-v3.3.0');

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
for i=1:N-1
    f = f +...
        .5*Di*((y(i) - y(i+1))^2 + (z(i) - z(i+1))^2) +...
        g0*mi*z(i);
end
f = f + g0*mi*z(N);  % add last term

% Define nonlinear constraints 
% TODO WRITE CASADI EXPRESSION FOR NONLINEAR CONSTRAINTS (IN ONE COMMAND)
g = z + y.^2;

% Create NLP and solver object
%
% ----------------------------
%  min f
%  s.t lbx <= x <= ubx
%      lbg <= g <= ubg
% ----------------------------

nlp    = struct('x', [y;z], 'f', f, 'g', g);
solver = nlpsol('solver', 'ipopt', nlp);

% Setup bounds on variables and nonlinear constraints
% TODO SETUP BOUNDS (FIXED END POINTS CAN BE EXPRESSED BY APPROPRIATE lbx ubx VALUES)
lbx = -inf(2*N,1);
ubx =  inf(2*N,1);
lbg = 0;
ubg = inf;

% y1, yN:
lbx(1) = -2;
ubx(1) = -2;
lbx(N) = 2;
ubx(N) = 2;

% z1, zN:
lbx(N+1) = 1;
ubx(N+1) = 1;
lbx(2*N) = 1;
ubx(2*N) = 1;

% Solve NLP:
res  = solver('lbx', lbx, 'ubx', ubx, 'lbg', lbg, 'ubg', ubg);
sol  = full(res.x);
ysol = sol(1:N);
zsol = sol(N+1:end);

% Plot chain:
figure(1)
plot(ysol, zsol,'b--');hold on;
plot(ysol, zsol, 'Or'); hold off;
title('Optimal position of chain');
xlabel('y');
ylabel('z');
% Place second axis:
a1Pos = get(gca,'Position');
ax2 = axes('Position',[a1Pos(1) a1Pos(2)-.05 a1Pos(3) a1Pos(4)],...
           'Color','none','YTick',[],'YTickLabel',[]);
xlim([0 length(ysol)]);
xlabel('#Chain');

% Identify active set of the solution:
h = @(y,z) (z+y.^2);
epsilon = 1e-8;
A = find(abs(h(ysol,zsol)) <= epsilon)';  % active set of the solution
disp('Active set:');
disp(A);
disp(' ');

% Gradient of equality and inequality constraints:

% equality constraint gradient (why it is eye see written solution):
grad_g = eye(2,2);
% inequality constraint gradient (why it is eye see written solution):
grad_h = [2*diag(ysol); eye(N,N)];

% Proove if LICQ holds:
% 1) Do not need to test gard_g on rank, since
%    indexes 1 and N are not in active set:
% rank_grad_g = rank(grad_g);

% 2) Get only columns with active set from grad_h and find its rank:
grad_h_activeSet = grad_h(:,A);
if rank(grad_h_activeSet) == size(grad_h_activeSet,2)
    disp('LICQ holds!');
else
    disp('LICQ does NOT holds!');
end
disp(' ');

% Lagrangian:
g = [y(1) + 2;
     z(1) - 1;
     y(N) - 2;
     z(N) - 1];
h = z + y.^2;

mu = MX.sym('mu', 1);
L = f - mu * h;
J = jacobian(L,mu);
H = jacobian(J,mu);



