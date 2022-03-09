%% Class exercise 2 -- 9/3/22
% Kane O'Brien (110268293)

%% Init
close all
clear all
clc

%% A)
% Read the image diskc.png. Use the whos command to find the image
% property. Display the image with a title.

disk = imread("diskc.png");
whos

figure(1)
    imshow(disk)
    title('The original image of the disk')
    impixelinfo

%% B)
% Divide the image into three differetn colour components and display them
% using a 1x3 subplot. use impixelinfo to analyse the image. this will help
% decide the thresh value.
Rc = disk(:,:,1);
Gc = disk(:,:,2);
Bc = disk(:,:,3);

figure(2)
subplot(1,3,1)
    imshow(Rc)
    title("red channel")
    impixelinfo
subplot(1,3,2)
    imshow(Gc)
    title("green channel")
    impixelinfo
subplot(1,3,3)
    imshow(Bc)
    title("blue channel")
    impixelinfo

%% C)
% Apply thresholding techniques to separate the centre (yellow component)
% part from the remainting; you need to use appropriate threshold value in
% atleast two colour components to separate it correctly. Display the
% Result. Note that after the thresh is applied the result should be
% combined using logical operators; not arithmetric. Do not worry about
% small amounts of noise still in the thresh image; we remove alter.

% On inspection the values for R,G,B respectively were found
t1r = 190; % Approximate ~ >255 intensity
t1g = 200; % Approximate ~ >200 intensity
t1b = 100;  % Appriximate ~ <15  intesnity


Rc_filt = Rc > t1r;
Gc_filt = Gc > t1g;
Bc_filt = Bc < t1b;

figure(3)
subplot(1,3,1)
    imshow(Rc_filt)
    title("red channel thresh")
    impixelinfo
subplot(1,3,2)
    imshow(Gc_filt)
    title("green channel thresh")
    impixelinfo
subplot(1,3,3)
    imshow(Bc_filt)
    title("blue channel thresh")
    impixelinfo

% From inspection, it appears that Red and Blue channels are best to
% separeate the Yellow centre.

RBc_thresh = Rc_filt & Bc_filt;
figure(4)
    imshow(RBc_thresh)
    title("Separeted Centre channel")
    impixelinfo

%% D)
% First crop the center from the entire for local processing. use "find"
% "max" "min" finn the coordinate of the edges of the image.
% 

[xx,yy] = find(RBc_thresh == 1);
[x1,~]  = min(xx);
[x2,~]  = max(xx);
[y1,~]  = min(yy);
[y2,~]  = max(yy);

disk_c = imcrop(disk,[y1 x1 y2-y1 x2-x1]);
figure(5)
    imshow(disk_c)
    title("cropped initial image")

%% E)
% Remove the noise from the cropped image -- divide the cropped image into
% seperate channels, and individually apply a neighborhood filter. Then
% recombine the channels, Ensure the noise is gone, there will be minor
% colour change.

% Using a Median Filter 3x3
diskc_r = ordfilt2( disk_c(:,:,1) ,5,ones(3,3));
diskc_g = ordfilt2( disk_c(:,:,2) ,5,ones(3,3));
diskc_b = ordfilt2( disk_c(:,:,3) ,5,ones(3,3));

disk_c_filt = cat(3,diskc_r,diskc_g,diskc_b);

figure(6)
    imshow(disk_c_filt)
    title("Cropped and Filtered Image")

%% F)
% Replace the center of the original image with the center of the new
% croppped and filtered image; Make sure you use the same variables from D,
% and not the numbers. Once the image is obtained, display the result. 

diskc = disk;

diskc(x1:x2,y1:y2,:) = disk_c_filt;

figure(7)
    imshow(diskc)
    title("Image with the Cropped and Filtered Centre Replaced")
%% G)
% Convert the original image to greyscale and threshold with an appropriate
% value. Display the result; make sure the original shape of the entire
% disk is intact in the result

disk_g = rgb2gray(disk);

t1g = graythresh(disk_g);
disk_gt = imbinarize(disk_g,t1g);
disk_gt = imcomplement(disk_gt);

figure(8)
    imshow(disk_gt)
    title("Gray-scaled Original Image")

%% H)
% Can now remove the hols in the image

disk_gt_fill = imfill(disk_gt, 'holes');
figure(9)
    imshow(disk_gt_fill)
    title("Gray-scaled Holes Filled")

%% I)
% Again, using find max min find the diameter of the entire disk using
% max(r)-min(r)-1. You should do this in both row and column as its not
% exact circle; take the larger value; display the image in h, display the
% title as "the Diameter of the disk is ... pixels".

[xx,yy] = find(disk_gt_fill == 1);
[x1,~]  = min(xx);
[x2,~]  = max(xx);
[y1,~]  = min(yy);
[y2,~]  = max(yy);
diax = x2-x1+1;
diay = y2-y1+1;
dia_m = max(diax,diay);

figure(10)
    imshow(disk_gt_fill)
    str = "The Diameter of the disk is " + num2str(dia_m) + " pixels.";
    title(str)
