function [z_log] = newton_optimizer(x0,J,B,n)
% Optimize numerical function according to it Jacobian
% and gradient:
%
%   Inputs:
%       x0 - initial point as 2x1 vector
%       J - Jacobian as 2x1
%       B - Gradient as 2x2

N = n;                           % maximal number of iterations
z_log = zeros(max(size(x0)),N);  % allocate logger array
xk = [x0(1);x0(2)];              % initial point
for i=1:N
    z_log(:,i) = xk;
    
    pk = B(xk(1),xk(2))\J(xk(1),xk(2));
    xk1 = xk - pk;
    xk = xk1;
    if norm(J(xk(1),xk(2))) <= 10^(-3)
        break;
    end
end
z_log = z_log(:,1:i)';  % return only iteraded values
end

