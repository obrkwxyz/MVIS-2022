%w3s.m (bwdist for a real image)
clear all, close all
A=imread('plugs.jpg');
figure(1), imshow(A); title('Original Image')
%Convert the image to binary image
Th=0.5; AG=imbinarize(A, Th);
figure(2), imshow(AG), title('thresholded and noise removed')
%remove the noise inside and outside
se1=strel('diamond', 1); AE=imerode(AG, se1); AR=imreconstruct(AE,AG);
figure(3), imshow(AR), title('thresholded and noise removed')

AH=imfill(AR, 'holes');
figure(4), imshow(AH), title('thresholded and noise removed')
% need to complement the image to apply 
% the distance function (bwdist) of matlab

AH_C=imcomplement(AH); D=bwdist(AH_C);
figure(5), imshow(AH_C), title('thresholded and complemented') 
figure(6), imshow(D, []), impixelinfo, title('Distance transformation'); 

