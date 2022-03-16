%w3g.m: pseudo colouring (hanger)
clear all
close all
clc

W_gray=imread('airport_xray.png');

figure(1)
    imshow(W_gray)
    title('Gray scale X-ray image')
    impixelinfo

WR=W_gray;
WG=W_gray;
WB=W_gray;

%for metal part=Blue colour
W_metal=W_gray<110;
WR(W_metal==1)=0; 
WG(W_metal==1)=0; 
WB(W_metal==1)=255;

%for plastic - green colour
W_pla=W_gray<=200 & W_gray>110;
WR(W_pla==1)=0; 
WG(W_pla==1)=255; 
WB(W_pla==1)=0;

%Pseudo colouring
W_pseudo=cat(3, WR, WG,WB);

figure(2)
    imshow(W_pseudo)
    title('Pseudo coloured image')

