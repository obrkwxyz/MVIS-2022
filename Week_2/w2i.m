%w2i.m: Gray level slicing
clear all, close all, clc
C=imread('die.bmp');

%LUT1: pixels between 10 and 40 -> 200 and all others are reserved
T=0:255; T(10:40)=200; LUT1=uint8(T); 
C1=LUT1(C);
figure(1), 
imshowpair(C, C1,'montage'), impixelinfo
title('Original image and Gray-level Slicing (10-40 --> 200)')
