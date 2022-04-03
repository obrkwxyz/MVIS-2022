%w5f.m (Edge function with edge command) 
close all, clear all, clc
C=imread('lena_g.bmp');

%Apply Sobel Operator
soh=fspecial('sobel');sov=soh'; 
SH1=imfilter(C,soh,'replicate');SH2=imfilter(C,sov,'replicate'); 
SH3=imadd(SH1,SH2);  

%Sobel operator with edge function
CS=edge(C,'sobel', 0.05); 
figure(1), 
subplot(2,2,1), imshow(C), title('Original Image')
subplot(2,2,2), imshow(SH3,[]), impixelinfo, title('Sobel Operators')
subplot(2,2,3), imshow(SH3>65,[]), impixelinfo, title('Sobel Operators+threshold applied')
subplot(2,2,4), imshow(CS), title('edge function with Sobel operator')

