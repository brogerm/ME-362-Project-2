load 'pixelToLength.mat'
load 'ul.mat'
load 'vl.mat'

pixelToLengthRatio = 30/(pixelToLength(2) - pixelToLength(1)); % this is in mm
save pixelToLengthRatio.mat pixelToLengthRatio

displacement = [];
for i=1:length(uL) - 1
    displacement(end + 1) = -(uL(1) - uL(i)) * pixelToLengthRatio;
end

force = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34];

p = polyfit(force, displacement, 1);
save p.mat p
y = polyval(p, force);

hold on
plot(force, displacement, 'ok', 'MarkerFaceColor', 'k')
plot(force, y, '-r')
xlabel('Force (oz)')
ylabel('Displacement (mm)')



