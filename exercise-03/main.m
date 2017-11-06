% Copyright: Alexander Kozhinov, 2017
clc;
close all;
clear variables;
addpath('./helper functions');

D = load_data();

% Constants:
n = 6;   % number of nodes
m = 10;  % number of bars
x_max = 200;
V_max = 10^5;

% Optimization variables:
a = sdpvar(1,1);  % alpha
x = sdpvar(1,m);  % cross-sectional area

% Stifness matrix and it's components:
[KLMI, K, Le] = calculate_stiffness(D);

% Constraints:
C = [];
V_sum = 0;  % sum of partial volumes
% K_x = zeros(size(KLMI(:,:,1)));
for i=1:m
    C = [C; 0 <= x(1,i) <= x_max];   % constraint 1c)
    V_sum = V_sum + Le(i) * x(1,i);  % constraint 1d)
    
    % K_x = K_x + KLMI(:,:,i) * x(1,i);
end
C = [C; V_sum <= V_max];
C = [C; [a D.Fext'; D.Fext K] >= 0];

% Optimization part:
opt = sdpsettings('solver','SDPT3','verbose',2,'showprogress',0);
diagn = optimize(C, a, opt);
disp(' ');
if diagn.problem == 0
    disp('Optimal solution found');
else
    disp('Problem failed');
    disp(diagn);
end

% Plot results:
plot_structure(D, K);



