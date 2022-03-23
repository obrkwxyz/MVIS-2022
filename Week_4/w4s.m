%w4s.m Thinning/Thickening process - Dual relation
clear all,close all, clc
W=imread('shapes.png');
SE1=strel('square', 3);
W_thin1=bwmorph(W,'thin',1);
W_erode1=imerode(W, SE1);
figure(1), imshow(W_thin1), title('image thinning');
figure(2), imshow(W_erode1), title('image erosion');

W_thin2=bwmorph(W,'thin',5);
W_thin3=bwmorph(W,'thin',inf);
%thinning process
figure(1), 
subplot(2,2,1), imshow(W),title('Original')
subplot(2,2,2), imshow(W_thin1),title('Thining Once')
subplot(2,2,3), imshow(W_thin2),title('Thining five time')
subplot(2,2,4), imshow(W_thin3),title('Thining inf times')
%skeleton using thinning process
DB=W & ~W_thin3; 
figure(2), imshow(DB), 
title('the result of infinite thining process combined with the original image')

%thickening process
W_thick1=bwmorph(W, 'thicken',1);
W_thick2=bwmorph(W, 'thicken',5);
W_thick3=bwmorph(W, 'thicken',inf);
figure(3), 
subplot(2,2,1), imshow(W),title('Original')
subplot(2,2,2), imshow(W_thick1), title('thickening once')
subplot(2,2,3), imshow(W_thick2), title('thickening 5 times')
subplot(2,2,4), imshow(W_thick3), title('thickening infinite times')

%Dual relationship
BW1=bwmorph(W,'thin',5);
BW1C=imcomplement(BW1);
 
WC=imcomplement(W);
BW2=bwmorph(WC,'thicken',5);

figure(4), 
subplot(2,2,1), imshow(BW1),title('Thining')
subplot(2,2,2), imshow(BW1C), title('Complement of Thinning')
subplot(2,2,3), imshow(WC), title('Complement of Original')
subplot(2,2,4), imshow(BW2), title('Thickening of complement of Original')
