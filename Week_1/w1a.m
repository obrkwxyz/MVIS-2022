close all
clear all
clc
% read the image
WC=imread('light.tif');
%size of the image
[W,H,L]=size(WC);
figure(1)
    imshow(WC)
    title('Original Image')
    impixelinfo(1)
    pause

impixel(WC,100,260) %individual pixel at (x,y)
pause
%check difference between calling image andd matrix element
WC(100,260,:) % (y,x)
WC(260,100,:) % (y,x)

%Grey scale image
WGS=rgb2gray(WC);
size(WGS);

figure(2)
    imshow(WGS)
    title('Greyscale Image')
    pause
    impixelinfo(2) %Call for figure 2
    pause
    
WGS(260,100)
impixel(WGS,100,260) %% See these dont match due to (x,y) (y,x)


%detailed information about the image
% Show the Struct.
W_Info=imfinfo('light.tif')
W_Info.Width
%save the image
imwrite(WC,'light_c.png','png');




