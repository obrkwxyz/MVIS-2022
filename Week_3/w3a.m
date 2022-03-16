%w3a.m: RGB/HSV model-Intensity values of RGB/HSV
close all
clear all
clc

X=imread('circle.bmp');

%RGB colour model
XR=X(:,:,1);
XG=X(:,:,2);
XB=X(:,:,3);

figure(1)
subplot(2,2,1)
    imshow(X)
    title('Original')
    impixelinfo
subplot(2,2,2)
    imshow(XR)
    title('Red Intensity')
    impixelinfo
subplot(2,2,3)
    imshow(XG)
    title('Green Intensity')
    impixelinfo
subplot(2,2,4)
    imshow(XB)
    title('Blue Intensity')
    impixelinfo

%coversion to HSV colour model
X_HSV=rgb2hsv(X);

XH=X_HSV(:,:,1);
XS=X_HSV(:,:,2);
XV=X_HSV(:,:,3);

figure(2)
subplot(2,2,1)
    imshow(X_HSV),title('Original-HSV model'), impixelinfo
subplot(2,2,2)
    imshow(XH)
    title('Hue Intensity')
    impixelinfo
subplot(2,2,3) 
    imshow(XS)
    title('Saturation Intensity')
    impixelinfo
subplot(2,2,4)
    imshow(XV)
    title('Value Intensity')
    impixelinfo




