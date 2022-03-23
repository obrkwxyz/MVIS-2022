%w4j.m (Image reconstruction - remove all noises inside and outside object)
clear all
close all
clc

%remove all noises outside the objects first
mask1=imread('shapes_noise.png'); % the origiinal image as mask
SE1=strel('disk', 5);

marker1=imerode(mask1,SE1); % eroded image as marker

%apply image opening and image recostruction
im_op = imopen(mask1,SE1); 
im_re = imreconstruct(marker1, mask1); 

figure(1) 
subplot(2,2,1)
    imshow(mask1)
    title('original')
subplot(2,2,2) 
    imshow(marker1)
    title('Edrosion')
subplot(2,2,3)
    imshow(im_op)
    title('opening');
subplot(2,2,4)
    imshow(im_re)
    title('opening by reconstruction');
    pause(1/10)

%remove all noises inside the object
mask2 = imcomplement(im_re);
marker2 = imerode(mask2, SE1);
im_re2 = imreconstruct(marker2, mask2);
f_image = imcomplement(im_re2);

figure(2) 
subplot(2,2,1)
    imshow(mask2)
    title('original')
subplot(2,2,2)
    imshow(marker2)
    title('Edrosion')
subplot(2,2,3)
    imshow(im_re2)
    title('opening by reconstruction');
subplot(2,2,4)
    imshow(f_image)
    title('complemented image - noise removed');
    pause(1/10)

