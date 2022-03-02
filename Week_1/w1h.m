%w1h.m (Image addition to remove noise)
close all, clear all,clc
ntype='salt & pepper'; D=0.1;
 
W=imread('pcb_n.bmp');
WN1=imnoise(W,ntype,D); WN2=imnoise(W,ntype,D);
figure(1), imshow(WN1),figure(2), imshow(WN2)  
WN3=imadd(WN1,WN2); 
figure(3), imshow(WN3), 
title ('image addition - to remove salt and pepper type noises')