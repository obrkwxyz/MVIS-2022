%% Week 3 - In class exercise
% OBRKW001 16/3/22
% Init
clear all
close all
clc

%% Part 1
% A) Read circles1.png, isolate the circles with an intensity of greater
% than 200 in the red channel. Display the number in the title using
% num2str "The number of circles with red colour intensity level higher
% than 100 is ..."

circles = imread("circles1.png");

Xr = circles(:,:,1);
Xg = circles(:,:,2);
Xb = circles(:,:,3);

figure(1)
subplot(2,2,1)
    imshow(circles)
    title("Original Image")
    impixelinfo
subplot(2,2,2)
    imshow(Xr);
    title("Red Component")
    impixelinfo
subplot(2,2,3)
    imshow(Xg);
    title("Green Component")
    impixelinfo
subplot(2,2,4)
    imshow(Xb);
    title("Blue Component")
    impixelinfo
pause(1) %IMShow causes havoc with my figures... pause for 1 second`

XrThresh = Xr > 200;
XrRed200 = bwlabel(XrThresh);
num_red_circs_a = max(max(XrRed200));


str = "The number of circles with red colour intensity level higher than 200 is " + num2str(num_red_circs_a) + ".";
figure(2)
    imshow(XrRed200)
    title(str)
    impixelinfo
pause(1)

% B) 
% Isolate the "Red" coloured circles only and show the number of
% red-coloured circles in the title.
Xred_thresh = Xr > 235 & Xg < 36 & Xb <36; 
% We can use 250, and zeros here, however allowing minimal blue/green components
% improves the robustness (there is a less pure red circle).
Xred_label = bwlabel(Xred_thresh);
num_red_circs_b = max(max(Xred_label));

str = "The number of red coloured circles is " + num2str(num_red_circs_b) + ".";
figure(3)
    imshow(Xred_label)
    title(str)
    impixelinfo
pause(1)

% C)
% Using the HSV Model, isolate yellowish coloured circle. You should
% separate each HSB component and study the range of values of yellow
% coloured circle to isolate.

circles_HSV = rgb2hsv(circles);

Xh = circles_HSV(:,:,1);
Xs = circles_HSV(:,:,2);
Xv = circles_HSV(:,:,3);

figure(4)
subplot(2,3,1)
    imshow(circles)
    title("RGB Image")
    impixelinfo
subplot(2,3,2)
    imshow(circles_HSV)
    title("HSV Image")
    impixelinfo
subplot(2,3,4)
    imshow(Xh);
    title("Hue Component")
    impixelinfo
subplot(2,3,5)
    imshow(Xs);
    title("Saturation Component")
    impixelinfo
subplot(2,3,6)
    imshow(Xv);
    title("Value Component")
    impixelinfo
pause(1)

% From looking at the image, we can determine the Hue is in range 0.16 <= x
% <= 0.17 -- Expand the range a little
Hue_thresh = Xh > 0.12 & Xh < 0.20;

yellowLabelled = bwlabel(Hue_thresh);
num_yellow_circles_c = max(max(yellowLabelled));

str = "The number of Yellow coloured circles is " + num2str(num_yellow_circles_c) + "." ;
str2 = "The Hues are in range of 0.16 <= x <= 0.17";
figure(5)
    imshow(yellowLabelled)
    title([str,str2])
    impixelinfo
pause(1)

% D)
% Read circles2.png and apply the same process as above; Your alogithm
% should work without adjusting the threshold values
display("Part A complete. The workspace will be cleared.")
pause(5)
%% PART 2
% Read one of the traffic light images - "traX.png" X=1:3.
% Your task is to identify the colour of the traffic light. Your code
% should work for all three images. You should not use local processing (ie
% position of colours should not matter.

display("Part B starting")
clear all

% A)
% Read the image and display with appropraite title, Divide it into three
% components and display using impixelinfo. You can use the HSB or
% normalised RZGB but it is not that straight forward in this case, so we just use the
% RGB model.

% I'm using 'version' to reference the different image

version = 1; % Green Light
% version = 2; % Red Light
% version = 3; % Yellow Light


file= "tra"+num2str(version)+".png";
traffic_light = imread(file);

Xr= traffic_light(:,:,1);
Xg= traffic_light(:,:,2);
Xb= traffic_light(:,:,3);

figure(6)
    axes1 = axes('Position',[0.350 0.3 0.3 0.6]); %% Expand the photo a little
    imshow(traffic_light)
    title(["The chosen traffic light is "+file])
    impixelinfo
pause(1/10);

% B) You need to identify the area around the traffic light first. Use a
%threshold to any one or two colour components to seperate the area around
%the traffic light only. after the treshold applied, as you see there is
%some small holes inside the traffic light area. Fill such hoels using
%imfill(x,'holes);

Tl_area = Xr > 200 & Xb > 200;
Tl_area_fill = imfill(Tl_area, 'holes');
Tl_area = imcomplement(Tl_area_fill);

figure(7)
    axes1 = axes('Position',[0.350 0.3 0.3 0.6]); %% Expand the photo a little
    imshow(Tl_area)
    title(["Traffic light area discovered"])
    impixelinfo
pause(1/10);

% C) For the identification of colour we need to replace all background
% into black for eaasier processing. What you need to do is mask the image
% with 0 from the found above.

Xr(Tl_area==0)=0;
Xg(Tl_area==0)=0;
Xb(Tl_area==0)=0;

figure(8)
    axes1 = axes('Position',[0.350 0.3 0.3 0.8]); %% Expand the photo a little
subplot(1,3,1)
    imshow(Xr)
    title("Red Channel")
    impixelinfo
subplot(1,3,2)
    imshow(Xg)
    title("Green Channel")
    impixelinfo
subplot(1,3,3)
    imshow(Xb)
    title("Blue Channel")
    impixelinfo
pause(1/10);


TL_R = Xr > 200 & Xg < 100;
TL_Y = Xr > 250 & Xg > 230;
TL_G = Xg > 200 & Xr < 100;

figure(9)
    axes1 = axes('Position',[0.350 0.3 0.3 0.8]); %% Expand the photo a little
subplot(1,3,1)
    imshow(TL_R)
    title("Red Light")
    impixelinfo
subplot(1,3,2)
    imshow(TL_Y)
    title("Yellow Light")
    impixelinfo
subplot(1,3,3)
    imshow(TL_G)
    title("Green Light")
    impixelinfo
pause(1/10);

A = [max(unique(TL_R)),max(unique(TL_Y)),max(unique(TL_G))]';
Light = ["RED" "YELLOW" "GREEN"]';

colour = Light(find(A));

figure(10)
    axes1 = axes('Position',[0.350 0.3 0.3 0.6]); %% Expand the photo a little
    imshow(traffic_light)
    title(["The colour of the light is "+ colour])
    impixelinfo
pause(1/10);

display("Part B Complete")
