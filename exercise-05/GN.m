function [z_log] = GN()
% Implemets Gauss-Newton method for the function:
% f(x,y) = 0.5*((x-1)^2+100*(y-x^2)^2+y^2)

% Residual function R:
R = @(x,y) [x-1;...
            10*(y-x^2);...
            y];
% Jacobian of R:
J = @(x,y) [[1, 0];...
            [-20*x, 10];...
            [0, 1]];

% Find minimum of function:
xk = [-1;-1];  % initial point
t = Inf;       % termination condition
z_log = [];    % steps logger
while t > 10^(-3)
    z_log = [z_log, xk];
    JJ = J(xk(1),xk(2));
    grad = (JJ'*R(xk(1),xk(2)));  % gradient
    pk = (JJ'*JJ)\grad;
    xk1 = xk - pk;
    xk = xk1;
    t = norm(grad);
end
z_log = z_log';
end

