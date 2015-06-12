% WIP
function [Kc] = calc_Kc(position, Tamb, Thot)
	% Constants
	b_air = 3.43e-3; % expansion coefficient, 1/K
	v_air = 1.81e-5; % kinematic viscosity, m^2/s
	a_air = 1.9e-5; % Thermal diffusivity, m^2/s
	k_air = 0.0257; % Thermal Conductivity, W/(m K)
	g = 9.81;
	L = 0.3; % m
	Pr = 0.713; % Prandtl's #

	% if(position == 'vertical')
	Gr = ( b_air * g * ( 30 ) * L ^ 3 ) / v_air ^2

	d_over_l = 0.011/0.3
	35 / Gr ^ (0.25)
	% end
	% Calculating Kconvection

	% % Experimental Values
	% Tamb = 293;
	% To = Tamb+40;

	

	% % Rod dimensions
	% r = 0.011; % m
	% d = 0.02; % m

	% % finding Kc
	% Ra = g * b_air / (v_air * a_air)*(To-Tamb)*d^3
	% Nu = ( 0.6 + ( 0.387 * Ra ^ (1/6)) / ( 1 + (0.559 / Pr )^(9/16))^(8/27)) ^2
	% Kconvection = Nu * k_air / d

	% Kc = 1;

end