%w6u.m: texture descriptor - How to use it
clc, clear all, close all, clc
I = imread('circuit.tif');
figure(1), imshow(I), impixelinfo
[glcm1,SI1] = graycomatrix(I);
glcm1
figure(2), imshow(rescale(SI1)),impixelinfo
stats1 = graycoprops(glcm1)
