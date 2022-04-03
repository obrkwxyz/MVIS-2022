%w5b.m (Gradient Operators) 
close all, clear all, clc
N=imread('building.bmp');
% Roberts Operators
H1=[1 0;0 -1]; H2=[0 1;-1 0]; 
NH1=imfilter(N,H1,'replicate'); NH2=imfilter(N,H2,'replicate'); 
NH3=imadd(NH1,NH2); 
%Soble Operator
soh=fspecial('sobel');sov=soh'; 
SH1=imfilter(N,soh,'replicate');SH2=imfilter(N,sov,'replicate'); 
SH3=imadd(SH1,SH2);
%prewitt filter 
Prewh=fspecial('prewitt');Prewv=Prewh'; 
PH1=imfilter(N,Prewh,'replicate'); PH2=imfilter(N,Prewv,'replicate'); 
PH3=imadd(PH1,PH2);
 
figure(1), 
subplot(2,2,1), imshow(N),title('Original Image')
subplot(2,2,2), imshow(NH3),title('Robert filter'), impixelinfo
subplot(2,2,3), imshow(SH3),title('Sobel filter'), impixelinfo
subplot(2,2,4), imshow(PH3),title('Prewitt filter'), impixelinfo

%a threshold applied
figure(2),
subplot(2,2,1), imshow(N),title('Original Image')
subplot(2,2,2), imshow(NH3>30),title('Robert filter with Th>30'), impixelinfo
subplot(2,2,3), imshow(SH3>50),title('Sobel filter with Th>50'), impixelinfo
subplot(2,2,4), imshow(PH3>50),title('Prewitt filter with Th>50'), impixelinfo
