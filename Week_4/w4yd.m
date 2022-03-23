%w4yd.m (Morphological Gradient and Laplacian (Edge Detection)
clear all,close all, clc
W=imread('aerial.jpg'); 
figure(1), imshow(W),title('Original')
SE1=strel('disk',3); 
DW=imdilate(W,SE1); EW=imerode(W,SE1);
MG=imsubtract(DW,EW); % Morphological Gradient
ML=imsubtract(imsubtract(DW,W),imsubtract(W,EW)); % Morphological Lapacian
 
figure(2), 
subplot(1,2,1), imshow(DW),title('Dilated')
subplot(1,2,2), imshow(EW),title('Eroded')
figure(3)
subplot(1,2,1), imshow(MG,[]),title('Morphological Gradient'), impixelinfo
subplot(1,2,2), imshow(ML,[]),title('Morphological Laplacian'), impixelinfo
