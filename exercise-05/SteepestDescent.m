function [z_log] = SteepestDescent(alpha)
% Implemets steepest descent method for the function:
% f(x,y) = 0.5*((x-1)^2+100*(y-x^2)^2+y^2)

% Jacobian:
J = @(x,y) [200*x^3-200*x*y+x-1;...
            -100*x^2+101*y];

% Find minimum of function:
xk = [-1;-1];  % initial point
t = Inf;       % termination condition
z_log = [];    % steps logger
while t > 10^(-3)
    z_log = [z_log, xk];
    pk = J(xk(1),xk(2))/alpha;
    xk1 = xk - pk;
    xk = xk1;
    t = norm(J(xk(1),xk(2)));
end
z_log = z_log';
end



