% Numerical Optimizations WS17/18
% Copyright: Alexander Kozhinov, AlexanderKozhinov@yandex.com
% Date: 15.01.2018

clc; close all; clear variables;

%% Newton-Lagrange mthod for NLP:
R = 1;
maxNumIter = 5000;  % maximal number of iterations

% Starting parameters
w = (-1)*[1;1;1];  % additional supporting variable: [x1,x2,lambda]

% First order optimality conditions (left sinde):
F = @(w) ([-2*w(3)*w(1);
           1 - 2*w(3)*w(2);
           w(1)^2 + w(2)^2 - R]);
       
% KKT - Matrix:
B = @(w) ([-2*w(3), 0,       2*w(1);
           0,       -2*w(3), 2*w(2);
           2*w(1),  2*w(2),  0     ]);

%% Run Newton-Lagrange method (fmincon_example solition: [0,-1])
% Use Algorithm 7 form the script on p. 97:
epsilon = 1e-10;
for k=1:maxNumIter
    if norm(F(w)) <= epsilon  % should be in [0, epsilon)
        break;
    end
    dw = -B(w)\F(w);
    w(1) = w(1) + dw(1);
    w(2) = w(2) + dw(2);
    w(3) = w(3) - dw(3);
end

%% Plot result:
plot_result([w(1);w(2)],R,'Exercise 8.b-c');

%% Proove SOSC:

% Second oorder derivative of Lagrangion at solution point:
g2L = B(w);
g2L = [g2L(1,1), g2L(1,2);
       g2L(2,1), g2L(2,2)];

disp('Some information on solution point:');
disp(['g(x_opt) = ', num2str(w(1)^2 + w(2)^2 - R)]);
disp('Second order derivative of Lagrangion at w_opt:');
disp(g2L);
% QR-factorization of grad_g(x):
[Q,R] = qr([2*w(1); 2*w(2)]);
Z = Q;
H = Z'*g2L*Z;  % reduced hession (script p.94)
sumH = sum(sum(H));
SOSC_state = 'NOT holds';
if sumH > 0
    SOSC_state = 'Holds';
end
disp(['Proove if SOSC holds: ', SOSC_state]);
disp('Reduced Hessian (Z''*g2L*Z):');
disp(H);

