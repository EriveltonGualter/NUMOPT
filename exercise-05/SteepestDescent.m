function [z_log] = SteepestDescent(alpha)
% Implemets steepest descent method for the function:
% f(x,y) = 0.5*((x-1)^2+100*(y-x^2)^2+y^2)

% Jacobian:
J = @(x,y) [200*x^3-200*x*y+x-1;...
            -100*x^2+101*y];

% Hessian:
B = @(x,y) alpha*eye(2);

% Find minimum of function:
z_log = newton_optimizer([-1;1],J,B,10000);
end



