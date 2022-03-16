%w3j.m (Histogram equalisation to each colour component)
clear all
close all
clc

W=imread('base_flower.bmp');

WR=W(:,:,1);
WG=W(:,:,2);
WB=W(:,:,3);
 
WR1=histeq(WR);
WG1=histeq(WG);
WB1=histeq(WB);

WE=cat(3,WR1,WG1,WB1);

figure(1)
subplot(1,2,1)
    imshow(W)
    title('original')
subplot(1,2,2)
    imshow(WE)
    title('Equalised Image')

%HE is applied to V only in HSV model
W_hsv=rgb2hsv(W); 
W_hsv(:,:,3) = histeq(W_hsv(:,:,3)); 
W2=hsv2rgb(W_hsv);

%There are less colour deformation in the result
figure(2)
subplot(1,3,1)
    imshow(W)
    title('original')
subplot(1,3,2)
    imshow(WE)
    title('RGB Equalised Image')
subplot(1,3,3)
    imshow(W2)
    title('V Equalised Image')