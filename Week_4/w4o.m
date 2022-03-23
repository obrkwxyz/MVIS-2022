%w4o.m Region Filling: number of coins
close all, clear all, clc
B=imread('coins.jpg');
%Apply a threshold
TH=graythresh(B); B_TH=imcomplement(imbinarize(B, TH));
[L1,n1]=bwlabel(B_TH); % number is wrong – due to noises
%filling the holes
BT_fill=imfill(B_TH,'holes');
[L2,n2]=bwlabel(BT_fill); 

figure(1), imshow(B),title('Original') 
figure(2), 
subplot(2,1,1), imshow(B_TH),
title(['Before region filling (noises): ', num2str(n1), ' objects'])
subplot(2,1,2), imshow(BT_fill),
title(['After region filling: ', num2str(n2), ' objects'])

%fill a specific object in the image using a starting point
B_IB=bwperim(BT_fill, 8);
BT_IB_fill=imfill(B_IB,[120,170],8); 
figure(3),imshow(BT_IB_fill), hold on, plot(40,50,'r*')
title('Region filling for a selected Component')

figure(2)
impixelinfo