%w1h.m (Image addition to remove noise)
close all
clear all
clc

W=imread('pcb_n.bmp');
ntype = 'salt & pepper';
D = 0.1;
 

WN1=imnoise(W,ntype,D);
WN2=imnoise(W,ntype,D);

figure(1)
    imshow(WN1)
    pause
figure(2)
    imshow(WN2) 
    pause

WN3 = imadd(WN1,WN2);
WN4 = imsubtract(WN3,WN1);

figure(3)
    imshow(WN3)
    title ('image addition - to remove salt and pepper type noises')
    pause
figure(3)
    imshow(WN4)
    title ('image subtraction - to remove salt and pepper type noises')
    pause
display('End.')