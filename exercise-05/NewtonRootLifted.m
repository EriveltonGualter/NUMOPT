function [z_log] = NewtonRootLifted(w0, n)
% Implements newton root finding porblem for F(w) = w^16-2
% s.t. F(w) = 0.
%
%   Inputs:
%       w0 - initial guess as 4x1 vector
%       type - gradient type: (use 'fixed' for fixed gradient
%                              and something others for unfixed)

N = n;  % maximal number of iterations

% Function itself:
F = @(w) [w(2) - w(1)^2;...
          w(3) - w(2)^2;...
          w(4) - w(3)^2;...
          -2 -   w(4)^2];

% Jacobian:
M = @(w) [-2*w(1), 0, 0, 0;...
          1, -2*w(2), 0, 0;...
          0, 1, -2*w(3), 0;...
          0, 0, 1, -2*w(4)];

% Find minimum of function:
wk = w0;       % initial point
z_log = zeros(max(size(w0)),N);  % allocate logger array
f_log = [];
for i=1:N
    z_log(:,i) = wk;
 
    pk = M(wk)\F(wk);
    wk1 = wk - pk;
    wk = wk1;

    f_log = [f_log, norm(wk)];
    if norm(wk) <= 10^(-3)
        break;
    end
end
z_log = z_log(:,1:i)';  % return only iteraded values
end



