%w2t.m: Roberts/sobel/prewitt gradient Operator
close all, clear all, clc
N=imread('lena_g.bmp');
% Roberts gradient Operators
disp('Roberts operator-Horisontal'), RH1=[1 0;0 -1]
disp('Roberts operator-Vertical'), RH2=[0 1;-1 0] 
RN1=imfilter(N,RH1,'replicate'); RN2=imfilter(N,RH2,'replicate');
RN3=imadd(RN1,RN2);
RN4=imsubtract(N, RN3);

%Sobel gradient operators 
disp('sobel operator-Horisontal'), soh=fspecial('sobel') 
disp('sobel operator-Vertical'), sov=soh'
SN1=imfilter(N,soh,'replicate'); SN2=imfilter(N,sov,'replicate');
SN3=imadd(SN1,SN2);
SN4=imsubtract(N, SN3);

% Prewitt gradient operators
disp('Prewitt operator-Horisontal'), Prewh=fspecial('prewitt')
disp('Prewitt operator-vertical'), Prewv=Prewh'
PN1=imfilter(N,Prewh,'replicate'); PN2=imfilter(N,Prewv,'replicate');
PN3=imadd(PN1,PN2);
PN4=imsubtract(N, PN3);

figure(1), 
subplot(2,2,1), imshow(N),title('Original Image')
subplot(2,2,2), imshow(RN3),title('Robert filter')
subplot(2,2,3), imshow(RN4),title('Robert filter combined with original imaege')

figure(2), 
subplot(2,2,1), imshow(N),title('Original Image')
subplot(2,2,2), imshow(SN3),title('Sobel Operator')
subplot(2,2,3), imshow(SN4),title('Sobel Operator combined with original imaege')

figure(3), 
subplot(2,2,1), imshow(N),title('Original Image')
subplot(2,2,2), imshow(PN3),title('Prewitt Operator')
subplot(2,2,3), imshow(PN4),title('Prewitt Operator combined with original imaege')
