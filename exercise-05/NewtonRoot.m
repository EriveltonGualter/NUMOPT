function [z_log] = NewtonRoot(w0, type)
% Implements newton root finding porblem for F(w) = w^16-2
% s.t. F(w) = 0.
%
%   Inputs:
%       w0 - initial guess
%       type - gradient type: (use 'fixed' for fixed gradient
%                              and something others for unfixed)

% Function itself:
F = @(w) (w^16 - 2);

% Jacobian:
M = @(w) 16*w^15;

% Find minimum of function:
wk = w0;       % initial point
t = Inf;       % termination condition
z_log = [];    % steps logger
while t > 10^(-3)
    z_log = [z_log, wk];
    MM = M(wk);
    if strcmp(type,'fixed')
        MM = M(w0);
    end
    wk1 = wk - MM\F(wk);
    wk = wk1;
    t = F(wk);
end
z_log = z_log';
end

