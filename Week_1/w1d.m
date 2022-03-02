%w1d.m (display colour image and its components)
clear all, close all, clc
X=imread('colour1.bmp');
figure(1), imshow(X),title('Original')

XR=X(:,:,1);XG=X(:,:,2);;XB=X(:,:,3);

figure(2), imshow(XR),title('Red Intensity'),impixelinfo
figure(3), imshow(XG),title('Green Intensity'),impixelinfo
figure(4), imshow(XB),title('Blue Intensity'),impixelinfo
