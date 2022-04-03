%% Kane O'Brien obrkw001
% Assignment 5 
% 30/03/22
clc
clear all
close all

%% Part 1

image = "runway.jpg";

I = imread(image);
k_ind = (fix(rand(1)*15));

IM = imsubtract(I, k_ind);

IMhsv = rgb2hsv(IM);
IMh = IMhsv(:,:,1);
IMs = IMhsv(:,:,2);
IMv = IMhsv(:,:,3);

figure(1)
subplot(4,1,1)
    imshow(IM)
    title("Intial image")
subplot(4,1,2)
    imshow(IMh)
    title("HSV - H channel")
    impixelinfo
subplot(4,1,3)
    imshow(IMs)
    title("HSV - S channel")
    impixelinfo
subplot(4,1,4)
    imshow(IMv)
    title("HSV - V channel")
    impixelinfo



IMs_thresh = IMs < 0.18;
IMv_thresh = IMv > 0.69; 

%display thresholds
figure(2)
subplot(2,1,1)
    imshow(IMs_thresh)
    title("threshold in S")
    impixelinfo
subplot(2,1,2)
    imshow(IMv_thresh)
    title("threshold in V")
    impixelinfo

% Erode+Reconstruct image to remove noise   
SE = strel('diamond', 13);
thresh = IMs_thresh & IMv_thresh;


thresh_fill  = imfill(thresh,'holes');
thresh_erode = imerode(thresh_fill,SE);
thresh_re    = imreconstruct(thresh_erode,thresh_fill);

%Diplay the morphologiical processed image
figure(3)
    imshow(thresh_re)
    title("The morphological processed image")

%Apply Canny Edge Detection
im_canny = edge(thresh_re,'canny');

figure(4)
    imshow(im_canny)
    title("Canny-Edge detection image")

% Apply Hough Process

[H,theta,rho] = hough(im_canny,'RhoResolution',0.5,'ThetaResolution',0.5);
%will identify "1" lines
P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:)))); 
x = theta(P(:,2));
y = rho(P(:,1));

figure(3)
    imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
        'InitialMagnification','fit');
    xlabel('\theta (degrees)'), ylabel('\rho');
    axis on
    axis normal
    hold on
    title('The Accumulator Array')
    plot(x,y,'linestyle','none','marker','square', 'color','r')
    lines = houghlines(im_canny,theta,rho,P,'FillGap',100,'MinLength',20);
pause(1/10)


figure(4)
    imshow(im_canny)
    hold on
    
    max_len = 0;
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
    
       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'*','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'*','LineWidth',2,'Color','green');
    
       len = norm(lines(k).point1- lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
    str = "The length of the runway is : " + num2str(round(len)) + " Pixels";
    title(str);

% E)
O_scale = I(575: 582, 1710:1800,:);

scale_gray   = rgb2gray(O_scale);
thresh_os    = graythresh(scale_gray);
scale_thresh = imbinarize(scale_gray,thresh_os);

figure(5)
    imshow(scale_thresh);

[~,x] = find(scale_thresh==1);
dx    = max(x)-min(x);
runway_pixel  = 200/dx;
runway_length = runway_pixel * len;

figure(5)
    imshow(IM)
    hold on
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'+','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'+','LineWidth',2,'Color','green');
    str = "The length of the runway is : " + num2str(round(len)) + " pixels and "+ num2str(round(runway_length))+ " m."  ;
    title(str);
pause(1)

%% Part 2:
% Using RGB Colour map, seperate the oranges from the background using
% morphological processing. remove noise, maintain shape and count the
% oranges. Then, using watershed operations segment the oranges and apply a
% border of atleast 2 pixels width in blue. title the image with the number of
% pixels

% This one was quite difficult, still not working quite right. Requires a
% tophat/bothat type operation for the perimeter function

% initalise
clc
clear all
close all

%import image
oranges = imread("oranges.jpg");
IMr = oranges(:,:,1);
IMg = oranges(:,:,2);
IMb = oranges(:,:,3);

% figure(1)
% subplot(2,2,1)
%     imshow(oranges)
%     title("Original Image")
%     impixelinfo
% subplot(2,2,2)
%     imshow(IMr)
%     title("Red channel")
%     impixelinfo
% subplot(2,2,3)
%     imshow(IMg)
%     title("Green channel")
%     impixelinfo
% subplot(2,2,4)
%     imshow(IMb)
%     title("Blue channel")
%     impixelinfo

% Use Otsu's to determine the best threshold; manual manipulation wasnt
% successful
tr_r = graythresh(IMr);
tr_g = graythresh(IMg);
tr_b = graythresh(IMb);

imr_thresh = imbinarize(IMr,tr_r);
img_thresh = imbinarize(IMg,tr_g);
imb_thresh = imbinarize(IMb,tr_b);
% img_filledthresh = bwmorph(img_thresh, 'majority', 20);
img_filledthresh = imfill(img_thresh,'holes'); % Fill in the green layer holes

im_thresh = ~(~imr_thresh & ~img_filledthresh);


% figure(3)
% subplot(2,3,1)
%     imshow(imr_thresh)
%     title("threshold r")
% subplot(2,3,2)
%     imshow(img_thresh)
%     title("thresold g")
% subplot(2,3,3)
%     imshow(imb_thresh)
%     title("threshold b")
% subplot(2,3,5)
%     imshow(img_filledthresh);
%     title("filled green layer")
% subplot(2,3,6)
%     imshow(im_thresh)
%     title("combined thresh")
% pause(1/10)


SE = strel('disk', 20);
im_open   = imopen(im_thresh,SE);
im_recon  = ~imreconstruct(im_open,im_thresh);
pause(1/10)


figure(4)
    imshow(im_recon)
    title("Binary Image of the Oranges")
    pause(1/10)
% subplot(2,1,1)
%     imshow(im_open)
%     title("first eroded")
%     impixelinfo
% subplot(2,1,2)
%     imshow(im_recon)
%     title("then reconstructed")
%     pause(1/10)

im_dist      = imcomplement(bwdist(im_recon));
im_watershed = watershed(im_dist);

% figure(5)
% subplot(2,1,1)
%     imshow(im_dist, []);
%     title("initial distance image")
%     impixelinfo
% subplot(2,1,2)
%     imshow(im_watershed, [])
%     title("initial watershed")
%     impixelinfo
%     pause(1/10)


im_wa = (im_watershed == 0);
im_oversamp = ~im_recon &~ im_wa;

[im_label, num] = bwlabel(im_oversamp);

% figure(6)
%     imshow(im_wa)
%     title("watershed edged image")
%     impixelinfo
%     pause(1/10)

minimum_size = 200; 
im_label2 = im_label;

for j = 1 : num
    L_num(j) = numel(find(im_label == j));
    if L_num(j) < minimum_size
        im_label2(im_label == j) = 0;
    end
end

imflat=zeros(size(im_label2));
imflat(im_label2~=0)=1;

SE2 =strel('disk',5);
% perim = imopen(imflat,SE2);   %% This will remove the entire background,
% ensuring > 2 pixel border the entire way around.
perim = ~bwmorph(imflat,'remove');  %% Perhaps this for just a border? seems a bit razzy.
perim2 = ~bwmorph(perim,'shrink',1);


num_oranges = max(max(bwlabel(im_label2)));

IMb(perim2==1)=255;
IMr(perim2==1)=0;
IMg(perim2==1)=0;

oranges2 = cat(3,IMr,IMg,IMb);
str= "The number of oranges is: " + num2str(num_oranges);

figure(7)
    imshow(oranges2)
    title(str)
    impixelinfo
    % Clearly there is a problem in both the watershedding and the boundary
    % code. Run out of time to fix this.


%% Part 3:
% Reading almond.jpg

% init
close all
clear all
clc

% A) import image
almonds = imread('almond.jpg');
im_r = almonds(:,:,1);
im_g = almonds(:,:,2);
im_b = almonds(:,:,3);

figure(1)
subplot(2,2,1)
    imshow(almonds);
    title("Original image")
    impixelinfo
subplot(2,2,2)
    imshow(im_r);
    title("Red layer")
    impixelinfo
subplot(2,2,3)
    imshow(im_g);
    title("Green layer")
    impixelinfo
subplot(2,2,4)
    imshow(im_b);
    title("Blue layer")
    impixelinfo
    pause(1/10)

almondsYiq = rgb2ntsc(almonds);
im_Yiq_Y = almondsYiq(:,:,1);
im_Yiq_I = almondsYiq(:,:,2);
im_Yiq_Q = almondsYiq(:,:,3);

figure(2)
subplot(2,2,1)
    imshow(almondsYiq);
    title("YIQ image")
    impixelinfo
subplot(2,2,2)
    imshow(im_Yiq_Y);
    title("Y layer")
    impixelinfo
subplot(2,2,3)
    imshow(im_Yiq_I);
    title("Inphase layer")
    impixelinfo
subplot(2,2,4)
    imshow(im_Yiq_Q);
    title("Quadphase layer")
    impixelinfo
    pause(1/10)

almonds_XYZ = rgb2xyz(almonds);
im_XYZ_x = almonds_XYZ(:,:,1);
im_XYZ_y = almonds_XYZ(:,:,2);
im_XYZ_z = almonds_XYZ(:,:,3);

figure(3)
subplot(2,2,1)
    imshow(almonds_XYZ);
    title("XYZ image")
    impixelinfo
subplot(2,2,2)
    imshow(im_XYZ_x);
    title("X layer")
    impixelinfo
subplot(2,2,3)
    imshow(im_XYZ_y);
    title("Y layer")
    impixelinfo
subplot(2,2,4)
    imshow(im_XYZ_z);
    title("Z layer")
    impixelinfo
    pause(1/10)

almonds_HSV = rgb2hsv(almonds);
im_HSV_h = almonds_HSV(:,:,1);
im_HSV_s = almonds_HSV(:,:,2);
im_HSV_v = almonds_HSV(:,:,3);

figure(4)
subplot(2,2,1)
    imshow(almonds_HSV);
    title("HSV image")
    impixelinfo
subplot(2,2,2)
    imshow(im_HSV_h);
    title("H layer")
    impixelinfo
subplot(2,2,3)
    imshow(im_HSV_s);
    title("S layer")
    impixelinfo
subplot(2,2,4)
    imshow(im_HSV_v);
    title("V layer")
    impixelinfo
    pause(1/10)

almonds_LAB = rgb2lab(almonds);
im_LAB_l = almonds_LAB(:,:,1);
im_LAB_a = almonds_LAB(:,:,2);
im_LAB_b = almonds_LAB(:,:,3);

figure(4)
subplot(2,2,1)
    imshow(almonds_LAB);
    title("LAB image")
    impixelinfo
subplot(2,2,2)
    imshow(im_LAB_l);
    title("L layer")
    impixelinfo
subplot(2,2,3)
    imshow(im_LAB_a);
    title("A layer")
    impixelinfo
subplot(2,2,4)
    imshow(im_LAB_b);
    title("B layer")
    impixelinfo
    pause(1/10)

almonds_YCbCr = rgb2ycbcr(almonds);
im_YCbCr_Y = almonds_YCbCr(:,:,1);
im_YCbCr_Cb = almonds_YCbCr(:,:,2);
im_YCbCr_Cr = almonds_YCbCr(:,:,3);
pause(1/10)

figure(4)
subplot(2,2,1)
    imshow(almonds_YCbCr);
    title("YCbCr image")
    impixelinfo
subplot(2,2,2)
    imshow(im_YCbCr_Y);
    title("Y layer")
    impixelinfo
subplot(2,2,3)
    imshow(im_YCbCr_Cb);
    title("Cb layer")
    impixelinfo
subplot(2,2,4)
    imshow(im_YCbCr_Cr);
    title("Cr layer")
    impixelinfo
    pause(1/10)

% Channels i like for thresholding:

imI_th  = im_Yiq_I > 0.09;
imCb_th = im_YCbCr_Cb < 120;

im_th = imI_th & imCb_th;

figure(5)
subplot(2,2,1)
    imshow(imI_th);
    title("YIQ Inphase layer threshold")
    impixelinfo
subplot(2,2,2)
    imshow(imCb_th);
    title("YCbCr CB layer threshold")
    impixelinfo
subplot(2,2,3)
    imshow(im_th)
    title("Combined threshold")
    impixelinfo
    pause(1/10)

im_label = bwlabel(im_th);
num_almd = max(max(im_label));
str = "The number of almonds in the image is: " + num2str(num_almd);

figure(6)
subplot(1,2,1)
    imshow(almonds)
    title("Initial Image")
subplot(1,2,2)
    imshow(im_th)
    title(str)
pause(1/10)


S_al = regionprops(im_label, 'Centroid');
Cent = cat(1,S_al.Centroid);
c_label = label2rgb(im_label,'winter', 'k', 'shuffle');

pause(1/10)

figure(7)
    imshow(c_label)
    for j = 1:length(Cent)
        text((Cent(j,1)-10), Cent(j,2), num2str(j));
    end
    title(str)
pause(1/10)

SE = strel('disk',1);

im_dam_fill = imfill(im_th,'holes');
im_dam      = im_dam_fill &~ im_th;
erdam       = imerode(im_dam,SE);
errecon     = imreconstruct(erdam,im_dam);

dam_label = bwlabel(errecon);
dam_holes = max(max(dam_label));
str = "The number of damaged almonds in the image is: " + num2str(dam_holes);

figure(9)
    imshow(errecon)
    title(str)
    pause(1/10)

im_r(errecon==1) = 255;
im_g(errecon==1) = 0;
im_b(errecon==1) = 0;

almd = cat(3,im_r, im_g, im_b);

figure(10)
    imshow(almd)
    title(str)
pause(3)
 







