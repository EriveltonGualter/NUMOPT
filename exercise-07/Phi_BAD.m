function [F,J] = Phi_BAD(hc_fun, U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

%% Forward evaluation of the function:
x = zeros(N,1);
x(1) = x0;  % starting at x0

x1 = zeros(N,1);
x2 = zeros(N,1);
x3 = zeros(N,1);
x4 = zeros(N,1);
x5 = zeros(N,1);

for k = 1:(N-1)
    % x(k+1) = (1+h)*x(k) - h*x(k)^2 + h*U(k)
    x1(k) = (1+h)*x(k);
    x2(k) = x(k)*x(k);
    x3(k) = -h*x2(k);
    x4(k) = h*U(k);
    x5(k) = x1(k) + x3(k);
    x(k+1) = x5(k) + x4(k);
end
x6 = x(end)*x(end);
x7 = q*x6;
F = x7;  % function value to be returned

%% Backwards sweep:
% Initialization of the seed vector:
xBar = zeros(N,1);
UBar = zeros(N,1);
x1Bar = zeros(N,1);
x2Bar = zeros(N,1);
x3Bar = zeros(N,1);
x4Bar = zeros(N,1);
x5Bar = zeros(N,1);
x6Bar = 0;
x7Bar = 1;

% Differentiation of x7 = q*x6:
x6Bar = x6Bar + q*x7Bar;

% Differentiation of x6 = x(end)*x(end):
xBar(end) = xBar(end) + 2*x(end)*x6Bar;

for k = N-1:-1:1
    % Differentiation of x(k+1) = x5(k) + x4(k):
    x5Bar(k) = x5Bar(k) + 1*xBar(k+1);
    x4Bar(k) = x4Bar(k) + 1*xBar(k+1);

    % Differentiation of x5(k) = x1(k) + x3(k):
    x1Bar(k) = x1Bar(k) + 1*x5Bar(k);
    x3Bar(k) = x3Bar(k) + 1*x5Bar(k);

    % Differentiation of x4(k) = h*U(k):
    UBar(k) = UBar(k) + h*x4Bar(k);

    % Differentiation of x3(k) = -h*x2(k):
    x2Bar(k) = x2Bar(k) + (-h)*x3Bar(k);

    % Differentiation of x2(k) = x(k)*x(k):
    xBar(k) = xBar(k) + 2*x(k)*x2Bar(k);

    % Differentiation of x1(k) = (1+h)*x(k):
    xBar(k) = xBar(k) + (1+h)*x1Bar(k);
end
J = UBar;

% Add derivative of the quadratic term:
J = 2*U + J;

end
