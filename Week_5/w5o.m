%w5o.m (Region growing by pixel aggregation)
close all, clear all, clc
IO=imread('machine.bmp');
Img=im2double(IO);
figure(1),imshow(IO);  hold on, impixelinfo
%Choose seed point 
x=200; y=190;  %choose the seed point
%apply region growing starting fromt eh seed point
%the result is a logical data type
J = regiongrowing(Img,x,y,0.2); %threshold value is 0.2 
%superimpose the result to the original image
JJ=imadd(Img, double(J));
figure(2), imshow(JJ); impixelinfo
title('region growing by pixel aggregation')
hold on, plot(y,x,'r*'); %Show the seed point