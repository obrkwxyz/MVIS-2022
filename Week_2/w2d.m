%w2d.m (Threshold)
clear all, close all, clc
C=imread('rice.bmp');
C1=imbinarize(C,100/255); 
C2=imbinarize(C,132/255); 
C3=imbinarize(C,170/255);
figure(1), 
subplot(2,2,1)
    imshow(C)
    title('original image')
    impixelinfo
subplot(2,2,2)
    imshow(C1)
    title('T=0.39(*255=100)')
    impixelinfo
subplot(2,2,3)
    imshow(C2)
    title('T=0.52(*255=132)')
    impixelinfo
subplot(2,2,4)
    imshow(C3)
    title('T=0.67(*255=170)')
    impixelinfo