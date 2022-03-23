%w4k.m Number of different size circles using Image Erosion/image
%reconstruction
close all, clear all
TO=imread('circles_colour.bmp'); 
figure(1), imshow(TO), title('Original image') 

T=rgb2gray(TO)>30;
[L,num_0]=bwlabel(T); % The number of all circles
%the numebr of all circles
figure(2), imshow(T), 
title(['The number of all circles is ', num2str(num_0)])

B=strel('diamond',25); 
%Count the smallest circles to find the number of them  
TE1=imerode(T,B); TE1R=imreconstruct(TE1,T); 

%Take the difference between the two = smallest circles only
circle1=T&~TE1R; [LN1,num_N1]=bwlabel(circle1); [L1,num_1]=bwlabel(circle1);
figure(3), 
subplot(2,1,1), imshow(T), title('original image')
subplot(2,1,2), imshow(TE1R),
title(['reconstructed image: number of smallest circles: ', num2str(num_N1)])

