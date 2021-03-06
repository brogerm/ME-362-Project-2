load 'savedVariables/disk_drag.mat'
load 'savedVariables/cup_drag.mat'
load 'savedVariables/vel.mat'
load 'savedVariables/u_Cd.mat'

rho = 1.23; % kg/m^3
d = 3 * 0.0254; % diameter of objects in m
A = pi * d^2/4; % area
v = 1.46 * 10^(-5); % m^2/s

% calculate Reynolds numbers
Re = vel * d/v;

% calculate Cd values
Cd_disk = 2 * disk_drag ./ (rho * vel.^2 * A);
Cd_cup = 2 * cup_drag ./ (rho * vel.^2 * A);

% actual Cd from book
Cd_disk_actual = 1.1;
Cd_cup_actual = 1.42;

% create plots
% Don't plot first Cd since velocity is zero at that point

% disk
figure1 = figure(1);
axes1 = axes('Parent',figure1);
hold(axes1,'on');
errorbar(Re(2:end), Cd_disk(2:end), u_Cd, '--ob', 'MarkerFaceColor', 'b')
plot([0, 3 * 10^5], [Cd_disk_actual, Cd_disk_actual], '-k')
xlabel('Re', 'FontSize', 12)
ylabel('Cd', 'FontSize', 12)
legend({'Measured Cd', 'Actual Cd'})
grid(axes1,'on');
set(axes1,'FontSize',12);
set(legend,'FontSize',12);

% cup
figure2 = figure(2);
axes2 = axes('Parent',figure2);
hold(axes2,'on');
errorbar(Re(2:end), Cd_cup(2:end), u_Cd, '--ob', 'MarkerFaceColor', 'b')
plot([0, 3 * 10^5], [Cd_cup_actual, Cd_cup_actual], '-k')
xlabel('Re', 'FontSize', 12)
ylabel('Cd', 'FontSize', 12)
ylim([0,9])
legend({'Measured Cd', 'Actual Cd'})
grid(axes2,'on');
set(axes2,'FontSize',12);
set(legend,'FontSize',12);