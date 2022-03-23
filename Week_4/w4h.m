%w4h.m Dual relationship between Opening and closing
close all, clear all,clc
I=imread('blob_bw.bmp'); SE = strel('square',9);  
IC=imclose(I,SE); ICN=imcomplement(IC);
IN=imcomplement(I); INO=imopen(IN,SE); 
figure(1), imshow(I),title('Original')
figure(2), 
subplot(2,2,1), imshow(IN), title('complemented')
subplot(2,2,2), imshow(INO), title('Complemented -> Opened')
subplot(2,2,3), imshow(IC), title('closed')
subplot(2,2,4), imshow(ICN), title('Closed -> complemented')