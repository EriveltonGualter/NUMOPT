function [y, y_o, x] = create_data(N, n, v, x_bounds, s)
% CREATE_DATA
%   Input parameters:
%       N - number of points (scalar)
%       n - number of outliers (scalar)
%       v - vector with a, b coeffitients: [a; b] (2 x 1)
%       x_bounds = [x_l; x_u] - upper and lower bound on x-axis:
%                               (2 x 1)
%       s - standart deviation of gaussian noise
%       
%   Output parameters:
%       y - output data: y = a * x + b with Gaussian noise (Nx1 - vector)
%       y_o - same as y but with n outliers generated randomly
%             (Nx1 - vector)
%       x - x-axis data (Nx1 - vector)

x = linspace(x_bounds(1),x_bounds(2),N)';
noise = sqrt(s) * randn(N,1);

y = v(1) * x + v(2) + noise;
y_o = v(1) * x + v(2) + noise;

% Introduce outliers:
idxs = randperm(N)';  % get three random indexes
idxs = idxs(1:n);     % take first three ones

A = 1.2 * (randn(n,1).*(randperm(n)'));  % amplitude of outliers
y_o(idxs) = A.*y_o(idxs);

end

