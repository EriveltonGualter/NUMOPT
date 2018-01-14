function [F,J] = Phi_BAD(hc_fun, U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

% Create seed vectors and defferentiate:
F = 0;  % function value

x = zeros(N,1);
J = zeros(N,1);  % jacobian

% Number of operations:
m = 7;
    
% Starting parameters:
x(1) = x0;

xBar = zeros(N+m,1);  % evaluated jacobain values
% xBar(end) = 1;  % seed vector for last x
for k = 1:N-1
    % x(k+1) = (1+h)*x(k) - h*x(k)^2 + h*u(k)
    
    n = k+1;
    
    % Forward evaluation of the function:
    x1 = (1+h)*x(k);
    x2 = x(k)*x(k);
    x3 = -h*x2;
    x4 = h*U(k);
    x5 = x1 + x3;
    x(n) = x5 + x4;
    x6 = x(n)*x(n);
    x7 = q*x6;
    
    % Initialization of the seed vector:
    UBar = zeros(N,1);
    UBar(k) = 1;
        
    % Backwards sweep (needed only one):
    % % Differentiation of x7 = q*x6:
    xBar(n+6) = xBar(n+6) + q*xBar(n+7);

    % Differentiation of x6 = x(N)*x(N):
    xBar(n) = xBar(n) + 2*x(n)*xBar(n+6);

    % Differentiation of x(k+1) = x5 + x4:
    xBar(N+5) = xBar(N+5) + 1*xBar(k+1);
    xBar(N+4) = xBar(N+4) + 1*xBar(k+1);

    % Differentiation of x5 = x1 + x3:
    xBar(N+1) = xBar(N+1) + 1*xBar(N+5);
    xBar(N+3) = xBar(N+3) + 1*xBar(N+5);

    % Differentiation of x4 = h*U(k):
    UBar(k) = UBar(k) + h*xBar(N+4);

    % Differentiation of x3 = -h*x2:
    xBar(N+2) = xBar(N+2) + (-h)*xBar(N+3);

    % Differentiation of x2 = x(k)*x(k):
    xBar(k) = xBar(k) + 2*x(k)*xBar(N+2);

    % Differentiation of x1 = (1+h)*x(k):
    xBar(k) = xBar(k) + (1+h)*xBar(N+1);
end
F = x7;
J = xBar(1:N);

% % Multiplication q * xN^2:
% x6 = x(N)*x(N);
% x7 = q*x6;
% F = x7;
% 
% % Differentiation of x7 = q*x6:
% xBar(N+6) = xBar(N+6) + q*xBar(N+7);
% 
% % Differentiation of x6 = x(N)*x(N):
% xBar(N) = xBar(N) + 2*x(N)*xBar(N+6);
% 
% J = xBar(1:N);

% Add derivative of the quadratic term:
J = 2*U + J;

end
