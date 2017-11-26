function [z_log] = NewtonRootLifted(w0)
% Implements newton root finding porblem for F(w) = w^16-2
% s.t. F(w) = 0.
%
%   Inputs:
%       w0 - initial guess as 4x1 vector
%       type - gradient type: (use 'fixed' for fixed gradient
%                              and something others for unfixed)

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
t = Inf;       % termination condition
z_log = [];    % steps logger
while t > 10^(-3)
    z_log = [z_log, wk];
    wk1 = wk - M(wk)\F(wk);
    wk = wk1;
    t = norm(F(wk));
end
z_log = z_log';
end



