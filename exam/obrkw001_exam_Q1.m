%% OBRKW001 - Class exam 18/5/22
clc
clear all
close all
%% Part 1
img = imread('q1b.png');

img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);
% figure(1)
%     imshow(img);
%     impixelinfo;
% subplot(1,3,2)
%     imshow(img_g);
%     impixelinfo;
% subplot(1,3,3)
%     imshow(img_b);
%     impixelinfo;

otsuVal = graythresh(img);
imBw = imbinarize(img,otsuVal);

r_th = 255;
img_thr = (img_r < 240);
% SE1 = strel('disk',4); % Removed for test
% SE2 = strel('disk',6);

SE1 = strel('disk',6);
SE2 = strel('disk',12);


im_erode = imerode(img_thr,SE1);
im_recon = imreconstruct(im_erode,img_thr);
im_reconf = imfill(im_recon,'holes');

im_erode2 = imerode(~im_reconf,SE2);
im_recon2 = ~imreconstruct(im_erode2,~im_reconf);

% figure(2)
% subplot(1,2,1)
%     imshow(im_reconf)
% subplot(1,2,2)
%     imshow(im_recon2)

imlabel = bwlabel(im_recon2);
val = max(max(imlabel));

str = "The number of drill bits is " + num2str(val);
figure(3)
    imshow(im_recon2)
    impixelinfo
    title(str)

% B) find longest shortest drill bits
stat = regionprops(im_recon2,'MajorAxisLength');

% %% Ideally would use a for loop to iterate the struct here but the sheet
% says not to....?
stat = struct2cell(stat);
stat = cell2mat(stat);

[l1, idx1] = max(stat);
[l2, idx2] = min(stat);

img_r(imlabel == idx1) = 255;
img_g(imlabel == idx1) = 0;
img_b(imlabel == idx1) = 0;
img_r(imlabel == idx2) = 0;
img_g(imlabel == idx2) = 0;
img_b(imlabel == idx2) = 255;

img_out = cat(3,img_r,img_g,img_b);

figure(4)
    imshow(img_out)
    title("Red = Longest, Blue = Shortest");

% C) Find the lengh of the drill bits if the smallest is 100mm
% assuming that the MajorAxisLength is ~ close enough to the real length in
% pixels; this insures a robust system if the shortest drill bit is in a
% differing orientation other than vertical -- Otherwise, use of the
% bounding box delta-y is a good approximation in integer pixels.
% > The MajorAxisLenght is not actually integer but a closer, more
% appropriate value.

alpha = 100/l2; % ratio of actual length to the shortest drill bit.
longbit_length = alpha*l1;

str = sprintf("The length of the longest drill bit is %3.2f mm",longbit_length);

figure(4)
    imshow(img_out)
    title(str)



