function [f] = chain_objective(x,param)
% Objective function of the chain.
%   Input:
%       x - a point ordered as: x = [y1^T,...yN^T,z1^T,...,zN^T]^T
%       param - the structure with parameters
%   Output:
%       f - chain objective function
%

f = param.g * param.m * sum(x(param.N+1:end));

end

