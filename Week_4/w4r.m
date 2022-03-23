%w4r.m Hit-or-miss operation with 1 SE - find 3x3 squares only
clear all, close all, clc
W=imread('squares_sizes.bmp'); imshow(W), impixelinfo, 
title('original image')

%create a template for 3x3 square
SE1=[-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 1 0 1 -1;-1 1 1 1 -1; -1 -1 -1 -1 -1]
%apply hit-miss operation
IHM=bwhitmiss(W, SE1);

figure(2), imshow(IHM)
title(['The number of 3x3 square is ', num2str(numel(find(IHM==1)))])

%image reconstruction 
IHM_RE=imreconstruct(IHM, W);
figure(3), imshow(IHM_RE), 
title('original shapes are recovered using image reconsturction')