clc;
close all;
clear variables;

N = 40;

% TODO: complete the definition of variables HERE
y = sdpvar(1,N);
z = sdpvar(1,N);

m = 4/N;
D = 70;
g0 = 9.81;

V_el_sum = 0;
V_g_sum = 0;
for i = 1:N-1
    % TODO: complete the objective function (i.e. potential energy) HERE
    V_el_i = D * ((y(1,i) - y(1,i+1))^2 + (z(1,i) - z(1,i+1))^2);
    V_el_sum = V_el_sum + V_el_i;
    
    V_g_i = z(1,i);
    V_g_sum = V_g_sum + V_g_i;
end
Vchain = 0.5 * V_el_sum + m * g0 * (V_g_sum + z(1,N));

% TODO: complete the (equality) constraints HERE
constr = [];
constr = [constr;...
          y(1,1) == -2;...
          z(1,1) == 1;...
          y(1,N) == 2;...
          z(1,N) == 1];

% Add additional constraints:
for i=1:N
    constr = [constr;...
              z(1,i) >= -y(1,i)^2];  % b)
              % z(1,i) >= -0.2 + 0.1 * y(1,i)^2];  % a)
              % z(1,i) >= 0.5; z(1,i) - 0.1 * y(1,i) >= 0.5];  % linear
end

% Set options and solve the problem with quadprog:
assign(y,-1);  % c)
options = sdpsettings('solver', 'fmincon','verbose',2,'usex0',1);
diagn   = optimize(constr, Vchain, options);

% get solution and plot results
Y = double(y); Z = double(z);

disp(' ')
if diagn.problem == 0
    disp('Optimal solution found');
else
    disp('Problem failed');
    disp(diagn.info);
    disp(yalmiperror(diagn.problem));
end

figure('Name', 'Graphical representation of solution');
plot(Y,Z,'--or'); hold on;
plot(-2,1,'xg','MarkerSize',10);
plot(2,1,'xg','MarkerSize',10);
xlabel('y'); ylabel('z');
grid('on');
title('Optimal solution hanging chain')

