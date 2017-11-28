function [z_log] = NewtonRoot(w0, type, n)
% Implements newton root finding porblem for F(w) = w^16-2
% s.t. F(w) = 0.
%
%   Inputs:
%       w0 - initial guess
%       type - gradient type: (use 'fixed' for fixed gradient
%                              and something others for unfixed)
%       n - maximal number of iterations

N = n;  % default number on iterations

% Function itself:
F = @(w) (w^16 - 2);

% Jacobian:
M = @(w) 16*w^15;

% Find minimum of function:
wk = w0;       % initial point
z_log = zeros(max(size(w0)),N);  % allocate logger array
for i=1:N
    z_log(:,i) = wk;
 
    MM = M(wk);
    if strcmp(type,'fixed')
        MM = M(w0);
    end
    wk1 = wk - MM\F(wk);
    wk = wk1;
    if norm(F(wk)) <= 10^(-3)
        break;
    end
end
z_log = z_log(:,1:i)';  % return only iteraded values
end

