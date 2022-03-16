%w3h.m (Colour component threshold)
clear all
close all
clc

W=imread('flower.png');

WR=W(:,:,1);
WG=W(:,:,2);
WB=W(:,:,3);
figure(1)

subplot(2,2,1)
    imshow(W)
    title('original')
    impixelinfo
subplot(2,2,2)
    imshow(WR)
    title('Red component')
    impixelinfo
subplot(2,2,3)
    imshow(WG)
    title('Green component')
    impixelinfo
subplot(2,2,4)
    imshow(WB)
    title('Blue component')
    impixelinfo

%Threshold
thR=150;
thG=60; 

WRT=WR>thR;
WGT=WG<thG;
WT=WRT& WGT;

figure(2)
subplot(1,2,1)
    imshow(WRT)
    title('Threshold using Red colour only')
subplot(1,2,2)
    imshow(WT)
    title('Threshold using Red & Green colours') 

