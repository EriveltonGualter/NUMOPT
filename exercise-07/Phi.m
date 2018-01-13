function [ F ] = Phi( U, param )

% Function evaluation of the nonlinear function in the objective based on
% elementary operations

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

X = zeros(N+1,1);
X(1) = x0;
for k = 1:N
    X(k+1) = X(k) + h*((1 - X(k))*X(k) + U(k));
end

F = U'*U + q*X(end).^2;

end

