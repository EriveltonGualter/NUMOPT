function [F,J] = Phi_FAD(U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

X    = zeros(N+1,1);
W    = zeros(N+1,1);  % dot quantities
X(1) = x0;
W(1) = 1;  % derivative over x0
for k = 1:N
    X(k+1) = X(k) + h*((1 - X(k))*X(k) + U(k));
    
    W(k+1) = 1 + h*(1-2*X(k));
end

F = q*X(end).^2;
J = q*2*W(1:end-1);

end

