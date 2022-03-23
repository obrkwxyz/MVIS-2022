%w4d.m Image erosion - real Application
close all
clear all
clc

T=imread('ic_con.bmp'); 

%apply a threshold
TT = T<40; 

% a medium size SE is chosen to remove all unnecessary pixel clusters
SE = strel('square',9); 
td = imerode(TT,SE);

% number of lid 
[L_td, num] = bwlabel(td);

figure(1)
subplot(2,2,1)
    imshow(T)
    title('Original') 
subplot(2,2,2)
    imshow(TT)
    title('Thresholded') 
subplot(2,2,3)
    imshow(td)
    title(['After image erosion - number of lid: ', num2str(num)])
    pause(1/10)