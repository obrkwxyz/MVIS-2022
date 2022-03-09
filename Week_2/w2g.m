%w2g.m (LUT 64 levels)
clear all, close all,clc
%Generate LUT: uniformly ranged 0-64
LUT1=uint8(floor(0:255)/4); 
E=imread('boy_b.bmp'); 
% need this line to remove index 0. LUT cannot be applied to "0"
E1=LUT1(E+1); %apply LUT1 to the image
figure(1), imshow(E), title('256 intensity level')
figure(2), imshow(E1), title('64 intensity levels')
figure(3), imshow(E1,gray(64)),
title('64 intensity levels with 64 gray scale map') 

