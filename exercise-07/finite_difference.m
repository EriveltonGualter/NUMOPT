function [F, J] = finite_difference(hc_fun, x, param)
% Calculates function value F and the Jacobian J of function fun at x
% using finite differences

F = hc_fun(x,param);

t = sqrt(eps);  % iteration step
J = zeros(length(x),1);
for i=1:length(x)
    p = zeros(length(x),1);
    p(i) = 1;
    J(i) = (hc_fun(x+t*p,param) - F)/t;
end
end

