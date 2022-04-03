%w5g.m (Canny edge detector) 
close all, clear all, clc
C=imread('machine.bmp');
%automatic selection of threshold value (with default sigma value = sqrt(2))
[CB,T]= edge(C,'canny');

figure(1), 
subplot(121), imshow(C),title('Original Image')
subplot(122), imshow(CB), title(['sigma=sqrt(2) with high T= ', num2str(T(2))])

%with the automatic threshold value and with different sigma
CB1=edge(C,'canny',T,1); %sigma =1
CB2=edge(C,'canny',T,3); %sigma =3

figure(2), 
subplot(121), imshow(CB1),title(['sigma=1 with high T= ', num2str(T(2))])
subplot(122), imshow(CB2), title(['sigma=3 with high T= ', num2str(T(2))])

%canny detector with different threshold values 
%low threshold is 0.4* high threshold value
CB3=edge(C,'canny',0.05,1); CB4=edge(C,'canny',0.2,1); 
figure(3), 
subplot(121), imshow(CB3),title('s=1 and High T=0.05')
subplot(122), imshow(CB4),title('s=1 and High T=0.2')

%Canny detector with both low and high threshold values
CB5=edge(C,'canny',[0.01 0.05],1);CB6=edge(C,'canny',[0.02 0.07],1);
figure(4), 
subplot(121), imshow(CB5),title('s=1, High T=0.05 & Low T=0.01')
subplot(122), imshow(CB6),title('s=1 , High T=0.07 & Low T=0.02')

%Comparison with Marr-Hildreth method
%signma=2 and 13x13 window size with automatic threshold value selection
[C_MH,threshOut]= edge(C,'log');
figure(5), 
subplot(121),imshow(C_MH), 
title(['MArr-Hildreth Method - Threshold value: ', num2str(threshOut)])
subplot(122), imshow(CB), title(['Canny Detector: sigma=sqrt(2) with high T= ', num2str(T(2))])