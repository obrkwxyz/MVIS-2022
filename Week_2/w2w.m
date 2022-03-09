%w2w.m  unsharp masking filter
close all, clear all, clc
N=imread('lena_g.bmp');
figure(1), imshow(N), title('Original Image')
%Method 1
%apply smoothing filter to the image first 
F_avg1=fspecial('average', 3); 
N_smooth1=imfilter(N,F_avg1);  
%Taking the result from the original image 
N_mask1=imsubtract(N,N_smooth1); 
figure(2), imshow(N_mask1), title('the difference from the original image')
%The result will be added to the original image with k=1 
N_unsharp1=imadd(N,N_mask1);

figure(3), 
subplot(2,2,1), imshow(N), title('original image')
subplot(2,2,2), imshow(N_smooth1), title('blurred image with averaging filter')
subplot(2,2,3), imshow(N_mask1), title('the difference from the original image')
subplot(2,2,4), imshow(N_unsharp1), title('Add the results to the original image(k=1)')

%Method 2: the result is exactly the same as method 1
%create the unsharp masking filter and apply it to the image
F_ori=[0 0 0; 0 1 0; 0 0 0]; 
F_dif1=F_ori-F_avg1; % this is the unsharp masking filter
N_mask2=imfilter(N,F_dif1); %Apply the unsharp masking filter to the image 
N_unshapr2=imadd(N,N_mask2); %add to the original image
figure(2), 
subplot(2,2,1), imshow(N), title('original image')
subplot(2,2,2), imshow(N_mask2), title('Apply the smmoothing filter')
subplot(2,2,3), imshow(N_unshapr2), 
title('Add the results to the original image(k=1)')

%using imsharpen command
N_unsharp3=imsharpen(N);
figure(4) 
subplot(1,2,1), imshow(N), title('original image')
subplot(1,2,2), imshow(N_unsharp3), title('unsharp image using imsharpen')