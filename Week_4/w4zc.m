%w4zc.m (textural Segmentation )
clear all, close all, clc
H=imread('text_blob.bmp');
HT=imbinarize(H,graythresh(H));
HB=imcomplement(HT);

%Remove small blobs with large SE
SE1=strel('disk',16);
HBO=imopen(HB,SE1); 

HBC=imcomplement(HBO);
%Remove spaces between large blobs 
SE2=strel('disk',27); HBCO=imopen(HBC,SE2); 

figure(1),
subplot(2,2,1), imshow(H),title('original')
subplot(2,2,2), imshow(HT),title('thresholded')
subplot(2,2,3), imshow(HBC), title('Small bolbs removed')
subplot(2,2,4), imshow(HBCO),title('Space between large bolbs removed')

% find the boundaey of the obatined image using morphological boundary
% extraction
SQ=strel('square',3);
HE=imerode(HBCO,SQ); HE_int=HBCO&~HE; %find internal boundary

%Show the internal boundary with the original image
HT=H; HT(HE_int==1)=255; 

figure(2),
subplot(1,2,1), imshow(HE_int), title('Boundary found')
subplot(1,2,2), imshow(HT),  title('Boundary shown in the original image')
