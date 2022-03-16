%w3i.m (Colour component threshold)
clear all
close all
clc

W=imread('button2.jpg');

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

%threshold - for each colour component
WRT= WR>120 & WR<180; 
WGT= WG<50;
WBT= WB<40;
W_Th = WRT & WGT & WBT; %Logical operation should be used

figure(2)
subplot(2,2,1)
    imshow(WRT)
    title('red colour thresholding') 
subplot(2,2,2)
    imshow(WGT)
    title('green colour thresholding')
subplot(2,2,3)
    imshow(WBT)
    title('blue colour thresholding')
subplot(2,2,4)
    imshow(W_Th)
    title('combine together')
