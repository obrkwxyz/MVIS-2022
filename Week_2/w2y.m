%w2y.m linear combination of images 
clear all, close all
W=imread('coin1.bmp'); P=imread('coin2.bmp');
h1=imlincomb(1,W,1,P);%image addition
h2=imlincomb(1,W,-1,P); % image subtraction
h3=imlincomb(0.5,W,1.5,P); %image combination
figure(1),
subplot(1,2,1), imshow(W);
subplot(1,2,2), imshow(P);
figure(2), 
subplot(2,2,1), imshow(h1), title('image addition')
subplot(2,2,2), imshow(h2), title('image subtraction')
subplot(2,2,3), imshow(h3), title('0.5 x image 1 + 1.5 x image 2')

