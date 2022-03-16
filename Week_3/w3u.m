%w3q.m Interpolation: three methods with real image 
close all,clear all, clc
C=imread('josh1_g.bmp');
%choose a small area to enlarge(around the head in the image)
r1=75; r2=120; c1=105;c2=150; eyes=C(c1:c2, r1:r2);
figure(1), imshow(C), impixelinfo
%put a line around the small area
line([r1 r1 r2 r2 r1],[c1 c2 c2 c1 c1],'color','r')

eyes4n=imresize(eyes,16,'nearest'); 
eyes4bl=imresize(eyes,16,'bilinear'); 
eyes4bc=imresize(eyes,16,'bicubic'); 

figure(2), imshow(eyes),title('original Image')
figure(3), 
subplot(2,2,1), imshow(eyes4n),title('nearest interpolation'), impixelinfo
subplot(2,2,2), imshow(eyes4bl), title('bilinear interpolation'), impixelinfo
subplot(2,2,3), imshow(eyes4bc), title('bicubic interpolation'), impixelinfo
