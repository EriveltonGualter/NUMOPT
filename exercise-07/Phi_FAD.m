function [F,J] = Phi_FAD(hc_fun, U, param)
% Forward algorithmic differentiation (AD)

N  = length(U);
x0 = param.x0;
h  = param.T/N;
q  = param.q;

% Create seed vectors and defferentiate:
F = 0;  % function value

x = zeros(N,1);
J = zeros(N,1);  % jacobian

xDot = zeros(N,1);  % evaluated jacobain values
for i=1:N
    % Starting parameters:
    x(1) = x0;
    xDot(1) = 0;  % derviative of x0
    
    % Directional seed vector of U:
    pU = zeros(N,1);
    pU(i) = 1;
    
    for k = 1:N
        % x(k+1) = (1+h)*x(k) - h*x(k)^2 + h*u(k)
        
        % I) Direct approach:
        % Create variables for each operation and derivatives of them:
        ax = (1+h)*x(k);
        bx = -h*x(k)*x(k);
        cx = h*U(k);
        
        axDot = (1+h)*xDot(k);
        bxDot = -h*(x(k)*xDot(k) + x(k)*xDot(k));
        cxDot = h*pU(k);

        % Add all variables for derivative and X accordingly:
        x(k+1) = ax + bx + cx;
        xDot(k+1) = axDot + bxDot + cxDot;
        
%         % II) Indirect approach:
%         [ax, axDot] = fadMul((1+h),x(k),1,xDot(k),0);
%         [bx, bxDot] = fadMul(-h,x(k),x(k),xDot(k),xDot(k));
%         [cx, cxDot] = fadMul(h,U(k),1,pU(k),0);
%         [Ax, AxDot] = fadAdd(1,ax,bx,axDot,bxDot);
%         [x(k+1), xDot(k+1)] = fadAdd(1,Ax,cx,AxDot,cxDot);
    end
    % Multiplication q * xN^2
    % I) Direct approach:
    F = q*x(end)*x(end);
    J(i) = q*2*(x(end)*xDot(end) + x(end)*xDot(end));
    
%     % II) Indirect approach:
%     [F, J(i)] = fadMul(q,x(end),x(end),xDot(end),xDot(end));
end

% Add derivative of the quadratic term:
J = 2*U + J;

end

