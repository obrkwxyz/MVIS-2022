%w1f.m (conversion between colour model)
clear all, close all, clc
X=imread('flower_c.bmp');

XC=rgb2hsv(X);
XH=XC(:,:,1); XS=XC(:,:,2); XV=XC(:,:,3);
figure(1), imshow(X), title('the original image'), impixelinfo
figure(2), imshow(XH), title('Hue Intensity'), impixelinfo
figure(3), imshow(XS), title('Saturation Intensity'), impixelinfo
figure(4), imshow(XV), title('Value Intensity'), impixelinfo
figure(5), imshow(XC), title('HSV image displayed as RGB image'), impixelinfo
