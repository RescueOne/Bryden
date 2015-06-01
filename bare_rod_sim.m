% SIMULATION OF BARE ROD

% Constants
Tend = 273 + 30;  % K
Tamb = 293; % K
Kconductive = 200; % at 25 C, W / (m K)
Kconvection = 10;
em = 0.95;
stefanboltz = 5.6704e-8; % W m−2 K−4

% constant
r = 0.011; % m
L = 0.3; % m
nstep = 100;
deltaX = L / nstep;
% A = 2 * pi * r;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prelim calc for Pin of the first slice %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: Heat loss around the rod and at the end
Ploss_convec_end = Kconvection * ( pi * r^2 ) * (Tend - Tamb);
Ploss_convec_outer_rod = Kconvection * ( 2 * pi * r * deltaX ) * (Tend - Tamb);

Ploss_rad_end = em * stefanboltz * ( pi * r^2 ) * ( Tend^4 - Tamb^4 );
Ploss_rad_outer_rod = em * stefanboltz * ( 2 * pi * r * deltaX ) * ( Tend^4 - Tamb^4 );

Ploss = Ploss_convec_end + Ploss_convec_outer_rod + Ploss_rad_end + Ploss_rad_outer_rod;
% for the last slice
Pout = Ploss;
Pin = Pout;

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