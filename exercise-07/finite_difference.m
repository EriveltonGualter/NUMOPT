function [F, J] = finite_difference(hc_fun, x, param)
% Calculates function value F and the Jacobian J of function fun at x
% using finite differences

F = hc_fun(x,param);

t = sqrt(eps);  % iteration step
J = zeros(length(x),1);
for i=1:length(x)
    xtp = x;  % x+t*p
    xtp(i) = x(i) + t;
    J(i) = (hc_fun(xtp,param) - F)/t;
end
end

