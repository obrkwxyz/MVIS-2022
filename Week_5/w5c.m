%w5c.m (Laplacian of Gaussian(LOG) operator) 
close all, clear all, clc
C=imread('lena_g.bmp');
%First order derivative (Sobel Operator)
soh=fspecial('sobel');sov=soh'; 
SH1=imfilter(C,soh,'replicate');SH2=imfilter(C,sov,'replicate'); 
SH3=imadd(SH1,SH2);

%Laplacian filters
lap_fil=fspecial('laplacian',0.3); %laplacian filter
C_Lap=imfilter(C,lap_fil,'replicate'); 

log_fil=fspecial('log',13,1.2); % Gaussian smoothing filter 5x5 with s=1.2
C_LOG=imfilter(C,log_fil,'replicate');

figure(1), 
subplot(2,2,1), imshow(C), title('Original Image')
subplot(2,2,2), imshow(SH3,[]), impixelinfo, title('Sobel Operators')
subplot(2,2,3), imshow(C_Lap,[]), impixelinfo, title('Lapacian operator') 
subplot(2,2,4), imshow(C_LOG,[]), impixelinfo, title('LOG')