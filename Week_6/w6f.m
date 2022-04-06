% w6f.m - chain code with a real image
clear all, close all, clc
f=imread('numcir.png');
figure(1), imshow(f), title('original image'), impixelinfo
FB=imbinarize(f, 100/255); %threshold applied
figure(2), imshow(FB), title('Binary image'), impixelinfo

%Find perimeters using bwperim
g=bwperim(FB,8); 
figure(3), imshow(g), title('perimeter of objects')
%chain code for the object with the label 4
[L, num]=bwlabel(g); 
a=zeros(size(FB));
a(L==4)=1;
figure(4),imshow(a), title('object with label 4')

a4a=chaincode4(a)
a8a=chaincode8(a)
