clc;
close all;
clear variables;

N = 40;
L = 1;  % chain total length: 1m

% TODO: complete the definition of variables HERE
y = sdpvar(1,N);
z = sdpvar(1,N);
s = sdpvar(1,N);

m = 4/N;
D = 70;
g0 = 9.81;

V_el_sum = 0;
V_g_sum = 0;
L_i = L / (N - 1);
for i = 1:N-1
    % TODO: complete the objective function (i.e. potential energy) HERE
    V_el_i = D * s(1,i)^2;
    V_el_sum = V_el_sum + V_el_i;
    
    V_g_sum = V_g_sum + z(1,i);
end
Vchain = 0.5 * V_el_sum + m * g0 * (V_g_sum + z(1,N));

% TODO: complete the (equality) constraints HERE
constr = [];
constr = [constr;...
          y(1,1) == -2;...
          z(1,1) == 1;...
          y(1,N) == 2;...
          z(1,N) == 1];
for i=1:N-1
    constr = [constr;...
        s(1,i) >= sqrt((y(1,i) - y(1,i+1)).^2 +...
                       (z(1,i) - z(1,i+1)).^2) - L_i;
        s(1,i) >= 0];
end
constr = [constr; s(1,N) >= 0];

% Set options and solve the problem with quadprog:
assign(y,0);
assign(z,0);
options = sdpsettings('solver','SDPT3','verbose',2,'usex0',1,...
                      'showprogress',0);
diagn   = optimize(constr, Vchain, options);

% get solution and plot results
Y = double(y);
Z = double(z);
S = double(s);

disp(' ')
if diagn.problem == 0
    disp('Optimal solution found');
else
    disp('Problem failed');
    disp(diagn);
end

figure('Name', 'Graphical representation of solution');
plot(Y,Z,'--or'); hold on;
plot(-2,1,'xg','MarkerSize',10);
plot(2,1,'xg','MarkerSize',10);
xlabel('y'); ylabel('z');
grid('on');
title('Optimal solution hanging chain')

