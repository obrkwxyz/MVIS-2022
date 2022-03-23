%w4ya.m (Morphological Smoothing: Open-Close or Close-Open): Remove noises
clear all,close all, clc
%remove salt and pepper type noises
WO=imread('lena_g.bmp');
W=imnoise(WO, 'salt & pepper', 0.05);
figure(3), imshow(W),title('Original')
SE1=strel('square',3);
 
WC=imclose(W,SE1); WCO=imopen(WC,SE1);
WO=imopen(W,SE1); WOC=imclose(WO,SE1);

figure(4), 
subplot(2,2,1), imshow(WC), title('Closed')
subplot(2,2,2), imshow(WCO),title('Close - Open')
subplot(2,2,3), imshow(WO), title('Opened')
subplot(2,2,4), imshow(WOC),title('Open - Close')
