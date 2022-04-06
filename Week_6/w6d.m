% w6d.m - find function to find specific coordinates
clear all, close all, clc
f=imread('numcir.png');
figure(1), imshow(f), title('original image'), impixelinfo
FB=imbinarize(f, 100/255); %threshold applied
figure(2), imshow(FB), title('Binary image'), impixelinfo

[L, num]=bwlabel(FB, 4); 
figure(2), imshow(L, []), title('the result of bwlabel'), impixelinfo
%find the corodinates of all labels with specific number 
%in this example, we use L==2
[rr cc]=find(L==2); [M,N]=size(rr); 
disp('Coordinates of the object with label 2')
[rr cc] %display the coordinates of all pixels with label=2

