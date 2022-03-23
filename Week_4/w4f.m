%w4f.m Effect of Image opening and closing - noise removal
close all
clear all
clc
W=imread('co_ex.bmp');

%square structural element (3x3 size)
sq = strel('square',7);

WE = imerode(W,sq);
WO = imopen(W,sq);

WD = imdilate(W,sq);
WC = imclose(W,sq);

figure(1)
    imshow(W)
    title('original')
    pause(1/10)

figure(2)
subplot(2,2,1)
    imshow(WE)
    title('Erosion') 
subplot(2,2,2)
    imshow(WO)
    title('Opening=erosion--> dilation') 
subplot(2,2,3)
    imshow(WD)
    title('Dilation') 
subplot(2,2,4)
    imshow(WC)
    title('Closing=dilation-->erosion') 
    pause(1/10)

