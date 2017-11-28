function [z_log] = GN()
% Implemets Gauss-Newton method for the function:
% f(x,y) = 0.5*((x-1)^2+100*(y-x^2)^2+y^2)

% Residual function R:
R = @(x,y) [x-1;...
            10*(y-x^2);...
            y];

% Jacobian of R:
JR = @(x,y) [[1, 0];...
            [-20*x, 10];...
            [0, 1]];
        
% Jacobian:
J = @(x,y) JR(x,y)'*R(x,y);

% Hessian:
B = @(x,y) JR(x,y)'*JR(x,y);

% Find minimum of function:
z_log = newton_optimizer([-1;1],J,B,10000);
end

