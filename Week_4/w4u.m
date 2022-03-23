%w4u.m skeletonising
clear all,close all, clc
W=imread('shapes_smallchanges.bmp');

BW1=bwmorph(W,'skel',inf);
figure(1), 
subplot(1,2,1), imshow(W),title('Original')
subplot(1,2,2),  imshow(BW1), title('skeletonising inf times')

 
