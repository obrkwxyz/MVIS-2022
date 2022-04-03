%w5q.m (watershed function)
clear all, close all, clc
Ori_A=imread('4dots.bmp');
figure(1), imshow(Ori_A); title('Original Image')
%Apply threshold 
Ori_T=Ori_A>135; %thresholded
figure(2), imshow(Ori_T); title('Threshold image')
A=imfill(Ori_T, 'holes');
figure(3), imshow(A); title('all holes filled')

% use imcomplement to ensure that the objects "black" and
% background is "white" 
A_C=imcomplement(A); 
figure(4), imshow(A_C); title('Complemented Image')
D_C=bwdist(A_C);
figure(5), imshow(D_C, []), impixelinfo, title('Distance transformation'); 

% in the current D_C, the value in the centre is higher than the value in
% the boundary. We need to invert it so that the centre value 
% is lower than the boundary value using imcomplement 
DM=imcomplement(D_C);
figure(6), imshow(DM, []), impixelinfo
title('Distance transformation-complemented'); 

% Then we can apply watershed function. 
WA=watershed(DM); unique(WA);
% note WA shows the different regions (in this case we have 8 regions)
% with all watershed values (boundary) values = 0. 
figure(7), imshow(WA, []),impixelinfo, 
title('watershed function applied')
%To show watershed ridges, take all watersheds (all pixels of WA=0)
%to be used for segmentation. All watershed ridge values are set to "1" 
W_shed=zeros(size(WA));
W_shed(WA==0)=1; 
figure(8), imshow(W_shed), impixelinfo, title ('boundaries in watershed')
% Now we subtract watershed pixels from the original image so that the 
%boundary can be shown. note that A-B=A&~B.
A2=A & ~W_shed;
figure(9), imshow(A2); impixelinfo, 
title('watershed ridges shown in the binary image')

%label each one of them. 
[L,num]=bwlabel(A2);
figure(10), imshow(L, [0, num]); impixelinfo
title(['Labelled image: ', num2str(num)])
% To remove over segmentation, we need to specify the 
% minimum number of pixels in the objects. 
% Anything below this will be ignored  
minimum_size=100; 
A3=A2; 
for kk=1:num;
    L_num(kk)=numel(find(L==kk));
    if L_num(kk)<minimum_size; A3(L==kk)=0; end
end

[L2,num2]=bwlabel(A3);
figure(11), imshow(A3); 
title(['Final image after watershed- number of circles ', num2str(num2)])
