%w3d.m: different colour models
close all
clear all
clc

Y=imread('board.tif');

Y_YIQ=rgb2ntsc(Y); %YIQ model
Y_YCbCr=rgb2ycbcr(Y); %YCbCr model

figure(1)
subplot(1,3,1)
    imshow(Y)
    title('Original')
subplot(1,3,2)
    imshow(Y_YIQ)
    title('YIQ model')
    impixelinfo
subplot(1,3,3)
    imshow(Y_YCbCr)
    title('YCbCr model')
    impixelinfo

YR=Y(:,:,1);
YG=Y(:,:,2); 
YB=Y(:,:,3);

YY=Y_YIQ(:,:,1);
YI=Y_YIQ(:,:,2);
YQ=Y_YIQ(:,:,3);

YYY=Y_YCbCr(:,:,1);
YCb=Y_YCbCr(:,:,2);
YCr=Y_YCbCr(:,:,3);

figure(2)
subplot(1,4,1)
    imshow(Y)
    title('Original');
subplot(1,4,2)
    imshow(YR)
    title('Red Intensity')
    impixelinfo
subplot(1,4,3)
    imshow(YG)
    title('Green Intensity')
    impixelinfo
subplot(1,4,4)
    imshow(YB)
    title('Blue Intensity')
    impixelinfo

figure(3)
subplot(1,4,1)
    imshow(Y_YIQ)
    title('YIQ modle');
subplot(1,4,2)
    imshow(YY)
    title('Y Intensity')
    impixelinfo
subplot(1,4,3)
    imshow(YI)
    title('I Intensity')
    impixelinfo
subplot(1,4,4)
    imshow(YQ)
    title('Q Intensity')
    impixelinfo

figure(4)
subplot(1,4,1)
    imshow(Y_YCbCr)
    title('YCbCr model');
subplot(1,4,2)
    imshow(YYY)
    title('Y Intensity')
    impixelinfo
subplot(1,4,3)
    imshow(YCb)
    title('Cb Intensity')
    impixelinfo
subplot(1,4,4)
    imshow(YCr)
    title('Cr Intensity')
    impixelinfo
