%w2m.m Adaptive Histogram Equalisation
clear all, close all, clc
W=imread('mars.bmp'); 
figure(1), imshow(W),title('original image')
figure(2), imhist(W), title('Histogram of Original Image')

WE=histeq(W);
figure(3), imshow(WE), title('histogram equalisation')

WA=adapthisteq(W,'NumTiles',[40 40], 'ClipLimit',0.05);
figure(4), imshow(WA),  title('adaptive histogram equalisation')
figure(5), imhist(WA), title('Histogram of Adaptive histogram equalisation')