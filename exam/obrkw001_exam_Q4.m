%% OBRKW001 - Class exam 18/5/22
%% PART B
clc
clear all
close all
%% Part 1
img = imread("q4a.png"); % The template photo

% Find the missing or added holes using A as the template, and B as the
% test.

img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3); 
% 
% figure(1)
% subplot(1,3,1)
%     imshow(img_r)
%     impixelinfo
% subplot(1,3,2)
%     imshow(img_g)
%     impixelinfo
% subplot(1,3,3)
%     imshow(img_b)
%     impixelinfo

im_th_r = 65; %greater
im_th_b = 170; %less

im_th = img_r > im_th_r & img_b < im_th_b;

im_fi = imfill(im_th,[1 1]);

SE1 = strel('disk',10);

im_er = imerode(im_fi,SE1);
im_re = imreconstruct(im_er,im_fi);
im_er2 = imerode(~im_re,SE1);
im_re2 = ~imreconstruct(im_er2,~im_re);

labelsA = bwlabel(~im_re2);
numhole = max(max(labelsA));
str= sprintf("Number of Holes: %3d",numhole);
im_template = im_re2;


figure(2)
    imshow(im_template)
    title(str)

% B) Read the Q4B and apply the threshold.

imgB = imread("q4b.png"); % The dut photo
imgB_r = imgB(:,:,1);
imgB_g = imgB(:,:,2);
imgB_b = imgB(:,:,3);

imb_th = imgB_r > im_th_r & imgB_b < im_th_b;

imB_fi = imfill(imb_th,[1 1]);
imB_er = imerode(imB_fi,SE1);
imB_re = imreconstruct(imB_er,imB_fi);
imB_er2 = imerode(~imB_re,SE1);
imB_re2 = ~imreconstruct(imB_er2,~imB_re);

labelsB = bwlabel(~imB_re2);
numholeB = max(max(labelsB));


im_dut = imB_re2;
str= sprintf("Number of Holes: %3d",numholeB);


figure(3)
    imshow(im_dut)
    title(str)

%% C) Find missing and added holes

im_hit  = ~im_template & ~im_dut; %% These are the same (overlap). > If the DUT has extra, it becasue ADDED
% If the dut has less, it becasue missed

im_added = im_template & ~im_dut;
im_add_er = imerode(im_added,SE1);
im_add_re = imreconstruct(im_add_er,im_added);
labAdd = bwlabel(im_add_re);
numAdd = max(max(labAdd));


im_miss  = ~im_template & im_dut;
im_miss_er = imerode(im_miss,SE1);
im_miss_re = imreconstruct(im_miss_er,im_miss);
labMiss = bwlabel(im_miss_re);
numMiss = max(max(labMiss));


img_r(im_add_re==1) = 255;
img_g(im_add_re==1) = 0;
img_b(im_add_re==1) = 0;


img_r(im_miss_re==1) = 255;
img_g(im_miss_re==1) = 255;
img_b(im_miss_re==1) = 0;

imgB = cat(3,img_r,img_g,img_b);
% 
% figure(4)
% subplot(2,2,1)
%     imshow(im_template)
%     title("template")
% subplot(2,2,2)
%     imshow(im_dut)
%     title("dut")
% subplot(2,2,3)
%     imshow(im_add_re)
%     title("added")
% subplot(2,2,4)
%     imshow(im_miss_re)
%     title("miss")

str = sprintf("Missing holes (yellow): %2d, Added holes (red): %2d \n",numMiss,numAdd);

figure(5)
    imshowpair(img,imgB,'montage')
    title(str)