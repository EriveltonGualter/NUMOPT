function [F, J] = finite_difference(hc_fun, x, param)
% Calculates function value F and the Jacobian J of function fun at x
% using finite differences

F = hc_fun(x, param);
J = 0;
end

