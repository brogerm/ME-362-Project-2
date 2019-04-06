load 'disk_drag.mat'
load 'cup_drag.mat'
load 'vel.mat'

rho = 1.23; % kg/m^3
d = 3 * 0.0254; % diameter of objects in m
A = pi * d^2/4; % area
v = 1.46 * 10^(-5); % m^2/s

% calculate Reynolds numbers
Re = vel * d/v;

% calculate Cd values
Cd_disk = 2 * disk_drag ./ (rho * vel.^2 * A);
Cd_cup = 2 * cup_drag ./ (rho * vel.^2 * A);

% create plots
% Don't plot first Cd since velocity is zero at that point
hold on
plot(Re(2:end), Cd_disk(2:end), '-ok', 'MarkerFaceColor', 'k')
plot(Re(2:end), Cd_cup(2:end), '-or', 'MarkerFaceColor', 'r')
xlabel('Re', 'FontSize', 12)
ylabel('Cd', 'FontSize', 12)
legend({'Disk', 'Hemisphere'}, 'FontSize', 10)
grid on