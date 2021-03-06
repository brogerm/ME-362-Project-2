% Governing equations
% Cd = D/(1/2 * rho * A * v^2)

% u_Cd = sqrt((dCd/dD * u_D)^2 + (dCd/drho * u_rho)^2 + ....)

% load already calculated uncertainty in drag
load 'savedVariables/u_drag.mat'
rho = 1.23; % kg/m^3

%% Find uncertainty in rho
% rho = P/(R * T)

P = 101258.35; % Pa
T = 294.15; % K
R = 287; % J/(kg * K)

u_T = 0.05 * T; % K
u_P = 0.05 * P; % Pa

% propagation of of uncertainty 
dRho_dP = 1/(R * T);
dRho_dT = -P/(R * T^2);

u_rho = sqrt((dRho_dP * u_P)^2 + (dRho_dT * u_T)^2);

%% Find uncertainty in area
D = round(3 * 25.4) / 1000; % this is the nearest mm measurement of 3 in
u_D = 1/2 * 1/1000; % m

A = pi * D^2/4;

dA_dD = pi * D/2;

u_A = (dA_dD * u_D); % m^2

%% Find uncertainty in velocity
load 'savedVariables/vel.mat'
u_v = 0.05 * vel;

%% Progation of uncertainty for each Cd

dCd_dD = 2./(A * rho * vel.^2);

dCd_dRho = -2 * D./(A * vel.^2 * rho^2);

dCd_dA = -2 * D./(A^2 * vel.^2 * rho);

dCd_dV = -4 * D./(A * rho * vel.^3);

u_Cd = [];
for i=2:length(vel)
    u_Cd(i-1) = sqrt((dCd_dD(i) * u_drag)^2 + (dCd_dRho(i) * u_rho)^2 + (dCd_dA(i) * u_A)^2 + (dCd_dV(i) * u_v(i))^2);
end

disp(u_Cd)
% u_Cd = sqrt((dCd_dD .* u_drag).^2 + (dCd_dRho .* u_rho).^2 + (dCd_dA .* u_A).^2 + (dCd_dV .* u_v).^2)

save savedVariables/u_Cd.mat u_Cd



