function [] = plot_state_controls(figName, x, u)
% Plots states and controls over time in the figure with
% figName

figure('Name', figName);
subplot(2,1,1); plot(u);
xlabel('Control: u');
subplot(2,1,2); plot(x);
ylabel('State: x');
xlabel('# Iter (discrete time)')

end

