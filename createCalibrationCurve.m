load 'pixelToLength.mat'
load 'ul.mat'
load 'vl.mat'

pixelToLengthRatio = 30/(pixelToLength(2) - pixelToLength(1)); % this is in mm
% save savedVariables/pixelToLengthRatio.mat pixelToLengthRatio

displacement = [];
for i=1:length(uL) - 1
    displacement(end + 1) = -(uL(1) - uL(i)) * pixelToLengthRatio;
end
% save savedVariables/displacement.mat displacement

force = (0:2:34) * 0.28;

%% This polyfit gives, displacement = m*force + b
% transform to force = (displacement - b)/m
% or force = 1/m * displacement - b/m
p = polyfit(force, displacement, 1);
% save savedVariables/p.mat p
y = polyval(p, force);

hold on
plot(displacement, force, 'ok', 'MarkerFaceColor', 'k')
plot(y, force, '-r')
ylabel('Force (oz)')
xlabel('Displacement (mm)')


