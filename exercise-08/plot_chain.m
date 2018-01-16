function plot_chain(y, z, param)

% add edges in case they are condensed out
y = [param.xi(1); y; param.xf(1)];
z = [param.xi(2); z; param.xf(2)];

figure(1)
plot(y, z,'b--');hold on;
plot(y, z, 'Or'); hold off;
xlim([min(y), max(y)]);
ylim([(1 + (-1)*sign(min(z))*0.1)*min(z), (1 + sign(max(z))*0.1)*max(z)]);
title('Optimal position of chain');
xlabel('y');
ylabel('z');
grid('on');

end

