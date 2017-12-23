function [F, J] = finite_difference(hc_fun, x, param)
% Calculates function value F and the Jacobian J of function fun at x
% using finite differences

F = hc_fun(x,param);

t = sqrt(eps);  % iteration step
J = zeros(length(x),1);
for i=1:length(x)
    xt = x;  % step with size t
    xt(i) = x(i) + t;
    J(i) = (hc_fun(xt,param) - F)/t;
end
end

