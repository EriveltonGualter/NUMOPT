function [F,J] = Phi_FAD(U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

X    = zeros(N+1,1);
X(1) = x0;
for k = 1:N
    X(k+1) = X(k) + h*((1 - X(k))*X(k) + U(k));
end

F = q*X(end).^2;
J = 0;

end

