%w2c.m (Power raw function)
clear all, close all, clc
T=imread('tire.tif');
TA=imadjust(T,[ ],[ ],0.3); % s=r^(1/3)
TB=imadjust(T,[ ],[ ],3); % s=r^3
figure(1), imshow(T), title('Original Image')
figure(2),
subplot(2,2,1), imshow(TA), title('Gamma=0.3')
subplot(2,2,2), plot(T,TA,'b.'), axis tight
subplot(2,2,3), imshow(TB), title('Gamma=3')
subplot(2,2,4), plot(T,TB,'b.'), axis tight

