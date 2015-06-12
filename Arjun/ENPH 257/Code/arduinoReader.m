% ENPH 257
% Stefan Sander-Green, Arjun Venkatesh
% Arduino interface to collect temperature data for an Aluminium Rod

clc; close all; clear all;

a = arduino();

%mV to Celsius conversion factor
Celsius = 10e-3;

%define temperature sensors as analog inputs
tempSensor1 = 'A0';
tempSensor2 = 'A1';
tempSensor3 = 'A2';
tempSensor4 = 'A3';
tempSensor5 = 'A4';

i=0;

tic;


while true
    i = i + 1;
    time(i) = toc;
    T1(i) = a.readVoltage(tempSensor1)/Celsius;
    T2(i) = a.readVoltage(tempSensor2)/Celsius;
    T3(i) = a.readVoltage(tempSensor3)/Celsius;
    T4(i) = a.readVoltage(tempSensor4)/Celsius;
    T5(i) = a.readVoltage(tempSensor5)/Celsius;

    figure(1);
    plot(time, T1, 'y', time, T2, 'r', time, T3, 'g', time, T4, 'b', time, T5, 'm');
    xlabel('Time (s)');
    ylabel('Temperature (C)');
    legend( 'Temp1 at x=0', 'Temp2 at x=0.01', 'Temp3 at x=0.02', 'Temp4 at x=0.03', 'Temp5 RoomTemp', 'Location', 'northwest');
    axis([0 inf 10 100]);
    
    pause(5);
end