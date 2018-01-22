function [fig] = plot_result(x_opt, R, titleName)
% Plots result for fmincon example

ang = 0:0.01:2*pi; 
xp  = R*cos(ang);
yp  = R*sin(ang);

n = 10;
x1eq = linspace(-R,R,n)';
x2eq = x1eq;

fig = figure('Name',titleName);
plot(xp, yp);
hold('on');
plot(x1eq,x2eq);
hold('on');
plot(x_opt(1),x_opt(2),'rx','MarkerSize',10);
axis(R*[-1.1 1.1 -1.1 1.1]);
axis('equal');
title(titleName);
legend('Inequality constraint',...
       'Equality constraint',...
       ['Optimal solution: [',num2str(x_opt(1)),...
                            '; ',num2str(x_opt(2)),']'],...
       'Location','best');

end

