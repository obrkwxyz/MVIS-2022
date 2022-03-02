%w1f.m (conversion between colour model)
clear all
close all
clc
X=imread('flower_c.bmp');

XC=rgb2hsv(X); % Convert to HSV

XH=XC(:,:,1);  % Separate the individual channels
XS=XC(:,:,2);
XV=XC(:,:,3);


figure(1)
    imshow(X)
    title('the original image')
    impixelinfo
    pause
figure(2)
    imshow(XH)
    title('Hue Intensity')
    impixelinfo
    pause
figure(3)
    imshow(XS)
    title('Saturation Intensity')
    impixelinfo
    pause
figure(4)
    imshow(XV)
    title('Value Intensity')
    impixelinfo
    pause
figure(5)
    imshow(XC)
    title('HSV image displayed as RGB image')
    impixelinfo
    pause
display('End')
