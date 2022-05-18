%% OBRKW001 - Class exam 18/5/22
clc
clear all
close all
%% Question 2

img = imread("q2.png");
img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);


k_ind = fix(rand(1)*20+10);
img_mod = imsubtract(img,k_ind);

img_hsv = rgb2hsv(img_mod);

% figure(1)
% subplot(1,2,1)
%     imshow(img)
%     impixelinfo
% subplot(1,2,2)
%     imshow(img_hsv)
%     impixelinfo

figure(2)
subplot(1,3,1)
    imshow(img_hsv(:,:,1))
    impixelinfo
subplot(1,3,2)
    imshow(img_hsv(:,:,2))
    impixelinfo
subplot(1,3,3)
    imshow(img_hsv(:,:,3))
    impixelinfo

imP_th_h = 0.78;

SE1 = strel('disk',5);
img_P = img_hsv(:,:,1) > imP_th_h;
imp_fill = imfill(img_P, 'holes');
imp_er = imerode(imp_fill, SE1);
imp_re = imreconstruct(imp_er,imp_fill);

figure (3)
    imshow(imp_re)
    title("The binary image for Q2 part A")

img_r(imp_re==1) = 255;
img_g(imp_re==1) = 0;
img_b(imp_re==1) = 255;
img_A = cat(3,img_r,img_g,img_b);

labelA = bwlabel(imp_re);
numA = max(max(labelA));

str = "No. of purple: "+ num2str(numA);

figure(4)
    imshow(img_A)
    title(str)

% B) Reddish colour flowers
 
imR_th_h = 0.1;

img_R = img_hsv(:,:,1) < imR_th_h;
imr_fill = imfill(img_R, 'holes');
imr_er = imerode(imr_fill, SE1);
imr_re = imreconstruct(imr_er,imr_fill);

figure (3)
    imshow(imr_re)
    title("The binary image for Q2 part B")

img_r(imr_re==1) = 255;
img_g(imr_re==1) = 0;
img_b(imr_re==1) = 0;
img_B = cat(3,img_r,img_g,img_b);

labelB = bwlabel(imr_re);
numB = max(max(labelB));

str = "No. of purple: "+ num2str(numA)+", No. of Red: "+ num2str(numB);

figure(4)
    imshow(img_B)
    title(str)

% C) White Flowers

imW_th_S = 0.4;
img_W = img_hsv(:,:,2) < imW_th_S;

SE2 = strel('disk',6);

imw_fill = imfill(img_W, 'holes');
imw_er = imerode(imw_fill, SE2);
imw_re = imreconstruct(imw_er,imw_fill);


figure(5)
    imshow(imw_re)
    title("The binary image for Q2 part C")

img_r(imw_re==1) = 255;
img_g(imw_re==1) = 255;
img_b(imw_re==1) = 255;
img_C = cat(3,img_r,img_g,img_b);

labelC = bwlabel(imw_re);
numC = max(max(labelC));

str = "No. of purple: "+ num2str(numA)+", No. of Red: "+ num2str(numB)+ ", No. of White: "+ num2str(numC);

figure(4)
    imshowpair(img,img_C,'montage')
    title(str)
