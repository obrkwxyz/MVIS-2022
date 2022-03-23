%w4za.m (Top hat and Bob-hat (Contrast enhancement))
%top-hat: remove the bright objects in the dark background
%bot-hat: remove the dark objects in the bright background
clear all,close all, clc
H=imread('horse.bmp'); 
SE = strel('disk',9);
 
HTH = imtophat(H,SE); BTH = imbothat(H,SE);
BoTop = imsubtract(imadd(H,HTH), BTH);

figure(1),
subplot(2,2,1), imshow(H),title('original'), impixelinfo
subplot(2,2,2), imshow(HTH),title('(White) Top-hat'), impixelinfo
subplot(2,2,3), imshow(BTH),title('(Black) Bot-hat'), impixelinfo
subplot(2,2,4), imshow(BoTop), 
title('contrast enhanced with both top-hat & bot-hat'), impixelinfo


