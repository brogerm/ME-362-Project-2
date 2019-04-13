load 'savedVariables/diskPixelLocations.mat'
load 'savedVariables/cupPixelLocations.mat'
load 'savedVariables/pixelToLengthRatio.mat'
load 'savedVariables/p.mat' % this is the calibartion curve fit
load 'savedVariables/u_drag.mat'

% calculate wind speeds
freq = [0, 10, 20, 30, 40, 50, 60];
vel = 0.819 * freq - 0.632; % this is in m/s

calculateDrag = @dragCalculator;

% perform calculations on disk and cup data
[disk_drag, disk_y, p_disk] = calculateDrag(diskPixelLocations, vel);
[cup_drag, cup_y, p_cup] = calculateDrag(cupPixelLocations, vel);

% define data from Fluids lab 1
disk_f1 = [0 0.22241 0.63165 1.4457 2.6067 4.1546];
cup_f1 = [0 0.2402 0.80958 1.677 3.0915 4.9464];

%% create vector of u_drag
u_drag_vector = u_drag * ones(1, length(disk_drag));

%% disk plot
figure1 = figure(1);
axes1 = axes('Parent',figure1);
hold(axes1,'on');
errorbar(vel, disk_drag, u_drag_vector, 'ok', 'MarkerFaceColor', 'k')
plot(vel, disk_y, '--r')
plot(vel(1:6), disk_f1, '-b')
xlabel('Air Speed (m/s)', 'FontSize', 12)
ylabel('Drag Force (N)', 'FontSize', 12)
legend({'Measured force', 'Best fit curve', 'Data from Fluids Lab 1'}, 'FontSize', 10 )
grid(axes1,'on');
set(axes1,'FontSize',12, 'XMinorTick','on', 'YMinorTick','on');
set(legend,...
    'Position',[0.150892857142856 0.788095238095241 0.292857142857143 0.119047619047619],...
    'FontSize',12);

%% cup plot
figure2 = figure(2);
axes2 = axes('Parent',figure2);
hold(axes2,'on');
errorbar(vel, cup_drag, u_drag_vector, 'ok', 'MarkerFaceColor', 'k')
plot(vel, cup_y, '--r')
plot(vel(1:6), cup_f1, '-b')
xlabel('Air Speed (m/s)', 'FontSize', 12)
ylabel('Drag Force (N)', 'FontSize', 12)
legend({'Measured force', 'Best fit curve', 'Data from Fluids Lab 1'}, 'FontSize', 10)
grid(axes2,'on');
set(axes2,'FontSize',12, 'XMinorTick','on', 'YMinorTick','on');
set(legend,...
    'Position',[0.150892857142856 0.788095238095241 0.292857142857143 0.119047619047619],...
    'FontSize',12);
