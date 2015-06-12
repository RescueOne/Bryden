% ENPH 257
% Alexander Goddijn
% Arduino interface

clc; close all; clear all;

a = arduino();
ai_pin = 0;
i=0;
tic;
while toc < 60
    i = i + 1;
    time(i) = toc;
    v(i) = a.readVoltage(ai_pin);
    figure(1);
    plot(time, v, 'r');
    pause(0.25);
end