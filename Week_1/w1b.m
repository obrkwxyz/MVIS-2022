%w1b.m (resize the images - image resolution)
close all, clear all, clc
X=imread('josh1c.bmp'); %256x256
X1=imresize(X,1/2,'nearest');  %128x128
X2=imresize(X,1/4,'nearest'); %64x64
X3=imresize(X,1/8,'nearest'); %16x16

Y1=imresize(X1,2,'nearest');  %256x256
Y2=imresize(X2,4,'nearest');  
Y3=imresize(X3,8,'nearest');  

figure(1)
    imshow(X)
    title('Original Image')
    pause
figure(2)
    imshow(X1)
    title('Half sized Image')
    pause
figure(3)
    imshow(X2)
    title('Quarter sized Image')
    pause
figure(4)
    imshow(X3)
    title('Eighth sized Image')
    pause

figure(1)
    imshow(X)
    title('Original image (256x256)')
    pause
figure(5)
    imshow(Y1)
    title('half the original (128x128)')
    pause
figure(6)
    imshow(Y2)
    title('1/4 the original (64x64)')
    pause
figure(7)
    imshow(Y3)
    title('1/8 the original (16x16)')
    pause

display('End.')
