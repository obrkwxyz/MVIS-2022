%w2zc.m: Matrix indexing to change a colour after threshold
clear all, close all
C=imread('die.bmp');
%threshold applied to detect connecting nodes
CT=C>10 & C<40; 
figure(1), 
subplot(1,2,1), imshow(C), title('The original image')
subplot(1,2,2), imshow(CT), title('Thresholded image')
%All connecting nodes will be coloured in red
CR=C; CG=C; CB=C;
CR(CT==1)=255; CG(CT==1)=0; CB(CT==1)=0;
C2=cat(3,CR, CG,CB);
figure(2), imshow(C2), title('All nodes are in red')
