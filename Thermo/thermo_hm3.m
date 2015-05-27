% ===== ASSIGNMENT 3 ===== %

% Constants
T = 273; % K
k = 1.38e-23;
Na = 6.022e23; % avagrados #, per mol
v = linspace(0,2500, 5000);

% He
M = 4/1000;
m = M / Na;
prob_density = sqrt( ( m ./ ( 2 .* pi .* k .* T ) ).^3 ) .* 4 .* pi  .* v.^2 .* exp( (-m.*v.^2) / (2 .* k .* T) );
plot(v, prob_density, 'r')
hold on

% Air
M = 29/1000;
m = M / Na;
v_mean_Air = sqrt( 3 * k * T / m) / sqrt(3) * sqrt(5/3)
% gamma constant for air in second sqrt

prob_density = sqrt( ( m ./ ( 2 .* pi .* k .* T ) ).^3 ) .* 4 .* pi  .* v.^2 .* exp( (-m.*v.^2) / (2 .* k .* T) );
trapz(prob_density)
plot(v, prob_density, 'b')
hold on

% Xe
M = 131.3/1000;
m = M / Na;
prob_density = sqrt( ( m ./ ( 2 .* pi .* k .* T ) ).^3 ) .* 4 .* pi  .* v.^2 .* exp( (-m.*v.^2) / (2 .* k .* T) );
plot(v, prob_density, 'm')

title('Probability Density of Three Different Gases', 'Fontsize', 14)
legend('He   ','Air   ','Xe   ')
xlabel('Speed v (m/s)')
ylabel('Probability Density v (s/m)')
hold off

% Speend of sound of He and Xe
