%Number of steps
Nx = 60; %Number of steps in length
Nt = 100000; %Number of steps in time
t0 = 0; %Start time (s)
tf = 6000; %End time (s)
x0 = 0; %Start length (m)
xf = 0.3; %End length (m)

%Constants
kc = 10; %Convection coefficient of horizontal Al rod (W/(m^2K))
k = 205; %Constant of conductivity of Al (W/(mK))
a = 0.01; %Radius of the rod (m)
e = 0.95; %Emmisivity of rod
SBc = 5.67e-8; %Stefan-Boltzmann constant (W/(m^2K^4))
Tamb = 298; %Ambient temperature (K)
Cp = 910; %Specific heat capacity of Al (J/(K kg))
rho = 2.7e3; %Density of Al (kg/m^3)

%Calculated numbers
dx = (xf - x0)/(Nx);
dt = (tf - t0)/(Nt);

dT_convec = @(Tx) (kc*2*(Tx-Tamb)*dt)/(Cp*rho*a); %Temperature change due to convection (K)
dT_rad = @(Tx) (e*SBc*2*(Tx.^4-Tamb^4)*dt)/(Cp*rho*a); %Temperature change due to radiation (K)
dT_convec_end = @(Tx) (kc*(Tx-Tamb)*dt)/(Cp*rho*dx);
dT_rad_end = @(Tx) (e*SBc*(Tx.^4-Tamb^4)*dt)/(Cp*rho*dx);
dT = @(P) (P * dt)/(Cp * pi*a^2*dx*rho); %Temperature change in chunk (K)

dP_convec_end = @(Tend) kc*pi*a^2*(Tend-Tamb) + kc*2*pi*a*dx*(Tend-Tamb);
dP_rad_end = @(Tend) e*SBc*pi*a^2*(Tend^4-Tamb^4) + e*SBc*2*pi*a*dx*(Tend^4-Tamb^4);
PlossSS = @(Tend) dP_convec_end(Tend) + dP_rad_end(Tend);

Lth = @(Tstart) sqrt((k*a)/(2*(kc+(4*e*SBc*((Tstart+Tamb)/2)^3)))); %m

% SIMULATION OF BARE ROD

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Through the rest of the rod %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tin = Tend;
current_pos = deltaX;
x_pos2 = L/2
P_at_pos3 = Pin; % end of the rod
Pin_vector = zeros(nstep,1);
Pin_vector(1) = Pin;

for ith_step = 2:nstep
	% setting deltaT
	deltaT = Tin - Tamb;

	% Previous Pin is now Pout of the next slice
	Pout = Pin;
	% Previous Tin is now Tout
	Tout = Tin;
	
	% saving the temp as a vector
	T(ith_step) = Tout;

	% calculating the power loss
	Ploss_convec = Kconvection * ( 2 * pi * r * deltaX ) * ( deltaT);
	Ploss_rad = em * stefanboltz * ( 2 * pi * r * deltaX ) * ( Tout^4 - Tamb^4 );

	% finding Pin as a sum of the other powers
	Pin = Pout + Ploss_convec + Ploss_rad;
	Pin_vector(ith_step) = Pin;

	% finding Tin of the systmem with the new Pin
	Tin = Pin * deltaX / (Kconductive * ( pi * r^2 ) ) + Tout;

	current_pos += deltaX
	if( current_pos == x_pos2)
		P_at_pos2 = Pin;
	end
end
% P_at_pos1 = Pin % start of the rod
% P_at_pos2
% P_at_pos3
% time
% T_at_pos1 = P_at_pos1 * time / ()
position = linspace(0,0.3,100)
plot(position,Pin_vector)

%==============
%= Simulation =
%==============

%Initial data
Tend = ; %Temperature of cold end of rod at steady state (K)
Tstart = ; %Temperature of hot end of rod at steady state (K)

%Storage
T = zeros(Nx, Nt); %Array of temp over time, indices are (x,t)

%initialization
T(:,tf) = ; %Final conditions of the rod in steady state


