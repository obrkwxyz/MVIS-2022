%w2b.m (imcomplement, imadjust)
clear all, close all, clc 

W=imread('boy_b.bmp');

figure(1)
    imshow(W)
    title('Original image')

WC1=imcomplement(W);
figure(2)
    imshow(WC1)
    title('Negative image')

WC2=imadjust(W,[],[1 0]);
figure(3)
    imshow(WC2)
    title('Negative image using imadjust')

%Apply an image adjustment 
WA=imadjust(W, [0.1, 0.2], []);
figure(4)
    imshow(WA)
    title('adjusted image')

%Apply a threshold
W_T=imbinarize(W,0.80);
figure(5)
    imshow(W_T)
    title('intensity level higehr than 0.80*255 of original image') 
    %no pixels higher than 0.8 in adjusted image

WA_T=imbinarize(WA,0.80);
figure(6)
    imshow(WA_T)
    impixelinfo
    title('intensity level higehr than 0.80*255 of adjusted image')