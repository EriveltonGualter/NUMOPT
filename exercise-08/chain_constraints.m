function [C,Ceq] = chain_constraints(x,param)
% Implements N+3(+1 in case of additional mass)
% nonlinear equality constraints.
%   Input:
%       x - a point ordered as: x = [y1^T,...yN^T,z1^T,...,zN^T]^T
%       param - the structure with parameters
%   Output:
%       f - chain objective function
%

% Number of total constraints (N-1 + 4 + 2):
% N-1 - nonlinear constraints
% 4 - constraints for (y1,z1), (yN,zN)
% 2 - constraint for fixed mass xFixed = (yFixed, zFixed) (only if nFixed <= 0)
numConstr = param.N+5;

if param.nFixed <= 0  % no fixed point
    numConstr = param.N+3;  % last two constraints are not needed
end  

y = x(1:param.N);
z = x(param.N+1:end);

C = [];  % no inequality constraints

% Define equality constraints:
Li = param.L/(param.N - 1);  % length of i-th chain element
Ceq = zeros(numConstr,1);

for i=1:param.N-1
    Ceq(i) = (y(i) - y(i+1))^2 + (z(i) - z(i+1))^2 - Li^2;
end

Ceq(param.N) = y(1) - param.xi(1);
Ceq(param.N+1) = y(param.N) - param.xf(1);

Ceq(param.N+2) = z(1) - param.xi(2);
Ceq(param.N+3) = z(param.N) - param.xf(2);

% Fixed mass constraint:
if param.nFixed > 0  % fixed point
    % Last two constraints are needed:
    Ceq(param.N+4) = y(param.nFixed) - param.xFixed(1);
    Ceq(param.N+5) = z(param.nFixed) - param.xFixed(2);
end  

end

