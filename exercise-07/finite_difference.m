function [F, J] = finite_difference(hc_fun, u, param)
% Calculates function value F and the Jacobian J of function fun at x
% using finite differences

F = hc_fun(u,param);

N = param.N;
t = sqrt(eps);  % iteration step
J = zeros(N,1);
for i=1:N
    p = zeros(N,1);
    p(i) = 1;
    J(i) = (hc_fun(u+t*p,param) - F)/t;
end

% Add derivative of the quadratic term:
J = 2*u + J;
end

