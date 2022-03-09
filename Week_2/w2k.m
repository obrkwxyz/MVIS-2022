%w2k.m (image hostogram using imhist)
clear all, close all, clc
P=imread('boy_b.bmp'); 

PW=imadjust(P, [], [0.1 0.5]); % make the image worse 
figure(1), 
subplot(1,2,1), imshow(PW),title('Original Image') 
subplot(1,2,2), imhist(PW), axis tight, title('Histogram')

%contrast stretching
PA=imadjust(PW, [0 0.5],[ ]); 

figure(2), 
subplot(1,2,1), imshow(PA),title('contrast adjusted image') 
subplot(1,2,2), imhist(PA), axis tight, title('Histogram')
