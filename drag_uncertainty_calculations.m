load 'savedVariables/pixelToLengthRatio.mat'
load 'savedVariables/p.mat'
% This p gives, displacement = m*force + b
% transform to force = (displacement - b)/m
% or force = 1/m * displacement - b/m

load 'savedVariables/displacement.mat'
load 'savedVariables/noisyPixelLocations.mat'

%% Find uncertainty due to noise

% uncertainty in pixel location
u_noise_pixel = std(noisyPixelLocations);

% uncertainty in displacement (multiply pixel uncertainty by pixel to
% length ratio)
u_noise_displacement = u_noise_pixel * pixelToLengthRatio;

% uncertainity in force (multiply displacement uncertainty by static
% sensitivity)
u_noise = u_noise_displacement * 1/p(1);

%% Find instrument uncertainty (this is calculated based off the calibration curve data)
N = 18;
m = 1;

% see note on p above for formatting
y = (displacement - p(2))/p(1);
force = (0:2:34) * 0.28; % makes force in units of Newtons

t = 2.12; % this is from the t-table
u_instrument = t .* sqrt(1/(N - (m + 1)) * sum((y - force).^2));

%% Find resolution uncertainty
% see note on p above for formatting
% This gives the smallest force that can be detected
u_res = (pixelToLengthRatio - p(2))/p(1);

%% Find total uncertainty in the drag force using RSS
u_drag = sqrt(u_res^2 + u_instrument^2 + u_noise^2);
save u_drag.mat u_drag


