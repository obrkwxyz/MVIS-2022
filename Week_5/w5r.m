%w5r.m (watershed function applied to plugs_g.png image)
clear all, close all, clc
A=imread('plugs_g.png');
figure(1), imshow(A); title('Original Image')

%For easier processing of watershed, convert the image to binary image
T=graythresh(A);
AG=imbinarize(A, T); 
AG=imfill(AG, 'holes');
figure(2), imshow(AG), title('thresholded')

SE1=strel('square',5);
AG_e=imerode(AG, SE1); AG_re=imreconstruct(AG_e, AG);
[L1,num1]=bwlabel(AG_re);
figure(3), imshow(AG_re), title('Noise removed')

%Firstly Complement the imagelement the image to apply the distance 
% function (bwdist) of matlab. ITake the complement the image 
% againn imshow, [] is important to show the grayscale as it is!
AG_C=imcomplement(AG_re); D=bwdist(AG_C);
figure(3), imshow(AG_C), title('thresholded and complemented') 
figure(4), imshow(D, []), title('Distance transformation'); impixelinfo 
% Currently in D matrix, the boundary value is lower than the centre of
% object(so water will not flow towards the centre). We need to invert the
% image so that the boundary value of D is higher than the centre of the
% object. Then we can apply watershed function
DM=imcomplement(D); 
WA=watershed(DM); 
figure(5), imshow(DM, []); title('inverted distance transformation'); impixelinfo
figure(6), imshow(WA, []); title('Watershed')

%WA shows the catchment basin. Depending on the number of catchment basin (say n),
%it will shown the number 1 to n. "0" pixels represent the watershed
%ridges! So we need to take them out from WA matrix to be used for
%segmentation.
w_shed=(WA==0); 
% The subtract the watershed from the original binary image to separate
% each object in the image. note that A-B=A&~B.
A2=AG_re & ~w_shed;
[L2,num2]=bwlabel(A2);
figure(7), imshow(A2); 
title(['watershed - number of objects: ', num2str(num2), ' (Oversegmantation problem)'])
figure(8), imshow(label2rgb(L2, 'jet','k','shuffle'))

% To remove errors, we may need to specify the minimum number for 
% pixels in the objects to restrict the size. Anything below this 
% number may be considered as an error. 
minimum_size=200; 
A3=A2; 
for kk=1:num2;
    L_num(kk)=numel(find(L2==kk));
    if L_num(kk)<minimum_size; A3(L2==kk)=0; end
end

[L3,num3]=bwlabel(A3);

figure(9), 
subplot(1,2,1), imshow(AG_re), 
title(['Before watershed - number of objects: ', num2str(num1)])
subplot(1,2,2), imshow(A3); 
title(['After watershed - number of objects: ', num2str(num3)])
