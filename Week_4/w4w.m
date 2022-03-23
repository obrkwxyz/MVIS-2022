%w4w.m (Dual relation between Dilation and Erosion)
clear all,close all, clc
W=imread('lena_g.bmp');
figure(1), imshow(W),title('Original')
 
SE1=strel('diamond',3);
WD1=imdilate(W,SE1); WE1=imerode(W,SE1);

%dual relationship between erosion and dilation
WD1C=imcomplement(WD1); 
figure(2), 
subplot(2,2,1), imshow(WD1), title('dilated image') 
subplot(2,2,2), imshow(WD1C), title('dilated --> complemented') 

WC=imcomplement(W); 
WCE=imerode(WC,SE1); 
subplot(2,2,3), imshow(WC), title('Complemented image') 
subplot(2,2,4), imshow(WCE),title('complemented --> eroded')
