%w4yc.m (Image reconstruction)
clear all,close all, clc
W=imread('plugs.jpg');
figure(1), imshow(W),title('Original')
 
SE1=strel('disk',5);
%Opening-by-reconstruction
WE1=imerode(W,SE1); WR1=imreconstruct(WE1,W);
%Apply image opening for comparison purpose
WO1=imopen(W,SE1);
figure(2), 
subplot(1,2,1), imshow(WO1), title('Image opening')
subplot(1,2,2), imshow(WR1), title('Opening-by-reconstruction')
 
%closing-by-reconsturction
WR1_C=imcomplement(WR1);
WR1_CE=imerode(WR1_C, SE1);
WR1_CE_R=imreconstruct(WR1_CE,WR1_C);
WR1_CE_RC=imcomplement(WR1_CE_R);
 
%apply image Opening-closing for comparison purpose
WO1C=imclose(WO1,SE1);
 
figure(3), 
subplot(1,2,1), imshow(WO1C), title('Image opening and then image closing')
subplot(1,2,2), imshow(WR1_CE_RC), 
title('Opening-by-reconstruction and then closing-by-reconsturction')
