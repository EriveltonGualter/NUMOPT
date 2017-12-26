function [F, J] = i_trick(hc_fun, x, param)
% Computes Jacobian J of Function hc_fun using MATLAB's
% imaginyry trick.

F = hc_fun(x,param);

t = 1e-100;  % can be choosen very small due to no cancellation in numerator
J = zeros(length(x),1);
for i=1:length(x)
    p = zeros(length(x),1);
    p(i) = 1;
    J(i) = imag(hc_fun(x+1j*t*p,param))/t;
end
J = 2*x + J;   % add derivative of the quadratic term
end

