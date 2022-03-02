%w1g.m Image addition and subtraction
close all,clear all, clc
H1=imread('coin1.bmp');
H2=imread('coin2.bmp');

figure(1)
subplot(1,2,1)
    imshow(H1)
    title('original image 1') 
subplot(1,2,2)
    imshow(H2)
    title('original image 2') 
pause

HA = imadd(H1,H2); % image addition -- is this much different to matrix addition?
HD = imsubtract(H1,H2); 

HA1 = H1+H2;
HD1 = H1-H2;

figure(2)
subplot(1,2,1)
    imshow(HA)
    title('Image addition')
subplot(1,2,2)
    imshow(HD)
    title('Image subtraction')
    pause

figure(4)
subplot(1,2,1)
    imshow(HA1)
    title('Matrix addition')
subplot(1,2,2)
    imshow(HD1)
    title('Matrix subtraction')
    pause

HMax=max(H1,H2);
HMin=min(H1,H2);

figure(3),
subplot(1,2,1)
    imshow(HMax)
    title('Image - Maximum')
subplot(1,2,2)
    imshow(HMin)
    title('Image - Minimum')
    pause
display('End')