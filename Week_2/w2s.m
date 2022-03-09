%w2s.m: horizontal and vertical sharpening Filter
clear all, close all, clc
N=imread('die.bmp');
disp('high pass filter')
H1=[-1 -1 -1;-1 8 -1;-1 -1 -1] %Simple High-pass filter
disp('Horisontal filter') 
SH=[-1 -1 -1;0 0 0;1 1 1] %Horizontal Filter 
disp('vertical filter')
VH=[-1 0 1;-1 0 1;-1 0 1] %Vertical Filter
 
WH1=imfilter(N,H1,'replicate'); 
NH1=imfilter(N,SH,'replicate'); NH2=imfilter(N,VH,'replicate');
NH3=imadd(NH1,NH2);

figure(1), imshow(N),title('Original Image')
figure(2), 
subplot(2,2,1), imshow(WH1),title('Simple High-pass Filter')
subplot(2,2,2), imshow(NH1),title('Horizontal Filter')
subplot(2,2,3), imshow(NH2),title('Vertical Filter')
subplot(2,2,4), imshow(NH3),title('Horinzontal+Vertical Filter')