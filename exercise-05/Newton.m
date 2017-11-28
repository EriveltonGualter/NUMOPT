function [z_log] = Newton()
% Implemets Newton method with exact hessian for 
% function:
% f(x,y) = 0.5*((x-1)^2+100*(y-x^2)^2+y^2)

N = 4000;  % default number on iterations

% Jacobian:
J = @(x,y) [200*x^3-200*x*y+x-1;...
            -100*x^2+101*y];

% Hessian:
B = @(x,y) [[600*x^2-200*y+1, -200*x];...
            [-200*x, 101]];

% Find minimum of function:
z_log = newton_optimizer([-1;1],J,B,10000);
end

