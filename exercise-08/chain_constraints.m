function [C,Ceq] = chain_constraints(x,param)
% Implements N+3(+1 in case of additional mass)
% nonlinear equality constraints.
%   Input:
%       x - a point ordered as: x = [y1^T,...yN^T,z1^T,...,zN^T]^T
%       param - the structure with parameters
%   Output:
%       f - chain objective function
%

N = param.N;

% Number of total constraints (N-1 + 4 + 2):
% N-1 - nonlinear constraints
% 4 - constraints for (y1,z1), (yN,zN)
% 2 - constraint for fixed mass xFixed = (yFixed, zFixed) (only if nFixed <= 0)  

y = x(1:N);
z = x(N+1:end);

C = [];  % no inequality constraints

% Define equality constraints:
Li = param.L/(N - 1);  % length of i-th chain element 

Ceq = [];

Ceq = [Ceq; (y(1:N-1) - y(2:N)).^2 + (z(1:N-1) - z(2:N)).^2 - Li^2];

Ceq = [Ceq; y(1) - param.xi(1)];
Ceq = [Ceq; y(N) - param.xf(1)];

Ceq = [Ceq; z(1) - param.xi(2)];
Ceq = [Ceq; z(N) - param.xf(2)];

% Fixed mass constraint:
if param.nFixed > 0  % fixed point
    % Last two constraints are needed:
    Ceq = [Ceq; y(param.nFixed) - param.xFixed(1)];
    Ceq = [Ceq; z(param.nFixed) - param.xFixed(2)];
end  

end

