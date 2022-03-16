%w3c.m: LAB colour model
close all
clear all
clc

X=imread('button1.jpg');

%Generate Lab colour transformation structure 
cform = makecform('srgb2lab'); 

XH = applycform(X,cform); %Apply it to the image
XL = XH(:,:,1);
Xa = XH(:,:,2);
Xb = XH(:,:,3);

figure(1),
subplot(2,2,1)
    imshow(X)
    title('Original');
subplot(2,2,2)
    imshow(XL)
    title('L Intensity')
    impixelinfo
subplot(2,2,3)
    imshow(Xa)
    title('a Intensity(green-red)')
    impixelinfo
subplot(2,2,4)
    imshow(Xb)
    title('b Intensity(blue-yellow)')
    impixelinfo

X_LAB=rgb2lab(X);

XL2 = X_LAB(:,:,1);
Xa2 = X_LAB(:,:,2);
Xb2 = X_LAB(:,:,3);

figure(2) %make sure to put [] in imshow to display it correctly
subplot(2,2,1)
    imshow(X)
    title('Original');
subplot(2,2,2)
    imshow(XL2,[])
    title('L Intensity')
    impixelinfo
subplot(2,2,3)
    imshow(Xa2,[])
    title('a Intensity(green-red)')
    impixelinfo
subplot(2,2,4)
    imshow(Xb2,[])
    title('b Intensity(blue-yellow)')
    impixelinfo