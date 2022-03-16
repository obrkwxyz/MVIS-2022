%w3b.m: Intensity changes in Colour model
close all
clear all
clc

X=imread('circle.bmp');
XR=X(:,:,1);
XG=X(:,:,2);
XB=X(:,:,3);

figure(1), 
    subplot(2,2,1), imshow(X),title('Original'), impixelinfo
    subplot(2,2,2), imshow(XR),title('Red Intensity'), impixelinfo
    subplot(2,2,3), imshow(XG),title('Green Intensity'), impixelinfo
    subplot(2,2,4), imshow(XB),title('Blue Intensity'), impixelinfo

%coversion to HSV
X_HSV=rgb2hsv(X);
XH=X_HSV(:,:,1);
XS=X_HSV(:,:,2);
XV=X_HSV(:,:,3);

figure(2), 
    subplot(2,2,1), imshow(X_HSV),title('Original-HSV model'), impixelinfo
    subplot(2,2,2), imshow(XH),title('Hue Intensity'), impixelinfo
    subplot(2,2,3), imshow(XS),title('Saturation Intensity'), impixelinfo
    subplot(2,2,4), imshow(XV),title('Value Intensity'), impixelinfo

%Reduce the intensity of the original image
XR1=imadjust(XR, [],[0 0.5]);
XG1=imadjust(XG, [],[0 0.5]);
XB1=imadjust(XB, [],[0 0.5]);
XA1=cat(3, XR1, XB1, XG1); 

figure(3), 
    subplot(1,2,1), imshow(X),title('Original image'), impixelinfo
    subplot(1,2,2), imshow(XA1),title('Modified image from RGB model'), impixelinfo

%we change the intensity values of "V" in HSV model to see the effects of
%intensity change to colour values in RGB and HSV
XV1=imadjust(XV, [],[0 0.5]);
XA_HSV=cat(3, XH, XS, XV1); 
XA=hsv2rgb(XA_HSV); %double data type
XA=uint8(XA*255); %to convert intensity values to uint8(0-255)

figure(4)
subplot(2,2,1)
    imshow(X)
    title('Original image')
    impixelinfo
subplot(2,2,2)
    imshow(XA)
    title('Modified image from HSV model')
    impixelinfo
subplot(2,2,3)
    imshow(XA1)
    title('Modified image from RGB model')
    impixelinfo
%% Class activity
% Seperate the yellow spot.

Xyel = XR>200 & XG > 200 & XB < 1;

figure(5)
    imshow(Xyel);
    title('Yellow spot only')
    impixelinfo