function [x, u] = BFGS(J_func, obj, param, maxIter, TOL)
% Solve problem with BFGS method:
%   Input:
%       J_func - function for Jacobian calculation
%       obj - objective function
%       U - control vector to optimize
%       param - problem parameter
%       maxIter - maximal number of iterations
%       TOL - if norm(J) <= TOL ==> convergence reached.

% Allocate state and control vectors:
N = param.N;
u = zeros(N,1);

% Initial Jacobian:
[F, J] = J_func(obj, u, param);

% Initial Hessian approximation
B = eye(length(u));

for k=1:maxIter
    % Break if TOL reached:
    % disp(['#Iter: ', num2str(k),'; norm(J) = ', num2str(norm(J))]);
    if norm(J) < TOL
        disp(['BFGS: Convergence achieved. #Iter: ',...
              num2str(k), ' of ', num2str(maxIter)]);
        break;
    end
    
    % Obtain search direction using current B und J:
    p = (-1)*(B\J);
    
    % Parameters for backtracking with Armijo's condition
    t     = 1.0;    % initial step length
    beta  = 0.8;    % shrinking factor (default: 0.8)
    gamma = 0.1;    % minimal decrease requirement
    
    u_new = u + t*p;  % candidate for the next step
    
    % Backtracking with Armijo's condition
    % (keep shrinking 't' and updating 'u_new' until condition is satisfied)
    while (obj(u_new,param) > obj(u,param) + gamma*t*J'*p)
        t = beta*t;       % shrink t
        u_new = u + t*p;  % update u_new
        
        % Ensures not stucking in backtracking if J has NaN:
        if t <= 0.2  % Samllest t: 1e-2; Optimal t: 0.2
            break;
        end
    end
    
    % Assign the step:
    [F_new, J_new] = J_func(obj, u_new, param);
    
    % Update Hessian approximation using BFGS formula:
    B_new = B;
    s = u_new - u;
    y = J_new - J;
    if ((s'*y) > 0)  % update Hessian only if curvature is positive
        B_new = B - ((s'*B*s)\(B*(s*s')*B)) + ((s'*y)\(y*y'));
    end
    
    % Update variables
    u = u_new;
    J = J_new;
    F = F_new;
    B = B_new;
end

if k == maxIter
    disp(['BFGS: Convergence NOT achieved. #Iter: ',...
          num2str(k), ' of ', num2str(maxIter)]);
end

% Evaluate state:
x = zeros(N,1);
N = length(u);
h  = param.T/N;
x(1) = param.x0;
for k = 1:param.N-1
    x(k+1) = x(k) + h*((1 - x(k))*x(k) + u(k));
end


end

