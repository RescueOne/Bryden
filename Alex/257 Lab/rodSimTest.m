Nfinal = 200;
D = zeros(3, Nfinal-9);
for Nx = 10:Nfinal
i = Nx - 9;
[first,last] = rodSim(Nx);
D(1:3,i) = [Nx, first, last]';
end

XL = linspace(10,Nfinal,Nfinal-9);
YLfirst = D(2,1:Nfinal-9);
YLlast = D(3,1:Nfinal-9);

figure
subplot(2,1,1);
plot(XL, YLfirst, 'r');
subplot(2,1,2);
plot(XL, YLlast, 'b');
