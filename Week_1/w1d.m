%w1d.m (display colour image and its components)
clear all
close all
clc
X=imread('colour1.bmp');
figure(1)
    imshow(X)
    title('Original Image')
    pause

XR=X(:,:,1); % Display Red Channel
XG=X(:,:,2); % Display Green Channel
XB=X(:,:,3); % Display Blue Channel

figure(2)
    imshow(XR)
    title('Red Intensity')
    impixelinfo
    pause
figure(3)
    imshow(XG)
    title('Green Intensity')
    impixelinfo
    pause
figure(4)
    imshow(XB)
    title('Blue Intensity')
    impixelinfo
    pause
display('End.')
