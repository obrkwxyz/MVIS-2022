%w4b.m Image Dilation and erosion applied several times
close all
clear all
clc

W=imread('shapes.png');

SE1 = strel('square',25) 

%apply dilation and erosion
W_D1 = imdilate(W,SE1); 
W_E1 = imerode(W,SE1); %apply once

W_D2 = imdilate(W_D1,SE1); 
W_E2 = imerode(W_E1,SE1); %apply twice

W_D3 = imdilate(W_D2,SE1);
W_E3 = imerode(W_E2,SE1); %apply 3 times

W_D4 = imdilate(W_D3,SE1);
W_E4 = imerode(W_E3,SE1); %apply 4 times

figure(1)
    imshow(W), 
    title('Original')

figure(2)
subplot(2,2,1)
    imshow(W_D1)
    title('Dilated once')
subplot(2,2,2)
    imshow(W_E1)
    title('Eroded once')
subplot(2,2,3)
    imshow(W_D2)
    title('Dilated twice')
subplot(2,2,4)
    imshow(W_E2)
    title('Eroded twice')
    pause(1/10)

figure(3)
subplot(2,2,1)
    imshow(W_D3)
    title('Dilated three times')
subplot(2,2,2)
    imshow(W_E3)
    title('Eroded three times')
subplot(2,2,3)
    imshow(W_D4)
    title('Dilated four times')
subplot(2,2,4)
    imshow(W_E4)
    title('Eroded four times')
    pause(1/10)
