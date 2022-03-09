%w2l.m contrast stretching and histogram equalisation
clear all, close all, clc
P=imread('grain.jpg'); 
%apply contrast stretching and image equalisation
PS=imadjust(P, [min(min(im2double(P))), max(max(im2double(P)))], [0, 1]);
PE=histeq(P,256);

figure(1), 
subplot(1,2,1), imshow(P),title('Original Image') 
subplot(1,2,2), imhist(P), title('Histogram')
figure(2), 
subplot(2,2,1), imshow(PS), title('Contrast Stretching') 
subplot(2,2,2), imhist(PS), title('contrast stretching')
subplot(2,2,3), imshow(PE), title('Histogram Equalisation')
subplot(2,2,4), imhist(PE), title('Histogram Equalisation')

%probability density function of original image
hnorm=imhist(P)./numel(P); % normalised histogram
cdf=cumsum(hnorm); [m,n]=size(cdf);
%probability density function of contrast stretched image
hnorms=imhist(PS)./numel(PS); % normalised histogram
cdfs=cumsum(hnorms);
%probability density function of histogrmam equalised image
hnorme=imhist(PE)./numel(PE); % normalised histogram
cdfe=cumsum(hnorme);

x=linspace(0,1,m); 

figure(3), 
subplot(1,3,1), plot(x,cdf),axis([0 1.01 0 1.01])
title('Probability Density Function of the Original Image')
subplot(1,3,2),  plot(x,cdfs),axis([0 1.01 0 1.01])
title('Probability Density Function of contrast stretched image')
subplot(1,3,3),  plot(x,cdfe),axis([0 1.01 0 1.01])
title('Probability Density Function of histogrmam equalised image')
