%w4m.m Combination of Opening and closing
close all, clear all, clc
C=imread('rocks.bmp'); W=imbinarize(C,graythresh(C));
se=strel('square',3); 
WC=imclose(W,se); WCO=imopen(WC,se);
WO=imopen(W,se); WOC=imclose(WO,se);
figure(1), 
subplot(1,2,1), imshow(C), title('original')
subplot(1,2,2), imshow(W),title('thresholded')
figure(2), 
subplot(2,2,1), imshow(WC), title('Closed')
subplot(2,2,2),  imshow(WO),title('Opened')
subplot(2,2,3), imshow(WCO), title('Closed->Opened')
subplot(2,2,4), imshow(WOC),title('Opened->Closed')
