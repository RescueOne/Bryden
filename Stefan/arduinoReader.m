% ENPH 257
% Alexander Goddijn
% Arduino interface

clc; close all; clear all;

a = arduino();
ai_pin = 0;
i=0;
tic;


while true
    i = i + 1;
    time(i) = toc;
    T0(i) = a.readVoltage(0)/10e-3;
    T1(i) = a.readVoltage(1)/10e-3;
    T2(i) = a.readVoltage(2)/10e-3;
    T3(i) = a.readVoltage(3)/10e-3;
    T4(i) = a.readVoltage(4)/10e-3;

    figure(1);
    plot(time, T0, 'y', time, T1, 'r', time, T2, 'g', time, T3, 'b', time, T4, 'm');
    xlabel('Time (s)');
    ylabel('Temperature (C)');
    legend( 'Temp1 at x=0', 'Temp2 at x=0.01', 'Temp3 at x=0.02', 'Temp4 at x=0.03', 'Temp5 RoomTemp');
    axis([0 inf 10 70]);
    
    
    pause(2);
end