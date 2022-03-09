%w2j.m (display the histogram using imhist)
clear all, close all, clc
P=imread('boy_b.bmp'); 
figure(1), 
subplot(1,2,1), imshow(P) 
subplot(1,2,2), imhist(P), axis tight
