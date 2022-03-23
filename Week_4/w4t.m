%w4t.m skeletonising
clear all,close all, clc
W=imread('shapes.png');
 
BW1=bwmorph(W,'thin',inf);
BW3=bwmorph(W,'skel',inf);
figure(1), 
subplot(1,3,1), imshow(W),title('Original')
subplot(1,3,2), imshow(BW1),title('Thining inf times')
subplot(1,3,3),  imshow(BW3), title('skeletonising inf times')
