%w1g.m Image addition and subtraction
close all,clear all, clc
H1=imread('coin1.bmp');
H2=imread('coin2.bmp');
figure(1)
subplot(1,2,1), imshow(H1),title('original image 1') 
subplot(1,2,2), imshow(H2),title('original image 2') 
 
HA=imadd(H1,H2); HD=imsubtract(H1,H2);
figure(2)
subplot(1,2,1),imshow(HA), title('Image addition')
subplot(1,2,2),imshow(HD), title('Image subtraction')

HMax=max(H1,H2);HMin=min(H1,H2);
figure(3),
subplot(1,2,1),imshow(HMax), title('Image - Maximum')
subplot(1,2,2),imshow(HMin), title('Image - Minimum')