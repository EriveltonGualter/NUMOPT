
% Hanging chain problem with BFGS and backtracking

clear variables; close all; clc;

plotFigures = true;

% Number of mass points
N     = 40;
tol   = 1E-3;
maxit = 2000;

% Definining constants in a structure
param.L = 1;
param.D = (70/40)*N;
param.m = 4/N;
param.g = 9.81;
param.N = N;

% Chain end points
param.zi = [-2 1];  % initial (y1, z1)
param.zf = [ 2 1];  % final   (yN, zN)

% Initial guess: linear interpolation between the tips
y = linspace(param.zi(1), param.zf(1), N+2)';
z = linspace(param.zi(2), param.zf(2), N+2)';

% Eliminate the tips from the decision variables and stack them together
x = reshape([y(2:end-1) z(2:end-1)].',2*N,1);

% Initial Hessian approximation
B = eye(length(x));

% Get the objective value and the gradient at initial point
% TODO: WRITE YOUR FUNCTION FINITE_DIFFERENCE 
[F, J] = finite_difference(@hc_obj, x, param);

% A check whether the function you wrote is  correct
if F > 46.67 || F < 46.66 || norm(J) > 6.21 || norm(J) < 6.20  
    error('The outputs from your function finite_difference.m for the given initial point are not correct.')
end

% Printing header: iterate number, gradient norm, objective value, step norm, stepsize
fprintf('It.  \t | ||grad_f||\t | f\t\t | ||dvar||\t | t  \n');

% Main loop:
BFGS = true;
for k = 1 : maxit
    
    % TODO: OBTAIN SEARCH DIRECTION USING CURRENT 'B' and 'J'
    p = (-1)*(B\J);
    
    % Parameters for backtracking with Armijo's condition
    t     = 1.0;    % initial step length
    beta  = 0.45;   % shrinking factor (default: 0.8)
    gamma = 0.1;    % minimal decrease requirement
    
    x_new = x + t*p;  % candidate for the next step

    % TODO: IMPLEMENT YOUR BACKTRACKING WITH ARMIJO'S CONDITION HERE
    %       (KEEP SHRINKING 't' AND UPDATING 'x_new' UNTIL CONDITION IS SATISFIED)
    
    while (hc_obj(x_new,param) > hc_obj(x,param) + gamma*t*J'*p)
        t = beta*t;  % shrink t
        x_new = x + t*p;  % update x_new
    end
    
    % Assign the step
    [F_new, J_new] = finite_difference(@hc_obj, x_new, param);
    
    
    % TODO: UPDATE YOUR HESSIAN APPROXIMATION 'B' USING THE BFGS FORMULA HERE (FOR QUESTION 2c ONLY)
    
    B_new = B;  % defeine approximated new Hessian as actual one.
    if (BFGS == true)
        s = x_new - x;
        y = J_new - J;
        if ((s'*y) > 0)  % update Hessian only if curvature is positive
            B_new = B - ((s'*B*s)\(B*(s*s')*B)) + ((s'*y)\(y*y'));
        end
    end
    
    % Update variables
    x = x_new;
    J = J_new;
    F = F_new;
    B = B_new;

    % Every 10 iterations print the header again
    if mod(k,10) == 0
        fprintf('\n');
        fprintf('It.  \t | ||grad_f||\t | f\t\t | ||dvar||\t | t  \n');
    end
    
    % Print some useful information
    fprintf('%d\t | %f\t | %f\t | %f\t | %f \n', k, norm(J), F, norm(p), t);
    
    % plotting
    if plotFigures
        y = x(1:2:2*N);
        z = x(2:2:2*N);
        % Plotting 
        figure(1);
        subplot(2,1,1), plot(y, z,'b--');hold on;
        subplot(2,1,1), plot(y, z, 'Or'); hold off;
        xlim([-2, 2]);
        ylim([ -3, 1]);
        title('Position of chain at current iterate');
        subplot(2,1,2), plot(p);
        title('full step of each optimization variable (dz_i)');
        drawnow;
    end
    if norm(J) < tol
        disp('Convergence achieved.');
        break
    end

end

% Plot optimal solution 
figure(1);
y = x(1:2:2*N);
z = x(2:2:2*N);
subplot(2,1,1), plot(y, z, 'b--');hold on;
title('Position of chain at optimal solution');
subplot(2,1,1), plot(y, z, 'Or'); hold off;
xlim([-2, 2]);
ylim([ -3, 1]);
