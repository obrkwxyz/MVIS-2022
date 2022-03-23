%w4l.m Combination of Opening and closing
close all, clear all, clc
I=imread('co_ex.bmp'); 
SE = strel('square',5);  
IC=imclose(I,SE); ICO=imopen(IC,SE);
IO=imopen(I,SE); IOC=imclose(IO,SE);
figure(1), imshow(I),title('Original')
figure(2), 
subplot(2,2,1), imshow(IC), title('Closed')
subplot(2,2,2), imshow(ICO), title('Closed --> Opened')
subplot(2,2,3), imshow(IO), title('Opened')
subplot(2,2,4), imshow(IOC), title('Opened --> closed')

%with the real image
C=imread('rocks.bmp'); W=imbinarize(C,graythresh(C));
se=strel('square',3); 
WC=imclose(W,se); WCO=imopen(WC,se);
WO=imopen(W,se); WOC=imclose(WO,se);
figure(3), 
subplot(1,2,1), imshow(C), title('original')
subplot(1,2,2), imshow(W),title('thresholded')
figure(4), 
subplot(2,2,1), imshow(WC), title('Closed')
subplot(2,2,2),  imshow(WO),title('Opened')
subplot(2,2,3), imshow(WCO), title('Closed->Opened')
subplot(2,2,4), imshow(WOC),title('Opened->Closed')
