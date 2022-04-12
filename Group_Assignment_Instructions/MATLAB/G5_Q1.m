%% Machine Vision Learning Systems: Assignment 1
% File: G5_Q1.m
% Author: Group 5
%   Lining Hou (110 253 108) - HOULY008
%   Sam Maloney (xxx xxx xxx) - MOLSJ005
%   Kane O'Brien (110 268 293) - OBRKW001
% -----------------------------------------------
% We declare the following to be my own work,
% unless otherwise referenced, as defined by
% the University’s policy on plagiarism.
% -----------------------------------------------
%% Question 1:

%initialise environment
clear all
close all
clc

% Part A)
% change this line to swap the image set (1 or 2)
ver = 1;

if ver == 2
    im1 = "../image1a.jpg";
    im2 = "../image2a.jpg";
    ver = "Second";
else
    im1 = "../image1b.jpg";
    im2 = "../image2b.jpg";
        ver = "First";
end

fprintf("Working with the " +ver+ " version.\n\n")

image1 = imread(im1);
image2 = imread(im2);

fprintf("The 'whos' command output:\n")
whos

figure
subplot(2,1,1)
    imshow(im1)
    title("Image 1 - Original")
    impixelinfo
subplot(2,1,2)
    imshow(im2)
    title("Image 2 - Original")
    impixelinfo
pause(1/10)

% Part B)
% Capture values @ 250x,350y
rgb(1:3) = image1(250,350,:); 
gs = image2(250,350);

fprintf("The values of Image 1 250th Row, 350th Column:\nR: %d\nG: %d\nB: %d\n\n", rgb(1:3) )
fprintf("The value of Image 2 250th Row, 350th Column:\nGray: %d\n\n", gs)

% Part C
box_dim = 25; % box dimension = 25x25px

% Cant do 25/2 as it is non-integer; we take a floor and ceiling to ensure
% it includes 25; floor will truncate the half, ceiling will round the half
imx1 = 250 - floor(box_dim/2);
imx2 = 250 + ceil(box_dim/2);
imy1 = 350 - floor(box_dim/2);
imy2 = 350 + ceil(box_dim/2);

% Give a new var to preserve original.
img = image1;

% change all three layers to the gs value
img(imx1:imx2,imy1:imy2,:) = gs;
% add the red dot at the central point
img(250,350,:) = cat(3,255,0,0);

figure(2)
    imshow(img)
    title("Modified image, 25x25px box and red dot centered at 250r 350c")
    impixelinfo
pause(1/10)

% Part D)
[h,w,d] = size(image1);
% Crop image
img = image1( ceil(h/2)+1:end ,:,:);

figure(3)
    imshow(img)
    title("Cropped bottom half of the image, same width")
    impixelinfo
pause(1/10)

% Part E)
img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

figure(4)
subplot(2,2,1)
    imshow(img)
    title("Cropped initial image")
    impixelinfo
subplot(2,2,2)
    imshow(img_r)
    title("Cropped image; Red layer")
    impixelinfo
subplot(2,2,3)
    imshow(img_g)
    title("Cropped image; Green layer")
    impixelinfo
subplot(2,2,4)
    imshow(img_b)
    title("Cropped image; Blue layer")
    impixelinfo
pause(1/10)

% relaxed, manually observered threshold values
r_th = img_r > 200;
g_th = img_g > 200;
b_th = img_b > 200;

% Part F)
img_th = r_th & b_th;

SE1 = strel('square',15);

img_fill = imfill(img_th, 'holes');
img_erode = imerode(img_fill,SE1);
img_recon = imreconstruct(img_erode,img_fill);


% Double check there was only one; else throw exception error
assert(max(max(bwlabel(img_recon))) == 1, "There was more than one label")

figure(5)
    imshow(img_recon)
    title("Reconstructed, de-noised logo; there is only one object.")
    impixelinfo
pause(1/10)

% Part G)
img_struct = regionprops(img_recon,"BoundingBox");
pos = floor(img_struct.BoundingBox(1:2));
siz = round(img_struct.BoundingBox(3:4));

% Part H)
% Shrink the image to match the bounding box
img2_rz = imresize(image2, [siz(2) siz(1)]);  % ensure flip (FLIPLR) the matrix to account for the xy => yx imtool thing

% Part I)
% Replace the contents of the bounding box
img_r(pos(2):pos(2)+siz(2)-1, pos(1):pos(1)+siz(1)-1) = img2_rz;
img_g(pos(2):pos(2)+siz(2)-1, pos(1):pos(1)+siz(1)-1) = img2_rz;
img_b(pos(2):pos(2)+siz(2)-1, pos(1):pos(1)+siz(1)-1) = img2_rz;
img = cat(3,img_r, img_g, img_b);

figure(6)
    imshow(img)
    title("Replaced Logo, Cropped image")
    impixelinfo
pause(1/10)

% Part J)
% Replace the top half image

image_top = image1( 1:floor(h/2) ,:,:);
image_final = [image_top; img];

figure(7)
    imshow(image_final)
    title("Final Image with Logo Replaced")

assert(sum((size(image1)) == (size(image_final)))== 3, "Major mistakes were made; the size is probably not the same")
fprintf("The sizes of each image were checked and they are the same size of:\n%d x %d x %dpixels\n\nQ1. Complete \n\n", size(image_final))

 
