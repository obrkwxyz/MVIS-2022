%w2u.m Prewitt operators
close all, clear all, clc
N=imread('dotted.bmp');
Prew1=[-1 1 1;-1 -2 1;-1 1 1]; %West direction filter
Prew2=[-1 -1 -1;1 -2 1;1 1 1]; %North direction filter
    
NH1=imfilter(N,Prew1,'replicate');
NH2=imfilter(N,Prew2,'replicate');
NH3=imadd(NH1,NH2);

figure(1), 
subplot(2,2,1), imshow(N),title('Original Image')
subplot(2,2,2), imshow(NH1),title('Prewitt W')
subplot(2,2,3), imshow(NH2),title('Prewitt N')
subplot(2,2,4), imshow(NH3),title('Prewitt W+N together')