%function to easily plot heating data
function plotRod( time, T1, T2, T3, T4, Tamb)
	
	%check to make
	if( size(time, 2) > size(T1, 2) )
		time = time(1:size(T1, 2));
	end

	figure
	plot(time, T1, 'y', time, T2, 'r', time, T3, 'g', time, T4, 'c', time, Tamb, 'm')
	xlabel('Time (seconds)', 'Fontsize', 12);
	ylabel('Temperature (Celsius)', 'Fontsize', 12);
	legendLabels = {'Temperature 1: 0mm (Cool End)', 'Temperature 2: 10mm', 'Temperature 3: 20mm', 'Temperature 4: 30mm (Hot End)', 'Ambient Temperature'};
	legend(legendLabels , 'Location', 'NorthWest', 'Fontsize', 12);
	grid on
	axis([0 inf 10 100]);
	title('Temparature vs Time at Various Positions', 'Fontsize', 14);
end