%w5h.m (Canny edge detector compared to other detectors) 
close all, clear all, clc
C=imread('machine.bmp');
BS = edge(C,'sobel');
BP = edge(C,'prewitt');
BL= edge(C,'log');
BC= edge(C,'canny');
BAC= edge(C,'approxcanny');

figure(1), imshow(C),title('Original Image')
figure(2), 
subplot(1,2,1), imshow(BS),title('edge detector with Sobel operator')
subplot(1,2,2),imshow(BP),title('edge detector with Prewitt operator')
figure(3)
subplot(1,2,1),imshow(BL),title('edge detector with Marr-Hildreth operator')
subplot(1,2,2),imshow(BC),title('edge detector with Canny operator')

figure(4)
subplot(1,2,1),imshow(BC),title('edge detector with Canny operator')
subplot(1,2,2),imshow(BAC),title('edge detector with ApproxCanny operator')