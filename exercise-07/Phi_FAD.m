function [F,J] = Phi_FAD(hc_fun, U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

X    = zeros(N,1);
W    = zeros(N,1);  % dot quantities
X(1) = x0;
W(1) = 0;
for k = 1:N-1
    X(k+1) = (1+h)*X(k) - h*X(k)^2 + h*U(k);
    W(k+1) = h;
end

% Function evaluation:
F = q*X(end)^2;

% Add derivative of the quadratic term:
J = 2*U + W;

end

