%w1c.m (grey scale quantisation)
close all
clear all
clc

X=imread('josh1g.bmp'); size(unique(X)) %256 levels
X1=grayslice(X,64);
size(unique(X1)) % only 128 levels
X2=grayslice(X,16);
size(unique(X2)) % only 16 levels
X3=grayslice(X,2);
size(unique(X3)) % only 2 levels

figure(1)
    imshow(X)
    title('original') % Use the original image
    pause
figure(2)
    imshow(X1,gray(64)) % Use gray(128) map
    title('128 level')
    pause

figure(3)
    imshow(X2,gray(16)) % Use gray(16) map
    title('16 level')
    pause
figure(4)
    imshow(X3,gray(2)) % Use gray(2) map
    title('2 level')
    pause
figure(5)
    imshow(X2)  % 256 colour map. 
    impixelinfo
    title('16 level displayed with 256 map')
    pause
    
display('End.')