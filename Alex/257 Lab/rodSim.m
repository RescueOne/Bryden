function [Tbegin,Tend] = rodSim(Nx)
%Number of steps
% Nx = 60; %Number of steps in length
Nt = 100000; %Number of steps in time
t0 = 0; %Start time (s)
tf = 2500; %End time (s)
x0 = 0; %Start length (m)
xf = 0.3; %End length (m)

%Constants
kc = 8; %Convection coefficient of horizontal Al rod (W/(m^2K))
k = 160; %Constant of conductivity of Al (W/(mK))
a = 0.011; %Radius of the rod (m)
e = 1; %Emmisivity of sandblasted Al rod
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

%==============
%= Simulation =
%==============

%Constants
Pinl = 12; %Power into the left side of the rod (W)

%Storage
T = zeros(Nx, Nt); %Array o temp over time, indices are (x,t)

%initial
T(:,1) = ones(Nx,1)*Tamb; %Set all temperatures to Tamb

for time = 1:Nt-1
    %power in to rod and out by conduction
    T(1,time+1)=T(1,time)+dT(Pinl)+((k/(Cp*rho))*(T(2,time)-T(1,time))./dx^2)*dt;
    
    %temperature changes due to conduction
    %along rod
    T(2:Nx-1,time+1)=T(2:Nx-1,time)+(k/(Cp*rho))*((T(3:Nx,time)-2*T(2:Nx-1,time)+T(1:Nx-2,time))./dx^2)*dt;
    T(Nx,time+1) = T(Nx,time)-((k/(Cp*rho))*(T(Nx,time)-T(Nx-1,time))./dx^2)*dt;
    
    %temperature changes due to loss in convection and radiation
    %along rod
    T(1:Nx,time+1)=T(1:Nx,time+1) - dT_convec(T(1:Nx,time+1)) - dT_rad(T(1:Nx,time+1));
    
    %at cold and hot end of rod
    T(Nx,time+1)=T(Nx,time+1) - dT_convec_end(T(Nx,time+1)) - dT_rad_end(T(Nx,time+1));
end
Tbegin = T(1,Nt);
Tend = T(Nx,Nt);
return;
end