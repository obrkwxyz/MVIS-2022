%% Kane O'Brien obrkw001
% Assignment 5 
% 30/03/22
clc
clear all
close all

%% Part 1

image = "washer.jpg";

img = imread(image);

img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

imb_th = img_b < 220;



figure(1)
subplot(3,2,1)
    imshow(img)
    title("original image")
subplot(3,2,2)
    imshow(img_r)
    title("red layer")
subplot(3,2,3)
    imshow(img_g)
    title("green layer")
subplot(3,2,4)
    imshow(img_b)
    title("blue layer")
subplot(3,2,5)
    imshow(imb_th)
    title("thresh image")
    pause(1/10)

SE1 = strel('square',10);
SE2 = strel('square',10);

im_erode1 = imerode(~imb_th,SE1);
im_recon1 = ~imreconstruct(im_erode1, ~imb_th);

figure(2)
subplot(2,1,1)
    imshow(im_erode1)
    title("inside eroded Image")
subplot(2,1,2)
    imshow(im_recon1)
    title("inside reconstructed image")
    pause(1/10)

im_erode2 = imerode(im_recon1, SE2);
im_recon2 = imreconstruct(~im_erode2, im_recon1);

figure(3)
subplot(2,1,1)
    imshow(im_erode2)
    title("outside eroded Image")
subplot(2,1,2)
    imshow(im_recon2)
    title("outside reconstructed image")
    pause(1/10)


num_parts = max(max(bwlabel(im_recon2)));
str = "The number of parts in the image is: " + num2str(num_parts);

figure(4)
    imshow(im_recon2)
    title(str)
    pause(1/10)

nor_mom = [1, invmoments(im_recon2)];

% Part 2

image = "parts1.jpg";

img = imread(image);

img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

imb_th = img_b < 220;



% figure(5)
% subplot(3,2,1)
%     imshow(img)
%     title("original image")
% subplot(3,2,2)
%     imshow(img_r)
%     title("red layer")
% subplot(3,2,3)
%     imshow(img_g)
%     title("green layer")
% subplot(3,2,4)
%     imshow(img_b)
%     title("blue layer")
% subplot(3,2,5)
%     imshow(imb_th)
%     title("thresh image")
%     pause(1/10)

SE1 = strel('square',10);
SE2 = strel('square',10);

im_erode1 = imerode(~imb_th,SE1);
im_recon1 = ~imreconstruct(im_erode1, ~imb_th);

% figure(6)
% subplot(2,1,1)
%     imshow(im_erode1)
%     title("inside eroded Image")
% subplot(2,1,2)
%     imshow(im_recon1)
%     title("inside reconstructed image")
%     pause(1/10)

im_erode2 = imerode(im_recon1, SE2);
im_recon2 = imreconstruct(im_erode2, im_recon1);


im_label = bwlabel(im_recon2);
num_parts = max(max(im_label));
str = "The number of parts in the image is: " + num2str(num_parts);

figure(7)
    imshow(im_label)
    impixelinfo
    title(str)
    pause(1/10)

% Find the invariant moment for each object iteratively.
inv_moments = [];
for i = 1 : num_parts
    inv_moments = [inv_moments ; i, invmoments(im_label==i)];
end

% From inspection, Items 11,15,27 were found to be the square washers of
% interest; use these as limits and provide some tolerance.
% vals=[inv_moments(11,2),inv_moments(15,2),inv_moments(27,2)];
% 
% limU = max(vals) + 0.001;
% limL = min(vals) - 0.001;

% For robustness and seperation from the image - use the part 1 as a
% template
% Soft code the values from part 1
limU = nor_mom(2) + 0.01;
limL = nor_mom(2) - 0.01;


washer_labels = [];
for i = 1 : num_parts
    if (inv_moments(i,2) >= limL) && (inv_moments(i,2) <= limU)
            washer_labels = [washer_labels; i];
            img_r(im_label==i) = 255;
            img_g(im_label==i) = 0;
            img_b(im_label==i) = 0;
    end
end

num_washers = length(washer_labels);
image_processed = cat(3, img_r, img_g, img_b);

str = "The number of square washers is: " + num2str(num_washers);

figure(8)
    imshow(image_processed)
    impixelinfo
    title(str)
    pause(1/10)


%% Part 2 - grain seperation

clear all
close all
clc

image = imread("grains1.png");

img_grey = rgb2gray(image);

img_thresh = img_grey < 240;

img_th_filled = imfill(img_thresh, 'holes');

figure(1)
subplot(2,2,1)
    imshow(image)
    title("Original image")
subplot(2,2,2)
    imshow(img_grey)
    title("Gray scaled'")
subplot(2,2,3)
    imshow(img_thresh)
    title("Thresholded")
subplot(2,2,4)
    imshow(img_th_filled)
    title("holes filled")
    pause(1/10)


SE1 = strel('disk',1);
img_erode = imerode(img_th_filled, SE1);
img_recon = imreconstruct(img_erode,img_th_filled);

figure(2)
subplot(2,1,1)
    imshow(img_erode)
    title("First Erode")
subplot(2,1,2)
    imshow(img_recon)
    title("Then reconstruct")
    pause(1/10)


[r,c] = find(img_recon==1);
img_grain = img_grey(min(r):max(r), min(c):max(c));
img_template = img_grain;

figure(3)
    imshow(img_grain)
    title("Cropped image")


glcm1 = graycomatrix(img_grain);
stats1 = graycoprops(glcm1);
O_Cont = stats1.Contrast;
O_Corr = stats1.Correlation;
O_Ener = stats1.Energy;
O_Homo = stats1.Homogeneity;
O_entro = entropy(img_grain);

template = [1, O_Cont, O_Corr, O_Ener, O_Homo, O_entro];

% Part 2: 





image = imread("grains2.png");
img_grey = rgb2gray(image);
img_thresh = img_grey < 240;
img_th_filled = imfill(img_thresh, 'holes');

figure(4)
subplot(2,2,1)
    imshow(image)
    title("Original image")
subplot(2,2,2)
    imshow(img_grey)
    title("Gray scaled'")
subplot(2,2,3)
    imshow(img_thresh)
    title("Thresholded")
subplot(2,2,4)
    imshow(img_th_filled)
    title("holes filled")
    pause(1/10)


SE1 = strel('disk',1);
img_erode = imerode(img_th_filled, SE1);
img_recon = imreconstruct(img_erode,img_th_filled);

figure(5)
subplot(2,1,1)
    imshow(img_erode)
    title("First Erode")
subplot(2,1,2)
    imshow(img_recon)
    title("Then reconstruct")
    pause(1/10)

img_label=bwlabel(img_recon);
num_img = max(max(img_label));

img_stats =[];

for i = 1 : num_img
    [r,c] = find(img_label==i);
    img_grain = img_grey(min(r):max(r), min(c):max(c));

    glcm1 = graycomatrix(img_grain);
    stats1 = graycoprops(glcm1);
    O_Cont = stats1.Contrast;
    O_Corr = stats1.Correlation;
    O_Ener = stats1.Energy;
    O_Homo = stats1.Homogeneity;
    O_entro = entropy(img_grain);
    img_stats = [img_stats; i, O_Cont, O_Corr, O_Ener, O_Homo, O_entro];
end


% Set limits with some tolerance 
limU = template(3) + 0.01;
limL = template(3) - 0.01;


grain_images = [];
for i = 1 : num_img
    if (img_stats(i,3) >= limL) && (img_stats(i,3) <= limU)
            grain_images = [grain_images; i];
    end
end

for i = 1: length(grain_images)-1
    str = num2str(grain_images(i)) + " ";
end

str = "Grains with similar properties to the reference image: " + str + "and " + num2str(grain_images(end));

pause(1/10)
figure(6)
    imshow(image)
    title(str)
    pause(1/10)
