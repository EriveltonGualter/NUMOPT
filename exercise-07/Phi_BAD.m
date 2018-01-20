function [F,J] = Phi_BAD(hc_fun, U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

%% Forward evaluation of the function:
x = zeros(N,1);
x(1) = x0;  % starting at x0

for k = 1:(N-1)
    % x(k+1) = (1+h)*x(k) - h*x(k)^2 + h*U(k)
    x1 = (1+h)*x(k);
    x2 = x(k)*x(k);
    x3 = -h*x2;
    x4 = h*U(k);
    x5 = x1 + x3;
    x(k+1) = x5 + x4;
end
x6 = x(end)*x(end);
x7 = q*x6;
F = x7;  % function value to be returned

%% Backwards sweep:
% Initialization of the seed vector:

% Need one more element in xBar quantity to evaluate all the N UBar's:
xBar = zeros(N+1,1);
UBar = zeros(N,1);
x6Bar = 0;
x7Bar = 1;

% Differentiation of x7 = q*x6:
x6Bar = x6Bar + q*x7Bar;

% Differentiation of x6 = x(end)*x(end):
xBar(end) = xBar(end) + 2*x(end)*x6Bar;

for k = N:-1:1  % evaluates actually all N UBar quantities
    % Reset seed vector for every new loop
    % We can do it since bar quantities from 1 to 5
    % are not propagatet to new xBar quatities (see forward pass):
    x1Bar = 0;
    x2Bar = 0;
    x3Bar = 0;
    x4Bar = 0;
    x5Bar = 0;

    % Differentiation of x(k+1) = x5 + x4:
    x5Bar = x5Bar + 1*xBar(k+1);
    x4Bar = x4Bar + 1*xBar(k+1);

    % Differentiation of x5 = x1 + x3:
    x1Bar = x1Bar + 1*x5Bar;
    x3Bar = x3Bar + 1*x5Bar;

    % Differentiation of x4 = h*U(k):
    UBar(k) = UBar(k) + h*x4Bar;

    % Differentiation of x3 = -h*x2:
    x2Bar = x2Bar + (-h)*x3Bar;

    % Differentiation of x2 = x(k)*x(k):
    xBar(k) = xBar(k) + 2*x(k)*x2Bar;

    % Differentiation of x1 = (1+h)*x(k):
    xBar(k) = xBar(k) + (1+h)*x1Bar;
end
J = UBar;

% Add derivative of the quadratic term:
J = 2*U + J;

end
