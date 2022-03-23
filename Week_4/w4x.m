%w4x.m (Opening and Closing & dual relation)
clear all,close all, clc
W=imread('lena_g.bmp');
figure(1), imshow(W),title('Original')
 
SE1=strel('square',5);
WE1=imerode(W,SE1); OW1=imopen(W,SE1); 
WD1=imdilate(W,SE1); CW1=imclose(W,SE1);

figure(2), 
subplot(2,2,1), imshow(WE1), title('Image erosion')
subplot(2,2,2), imshow(OW1), title('Image opening (erosion --> dilation)')
subplot(2,2,3), imshow(WD1), title('Image dilation')
subplot(2,2,4), imshow(CW1), title('Image closing (dialtion --> erosion)')

%dual relationship between opening and closing
OW1_C=imcomplement(OW1);
WC=imcomplement(W);WC_C=imclose(WC,SE1);
figure(3), 
subplot(2,2,1), imshow(OW1),title('Opened')
subplot(2,2,2), imshow(OW1_C),title('Opening --> complemented')
subplot(2,2,3), imshow(WC),title('Complemented')
subplot(2,2,4), imshow(WC_C),title('Complemented --> closed')
