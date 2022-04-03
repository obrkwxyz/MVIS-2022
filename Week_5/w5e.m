%w5e.m (Marr-Hildreth method) 
clear all, close all, clc
C=imread('machine.bmp');

% signma=2 and 13x13 window size with automatic threshold value selection
[C_MH,threshOut]= edge(C,'log');

figure(1), imshow(C), title('Original')
figure(2), imshow(C_MH), 
title(['Automatic - Threshold value: ', num2str(threshOut)])

T=0.0002;
[C_MHT,threshOut]= edge(C,'log',T);
figure(3), imshow(C_MHT), 
title(['Threshold value: ', num2str(threshOut)])
