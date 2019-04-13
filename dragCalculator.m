function [drag, y, p] = dragCalculator(pixelLocations, vel)

% load calibration data
load 'savedVariables/p.mat' % this is the calibration line fit
load 'savedVariables/pixelToLengthRatio.mat'

% calculate deflection at each windspeed
deflection = []; % this is in mm
for i=1:length(pixelLocations)
    deflection(end + 1) = (pixelLocations(i) - pixelLocations(1)) * pixelToLengthRatio;
end

% calculate force for each deflection
% deflection = p(1) * force + p(2)
drag = (deflection - p(2))/p(1);

% create 2nd order best fit line
p2 = polyfit(vel, drag, 2);
y = polyval(p2, vel);

