%w4g.m Effect of Image opening and closing - idempotent
close all, clear all,clc
W=imread('shapes.png'); %image with noise
sq=strel('square',7);

WO1=imopen(W,sq);WC1=imclose(W,sq); 
WO2=imopen(WO1,sq);WC2=imclose(WC1,sq); 
WO3=imopen(WO2,sq);WC3=imclose(WC2,sq); 

figure(1), imshow(W), title('original')
figure(2), 
subplot(2,2,1), imshow(WO1), title('opening once')
subplot(2,2,2), imshow(WO2), title('opening twice = No changes')
subplot(2,2,3), imshow(WC1), title('closing once')
subplot(2,2,4), imshow(WC2), title('closing twice = No changes')
