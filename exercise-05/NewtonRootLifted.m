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
F = @(w) (+1)*[w(2) - w(1)^2;...
               w(3) - w(2)^2;...
               w(4) - w(3)^2;...
               2    - w(4)^2];  % do mot converge with -2

% Jacobian:
M = @(w) (+1)*[-2*w(1), 1, 0, 0;...
               0, -2*w(2), 1, 0;...
               0, 0, -2*w(3), 1;...
               0, 0, 0, -2*w(4)];

% Find minimum of function:
wk = w0;       % initial point
z_log = zeros(max(size(w0)),N);  % allocate logger array

for i=1:N
    z_log(:,i) = wk;

    pk = M(wk)\F(wk);
    wk1 = wk - pk;
    wk = wk1;
    
    if norm(pk) <= 10^(-3)  % break if no changes in steps
        break;
    end
end
z_log = z_log(:,1:i)';  % return only iterated values
end



