function [J] = chain_eval_constraints_jacobian(x, param)
% Evaluates Jacobian of chain problem constraints at given 
% point x.
%   Input:
%       x - a point ordered as: x = [y1^T,...yN^T,z1^T,...,zN^T]^T
%       param - the structure with parameters
%   Output:
%       J - jacobian of constraints at point x
%  

N = param.N;

xsym = sym('x',[2*N;1]);
[~, CeqSym] = chain_constraints(xsym, param);
J = jacobian(CeqSym, xsym);
J = subs(J, xsym, x);

end

