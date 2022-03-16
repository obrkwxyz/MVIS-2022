%w3o.m Labelling the number of objects
close all,clear all, clc
I = imread('bolt.bmp'); 
figure(1), imshow(I), title('original image') 
%Threshold the image using imbinarize and graythresh command.
th=0.40; BWO = imbinarize(I, th); 

%original image - no. of objects
[L8o, num8o] = bwlabel(BWO,8); 
figure(2), imshow(BWO),title(['The number of objects is ', num2str(num8o)])

%Complement the image to make the objects F/G.
BW=imcomplement(BWO);

% Label the binary image with 8-connected components
[L8, num8] = bwlabel(BW,8); 
figure(3), imshow(BW),title(['The number of objects is ', num2str(num8)])