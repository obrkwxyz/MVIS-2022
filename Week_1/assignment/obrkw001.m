%% Kane O'Brien 2/3/22
% UniSA: 110268293
% Group: #5

%% Initialise
clear all
close all
clc

%% A)
% This reads the image serveral circle .bmp and then displays it, along
% with the pixel information at the bottom of the figure window.

img1 = imread("several_circle.bmp");
figure(1)
    imshow(img1)
    impixelinfo

%% B
% This script shows the resolution of the image via showing the size of the
% matrix that it is contained within; in this case it is 720x673 wide, with
% three channels for RGB values. It is of 1453680 Byte (1.45MB) with a
% category of Unsigned integer of 8 bits -- count (0-255)

whos

%% C)
% At the (x,y) location of 500,450, the image displays a pixel value of
% [128,0,128], corresponding to a (50% intensity) red mixed with (50% intensity) blue.
% The result is a nice purple. impixel works in the x,y whilst the matrix
% call works in row,column (y,x) These yield the same answer.

impixel(img1,500,450)
img1(450,500,:)
%% D)
% This seperates the individual channels into the same figure and shows the
% original aside it in a 2x2 format.

figure(2)
subplot(2,2,1)
    imshow(img1(:,:,:))
    title("The Original Image")
subplot(2,2,2)
    imshow(img1(:,:,1))
    title("Red Channel Only")
subplot(2,2,3)
    imshow(img1(:,:,2))
    title("Green Channel Only")
subplot(2,2,4)
    imshow(img1(:,:,3))
    title("Blue Channel Only")

%% E)
% crop a part of the image, 51:350 row, 121:400 column.

img2 = img1(51:350,121:400,:);
figure(3)
    imshow(img2)

%% F)
% Draw a box using line around the cropped section
figure(4)
    imshow(img1)
    line([121,121,400,400,121],[51,350,350,51,51]);


%% G)
% Reduce size of the cropped image (e) / img2 to 1/4 size.

img3 = imresize(img2,1/4,'nearest');
figure(5)
subplot(1,2,1)
    imshow(img2)
    title("Cropped image")
    impixelinfo
subplot(1,2,2)
    imshow(img3)
    title("Cropped, Resized image")
    impixelinfo

%% H)
% Create the new image mod circle, save it as png

img4 = img1; % copy oem image
img4(:,300:310,1) = 255; % Make the 300:310 row red 100%
img4(:,300:310,2) = 0; % Make the 300:310 row red 100%
img4(:,300:310,3) = 255; % Make the 300:310 col blue 100%

figure(6)
    imshow(img4)
imwrite(img4,'mod_circle.png','png');

%% I)
% Reduce the original image grayscale into red16, green64, blue16.
% Display without any colour map. Explain why. 

x16 = grayslice(img1,16);
x64 = grayslice(img1,64);
img5 = cat(3,x16(:,:,1),x64(:,:,2),x16(:,:,3));
figure(7)
    imshow(img5) % No colour map.
    impixelinfo;

% The green is showing values 0-64
% The red and blue are showing values 0-16. 
% Without colour map the imshow is attempting to display 0-255
% as 0=black, 1=white, the image will be quite dark as the brightest pixel
% will be 64/255 ( 1/4)
% The image will be green-dominant as it the green channel provides the
% 0-64. (4x times 0-16)

%% J)
% Convert the original image to HSV. Display using imshow. Colour is
% different;why

% imshow is default mapped to show RGB colour space - HSV image mapped to
% RGB colour space is expected to be very different

img6 = rgb2hsv(img1);
figure(8)
    imshow(img6)
    impixelinfo

%% K)
% Read image gray_circle, Crop the oem around gray coloured circle as much
% as possible. Replace the cropped image into "several-circle"
% Note that gray-circle is a grayscale image; original image is colour. Use
% impixelinfo.

img7 = imread("gray_circle.bmp");
figure(9)
    imshow(img7)
    impixelinfo
img7p = img7(27:131,40:145);
figure(10)
    imshow(img7p)
    impixelinfo
img8 = imread("several_circle.bmp");

figure(11)
    imshow(img8)
    impixelinfo

img7p = repmat(img7p, [1 1 3]);
img8(27:131,40:145,:) = img7p(:,:,:);

figure(12)
    imshow(img8)
    impixelinfo

