% w6s.m - Normalised central moment
close all, clear all, clc
fg=imread('spanners.bmp');
%fg=imread('shapes1.bmp');

figure(1), imshow(fg), title('original image'), impixelinfo
[L,num]=bwlabel(fg); HU=zeros(num,4);
nor_mom=zeros(num,8);
for i=1:num;
fi=zeros(size(fg)); 
%find the each labelled item and display it
ind=find(L==i);fi(ind)=1; 
figure(i+1), imshow(fi), title(['image ' num2str(i)])
%obtain the statistical moments using invmoments function
nor_mom(i,:)=[i invmoments(fi)];
end
figure(max(i)+2), imshow(L, []), impixelinfo
title('The normalised central moments'); 
nor_mom