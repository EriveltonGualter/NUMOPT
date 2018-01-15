function [J] = chain_eval_constraints_jacobian(x, param)
% Evaluates Jacobian of chain problem constraints at given 
% point x.
%   Input:
%       x - a point ordered as: x = [y1^T,...yN^T,z1^T,...,zN^T]^T
%       param - the structure with parameters
%   Output:
%       J - jacobian of constraints at point x
%  

J = 0;
end

