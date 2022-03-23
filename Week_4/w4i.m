%w4i.m (Image reconstruction)
clear all
close all
clc

mask=imread('shapes.png'); % the origiinal image as mask

SE1 = strel('disk', 5);
marker = imerode(mask,SE1); % eroded image as marker

%apply image opening and image recostruction
im_op = imopen(mask,SE1); 
im_re = imreconstruct(mask, marker); 

figure(1)
subplot(2,2,1)
    imshow(mask)
    title('original')
subplot(2,2,2)
imshow(marker)
title('Edrosion')
subplot(2,2,3), imshow(im_op), title('opening');
subplot(2,2,4), imshow(im_re), title('opening by reconstruction');
