%w4a.m Image Dilation and erosion
close all
clear all
clc
W=imread('shapes.png');

%create structural element (5x5 size)
SE1 = strel('diamond',5)
SE2 = strel('square',7) 

%apply dilation and erosion
W_D1 = imdilate(W,SE1);
W_E1 = imerode(W,SE1);

W_D2 = imdilate(W,SE2);
W_E2 = imerode(W,SE2);

figure(1)
    imshow(W)
    title('Original')
    pause(1/10)

figure(2) 
subplot(2,2,1)
    imshow(W_D1)
    title('Dilated with diamond SE')
subplot(2,2,2)
    imshow(W_E1)
    title('Eroded with diamond SE')
subplot(2,2,3)
    imshow(W_D2)
    title('Dilated with square SE')
subplot(2,2,4)  
    imshow(W_E2)
    title('Eroded with Square SE')
