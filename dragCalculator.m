function [drag, y] = dragCalculator(pixelLocations, vel)

% load calibration data
load 'p.mat' % this is the calibration line fit
load 'pixelToLengthRatio.mat'

% calculate deflection at each windspeed
deflection = []; % this is in mm
for i=1:length(pixelLocations)
    deflection(end + 1) = (pixelLocations(i) - pixelLocations(1)) * pixelToLengthRatio;
end

% calculate force for each deflection
% deflection = p(1) * force + p(2)
drag = (deflection - p(2))/p(1) * 0.28; % this is in lbs

% create 2nd order best fit line
p2 = polyfit(vel, drag, 2);
y = polyval(p2, vel);

