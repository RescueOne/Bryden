
% ==== DAY 1 ====

% Calculating Kconvection

% Experimental Values
Tamb = 293;
To = Tamb+40;

% Constants
b_air = 3.43e-3; % expansion coefficient, 1/K
v_air = 1.81e-5; % kinematic viscosity, m^2/s
a_air = 1.9e-5; % Thermal diffusivity, m^2/s
k_air = 0.0257; % Thermal Conductivity, W/(m K)
g = 9.81;
Pr = 0.713; % Prandtl's #

% Rod dimensions
r = 0.011; % m
d = 0.02; % m

% finding Kc
Ra = g * b_air / (v_air * a_air)*(To-Tamb)*d^3
Nu = ( 0.6 + ( 0.387 * Ra ^ (1/6)) / ( 1 + (0.559 / Pr )^(9/16))^(8/27)) ^2
Kconvection = Nu * k_air / d

% Calculating Lth                                                          

% More Constants
Kconductive = 205; % at 25 C, W / (m K)
em = 0.21; % sandblasted aluminum, http://www.infrared-thermography.com/material.htm
stefanboltz = 5.6704e-8; % W m−2 K−4
Tav = ( To + Tamb) / 2;

keff = Kconvection + ( 4 * em * stefanboltz * Tav ^ 3)

Lth = sqrt( (Kconductive * r) / (2 * keff))

% Plot, since L = 0.3m
x = linspace(0,0.3);
T = Tamb + (To-Tamb) * exp(-x / Lth);
plot(x, T, 'r')

title('Temperature along the rod (rod length = 0.3m)')
xlabel('Position (m)');
ylabel('Temperature (K)');

% ==== DAY 2 ====
% NOTE: we are overriding some of our previously calculated constants
% assume
Tout = 273 + 30;  % K
Kconductive = 200;
Kconvection = 10;
em = 0.95;
Tav = ( Tout + Tamb) / 2;

% constant
L = 0.3; % m
nstep = 100;
deltaX = L / nstep;
A = 2 * pi * r;

% NOTE: Heat loss around the rod and at the end
Ploss_convec_end = Kconvection * pi * r^2 * (Tout - Tamb);
Ploss_convec_outer_rod = Kconvection * A * deltaX * (Tout - Tamb);

Ploss_rad_end = em * stefanboltz * pi * r^2 * ( Tout^4 - Tamb^4 );
Ploss_rad_outer_rod = em * stefanboltz * A * deltaX * ( Tout^4 - Tamb^4 );

Ploss = Ploss_convec_end + Ploss_convec_outer_rod + Ploss_rad_end + Ploss_rad_outer_rod;
% for the last slice
Pout = Ploss;
Pin = Pout


