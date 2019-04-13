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
figure(1)
hold on
errorbar(vel, disk_drag, u_drag_vector, 'ok', 'MarkerFaceColor', 'k')
plot(vel, disk_y, '--r')
plot(vel(1:6), disk_f1, '-b')
xlabel('Air Speed (m/s)', 'FontSize', 12)
ylabel('Drag Force (N)', 'FontSize', 12)
legend({'Measured force', 'Best fit curve', 'Data from Fluids Lab 1'}, 'FontSize', 10 )
set(legend,...
    'Position',[0.153571428571428 0.814285714285717 0.2375 0.0904761904761905]);

%% cup plot
figure(2)
hold on
errorbar(vel, cup_drag, u_drag_vector, 'ok', 'MarkerFaceColor', 'k')
plot(vel, cup_y, '--r')
plot(vel(1:6), cup_f1, '-b')
xlabel('Air Speed (m/s)', 'FontSize', 12)
ylabel('Drag Force (N)', 'FontSize', 12)
legend({'Measured force', 'Best fit curve', 'Data from Fluids Lab 1'}, 'FontSize', 10)
set(legend,...
    'Position',[0.153571428571428 0.814285714285717 0.2375 0.0904761904761905]);

