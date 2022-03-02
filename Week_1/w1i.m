%w1i.m (first image processing technique)
close all
clear all
clc

W=imread('light.tif');
figure(1)
    imshow(W)
    title('Original Image')
    impixelinfo
pause

% Separeate the Channels
WR = W(:,:,1);
WG = W(:,:,2);
WB = W(:,:,3);

% Show the channels
figure(2)
    imshow(WR)
    title('Red Intensity')
    impixelinfo
pause

figure(3)
    imshow(WG)
    title('Green Intensity')
    impixelinfo
pause

figure(4)
    imshow(WB)
    title('Blue Intensity')
    impixelinfo
pause

% Crop Image
WC = W(220:280, 70:140, :);
figure(5)
    imshow(WC)
    title('Cropped Image')
    impixelinfo
pause

%thresholding in colour image
WGT = WG > 150;
figure(6)
    imshow(WGT)
    title('threshold applied to green colour component')
pause

WRT = WR < 50; 
figure(7)
    imshow(WRT)
    title('threshold applied to red colour component')
pause

WT = WGT & WRT;
figure(8)
    imshow(WT)
    title('Threshold image')
pause