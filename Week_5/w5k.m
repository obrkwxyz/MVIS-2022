%w5k.m (Hough transform: Accumulator array using hough.m)
close all, clear all, clc
%Create an image for the example given in the lecture sldies 
f=zeros(50,50);
for i=15:32; f(i, i+7)=1; end 
f(19,26)=0; f(20,27)=0;f(21,28)=0;
f(26,33)=0; f(27,34)=0; f(28,35)=0;f(29,36)=0;
for i=10:2:24; f(i,60-2*i)=1;end
f(10,10)=1; f(5,25)=1;f(45,45)=1;f(41,25)=1;
f=uint8(f);

figure(1), imshow(imresize(f,4,'nearest'),[]); impixelinfo
title('original image')

% find the accumulator array for the image
[H, theta,rho]=hough(f,'ThetaRes',0.1,'RhoRes',0.1);
figure(2), imshow(H,[],'XData',theta,'YData',rho); impixelinfo
axis on, axis normal, xlabel('\theta'),ylabel('\rho')
title('Accumulator Array (Hough transformation matrix)')
