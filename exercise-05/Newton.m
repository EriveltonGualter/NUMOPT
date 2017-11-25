function [z_log] = Newton()
% Implemets Newton method with exact hessian for 
% function:
% f(x,y) = 0.5*((x-1)^2+100*(y-x^2)^2+y^2)

% Jacobian:
J = @(x,y) [200*x^3-200*x*y+x-1;...
            -100*x^2+101*y];

% Hessian:
B = @(x,y) [[600*x^2-200*y+1, -200*x];...
            [-200*x, 101]];

% Find minimum of function:
xk = [-1;-1];  % initial point
t = Inf;       % termination condition
z_log = [];    % steps logger
while t > 10^(-3)
    z_log = [z_log, xk];
    pk = B(xk(1),xk(2))\J(xk(1),xk(2));
    xk1 = xk - pk;
    xk = xk1;
    t = norm(J(xk(1),xk(2)));
end
z_log = z_log';
end

