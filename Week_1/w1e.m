%w1e.m (create a colour image using cat command)
clear all
close all
clc
X=imread('flower_c.bmp');

XR = X(:,:,1); % Separate the individual channels
XG = X(:,:,2);
XB = X(:,:,3);

XG1 = XG;
XG1(:,:) = 0; % Make all intensity of green component 0

XM = cat(3, XR, XG1, XB); % make a new colour image
figure(1) 
subplot(1,2,1)
    imshow(X)
    title('the original image')
    impixelinfo
subplot(1,2,2)
    imshow(XM)
    title('after modification')
    impixelinfo
