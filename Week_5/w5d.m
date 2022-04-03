%w5d.m derivative filters - sensitive to noises 
close all, clear all, clc
C=imread('lena_g.bmp');
%Add some noise to see how sensitive these filters are 
CN=imnoise(C, 'salt & pepper', 0.02);

%First order derivative (Sobel Operator)
soh=fspecial('sobel');sov=soh'; 
SH1N=imfilter(CN,soh,'replicate');SH2N=imfilter(CN,sov,'replicate'); 
SH3N=imadd(SH1N,SH2N);

%Laplacian filters
lap_fil=fspecial('laplacian',0.3); %laplacian filter
CN_Lap=imfilter(CN,lap_fil,'replicate'); 

log_fil=fspecial('log',13,2); % Gaussian smoothing filter 5x5 with s=1.2
CN_LOG=imfilter(CN,log_fil,'replicate');

figure(1), 
subplot(2,2,1), imshow(CN), title('Original Image')
subplot(2,2,2), imshow(SH3N,[]), impixelinfo, title('Sobel Operators')
subplot(2,2,3), imshow(CN_Lap,[]), impixelinfo, title('Lapacian operator') 
subplot(2,2,4), imshow(CN_LOG,[]), impixelinfo, title('LOG')

