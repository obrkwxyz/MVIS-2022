%% Kane O'Brien obrkw001
% Assignment 4 
% 23/03/22
clc
clear all
close all

%% Part 1

part1 = imread("part1.png");
whos part1
part1_gray = rgb2gray(part1);

part1_thresh = part1_gray < 70;

part1_fill   = imfill(part1_thresh, 'holes');

figure(1)
subplot(2,2,1)
    imshow(part1)
    title("Original Image")
subplot(2,2,2)
    imshow(part1_gray)
    title("Grayscale converted image")
    pause(1/5)
subplot(2,2,3)
    imshow(part1_thresh)
    title("Threshold image, thresh=70")
subplot(2,2,4)
    imshow(part1_fill)
    title("Threshold Filled'")
figure(1)
    impixelinfo
    pause(1/5)

SE1 = strel('diamond',5);
allDots     = imerode(part1_fill,SE1);
allDotsP    = imreconstruct(allDots,part1_fill);

SE2 = strel('diamond',10);
bigDots     = imerode(allDotsP,SE2);
bigcirc     = imreconstruct(bigDots,allDotsP);
smallcirc   = allDotsP & imcomplement(bigcirc);

big_perim   = bwperim(bigcirc);
small_perim = bwperim(smallcirc);

RGB = cat(3, (big_perim | small_perim), small_perim, zeros(size(small_perim)));

num_big_circ   = max(max(bwlabel(bigcirc)));
num_small_circ = max(max(bwlabel(smallcirc)));

figure(2)
subplot(2,2,1)
    imshow(allDotsP)
    title("Mask Image")
subplot(2,2,2)
    imshow(bigcirc)
    title(["The number of large holes is ", num2str(num_big_circ) ])
subplot(2,2,3)
    imshow(smallcirc)
    title(["The number of small circles is ", num2str(num_small_circ) ])
subplot(2,2,4)
    imshow(RGB)
    title("RGB Addition with perimeters circled.")
    pause(1/5)

part1R = part1(:,:,1);
part1G = part1(:,:,2);
part1B = part1(:,:,3);

part1R( (big_perim | small_perim) == 1) = 255;
part1G( small_perim == 1) = 255;

final_image = cat(3, part1R, part1G, part1B);
figure(3)
    imshow(final_image)
    title(["The number of small circles is ", num2str(num_small_circ) ])
    pause(1/5)
 
pause % Hold until for the next part.

%% Part 2
close all

gasket1 = imread("gasket1.jpg");
whos gasket1

gasket_gray    = rgb2gray(gasket1);
gasket1_thresh = gasket_gray > 150;


SE1 = strel('disk', 2);
gasket1_erode1 = imerode(gasket1_thresh,SE1);
gasket1_recon1 = imreconstruct(gasket1_erode1, gasket1_thresh);
gasket1_comp   = imcomplement(gasket1_recon1);
gasket1_erode2 = imerode(gasket1_comp, SE1);
gasket1_recon2 = imreconstruct(gasket1_erode2, gasket1_comp);
gasket1_recon3 = imcomplement(gasket1_recon2);


figure(1)
subplot(2,2,1)
    imshow(gasket1_thresh)
subplot(2,2,2)
    imshow(gasket1_erode1)
subplot(2,2,3)
    imshow(gasket1_recon1)
subplot(2,2,4)
    imshow(gasket1_recon3)
    figure(1)
    impixelinfo
pause(1/5)


SE2 = strel('disk', 250);
bigcirc       = imerode(gasket1_recon3, SE2);
bigcirc_recon = imreconstruct(bigcirc, gasket1_recon3);

[x,y] = find(bigcirc_recon == 1);
D1 = max(max(x))-(min(min(x)))+1;
D2 = max(max(y))-(min(min(y)))+1;
D = (D1 + D2)/2; % Find the average.


str = "The diameter of the inner circle is " + num2str(D) + " pixels."
figure(2)
    imshow(bigcirc_recon)
    title(str)
    impixelinfo
pause(1/5)



gasket1_c      = imcomplement(gasket1_recon3);
gasket1_c_fill = imfill(gasket1_c, [1,1], 4);
gasket1_holes  = imcomplement(gasket1_c_fill);

figure(3)
    imshow(gasket1_holes)
    title("Backround Filled")

SE3 = strel('disk',26);
SE4 = strel('disk',34);
holes    = imerode(gasket1_holes, SE3);
holes_r  = imreconstruct(holes, gasket1_holes);
holes_n  = imerode(gasket1_holes, SE4);
holes_rn = imreconstruct(holes_n, gasket1_holes);


marker = holes_r - holes_rn;
str = "The number of medium size circles is " + num2str(max(max(bwlabel(marker)))) + "."

bound_med = bwperim(marker);


gasket1R = gasket1(:,:,1);
gasket1G = gasket1(:,:,2);
gasket1B = gasket1(:,:,3);

gasket1R(bound_med==1) = 255;
gasket1G(bound_med==1) = 0;
gasket1B(bound_med==1) = 0;

gasket_final = cat(3, gasket1R, gasket1G, gasket1B);



figure(4)
    imshow(gasket_final)
    title(str)
pause(1/5)

 

