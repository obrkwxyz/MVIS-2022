%w4v.m (Dilation and Erosion with arbitrary/square SE)
clear all,close all, clc
W=imread('lena_g.bmp');
figure(1), imshow(W),title('Original'), impixelinfo

%with an arbitrary SE
SE1=strel(ones(3,3),[1 9 1;1 9 1;1 9 1]); 
WD1=imdilate(W,SE1); WE1=imerode(W,SE1);
figure(2), 
subplot(1,2,1), imshow(WD1),impixelinfo
title('Dilated with arbitrary SE')
subplot(1,2,2), imshow(WE1),impixelinfo
title('Eroded with arbitrary SE')

%with a square SE
SE2=strel('square',3);
WD2=imdilate(W,SE2); WE2=imerode(W,SE2);
figure(3), 
subplot(1,2,1), imshow(WD2),impixelinfo
title('Dilated with 3x3 square SE')
subplot(1,2,2), imshow(WE2),impixelinfo
title('Eroded with 3x3 square SE')
