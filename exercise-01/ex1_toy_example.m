clc;
close all;
clear variables;
	
% define variables
x = sdpvar(1,1);
y = sdpvar(1,1);

% define objective
f = x^2 - 2*x + y^2 + y;

% define constraints
C = [];
C = [C; x >= 1.5; x + y >= 0];

% define solver
options = sdpsettings('solver', 'quadprog','verbose',2);

% solve optimization problem
diagn = optimize(C, f, options);

% read and print solution
xopt = double(x);
yopt = double(y);

disp(' ')
if diagn.problem == 0
    disp(['Optimal solution found: x = ', num2str(xopt(1)),...
          '; y= ', num2str(yopt(1))]);
else
    disp('Problem failed')
end

% Plot objective:
syms ff(xx,yy);
ff(xx,yy) = xx^2 - 2*xx + yy^2 + yy;
fsurf(ff);
xlabel('x');
ylabel('y');
zlabel('f');
hold('on');

plot3(xopt(1), yopt(1), xopt(1)^2 - 2*xopt(1) + yopt(1)^2 + yopt(1), '*');
hold('off');