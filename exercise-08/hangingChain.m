% Numerical Optimizations WS17/18
% Copyright: Alexander Kozhinov, AlexanderKozhinov@yandex.com
% Date: 15.01.2018

clc; close all; clear variables;

%% Parameters and starting definitions of the chain:
% Define nFixed <= 0 to avoid point fixing
param = struct('N',23,'L',5,'m',.2,'g',9.81,'xi',[-2 1],'xf',[2 1],...
               'nFixed',0,'xFixed',[0 1]);

% Fixed points:
y = linspace(param.xi(1),param.xf(1),param.N)';
z = linspace(param.xi(2),param.xf(2),param.N)';

% % LICQ violation fixing point:
% param.nFixed = param.N - 1;
% param.xFixed = [param.L/(param.N - 1) 1];
%       or
% % Some fun fixing point:
% param.nFixed = 12;
% param.xFixed = [0.1 .8];

if param.nFixed > 0  % need of fixed constraints
    y(param.nFixed) = param.xFixed(1);
    z(param.nFixed) = param.xFixed(2);
end

% Initial conditions of chain ends:
y(1) = param.xi(1);  % y1
z(1) = param.xi(2);  % z1

y(end) = param.xf(1);  % yN
z(end) = param.xf(2);  % zN

% Stack optimization paremeters together:
x = [y;z];

%% Solve the chain problem with fmincon:
% Objective function:
objFun = @(x)(chain_objective(x,param));

% Nonlinear constraints:
nonLinConstr = @(x)(chain_constraints(x,param));

% Load default options for fmincon:
opts = optimoptions('fmincon');

% Define maximal number of iterations:
opts.MaxFunEvals = 5000;
options.StepTolerance = 1e-6;
options.FunctionTolerance = 1e-6;

% Call fmincon:
[x,~,~,~,lambdas] = fmincon(objFun,x,[],[],[],[],[],[],...
                                nonLinConstr,opts);

% Evaluate Jacobian of constraints at the optimal solution:
[~,Ceq] = chain_constraints(x,param);  % get equality constraints only
grad_g = chain_eval_constraints_jacobian(x,param);

% Check wether LICQ holds:
disp('Check LICQ:');
if rank(grad_g) == size(Ceq,1)
    disp(['LICQ holds: rank(grad_g) = ', num2str(rank(grad_g)),...
          ' == #Ceq = ', num2str(size(Ceq,1))]);
else
    disp(['LICQ NOT holds: rank(grad_g) = ', num2str(rank(grad_g)),...
          ' != #Ceq = ', num2str(size(Ceq,1))]);
end

% Plot the results:
plot_chain(x(1:param.N),x(param.N+1:end),param);








