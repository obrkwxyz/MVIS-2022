%w5l.m (Hough transform: find peaks points in  
% accumulator array using houghpeaks.m)
close all, clear all, clc
w5k
% The number of lines to be detected = "2"
% threshold value = "5"
peaks=houghpeaks(H,2,'Threshold', 5); 
hold on %we put the peaks to the hough transform matrix plot(figure(2))
figure(2)
plot(theta(peaks(:,2)), rho(peaks(:,1)),...
    'linestyle','none','marker','square', 'color','r')
% linestyle: we choose "none" since we do not want n
% to have any connectio between two peaks 
% marker: suqare-put square marker on peaks with color "red"