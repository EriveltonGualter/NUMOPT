function [fig] = plot_result(x_opt, R, titleName)
% Plots result for fmincon example

ang = 0:0.01:2*pi; 
xp  = R*cos(ang);
yp  = R*sin(ang);

fig = figure('Name',titleName);
plot(xp, yp);
hold('on');
plot(x_opt(1),x_opt(2),'rx','MarkerSize',10);
axis(R*[-1.1 1.1 -1.1 1.1]);
title(titleName);
legend('Equality constraint',...
       ['Optimal solution: [',num2str(x_opt(1)),...
                            '; ',num2str(x_opt(2)),']'],...
       'Location','best');

end

