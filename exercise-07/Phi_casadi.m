function [ F ] = Phi_casadi(U,param)
% Function evaluation of the nonlinear function in the objective based on
% elementary operations

X = zeros(param.N+1,1);
X(1) = param.x0;
for k = 1:param.N
    X(k+1) = X(k) + param.h*X(k) - param.h*X(k)^2 + param.h*U(k);
end
F = U'*U + param.q*X(end)^2;
end