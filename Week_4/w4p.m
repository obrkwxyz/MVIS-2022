%w4p.m Hit-or-miss operation with 2 SE
clear all, close all, clc
I=zeros(5,14); I(2:4, 3:4)=1; I(2:4, 6:8)=1; I(2:4, 10:12)=1; I(3,13)=1;
I=logical(I); %convert the matrix into a logical date type (binary image)

%Objects to hit
SE1=[1 1 1;1 1 1;1 1 1];
%Objects to miss  - hit the complemented image
SE2=ones(5,5); SE2(2:4, 2:4)=0;
%apply hit-miss oepration
IHM=bwhitmiss(I, SE1, SE2);

figure(1), 
subplot(2,1,1), imagesc(I), axis image; colormap('gray'), 
title('original image');
subplot(2,1,2), imagesc(IHM), axis image; colormap('gray');
title('The result of hit-or-miss operation');

%recover the original shape after the hit-miss 
IR=imreconstruct(IHM, I);
figure(2), 
subplot(2,1,1), imagesc(I), axis image; colormap('gray'), 
title('original image');
subplot(2,1,2), imagesc(IR), axis image; colormap('gray');
title('Reconstruct the result of hit-or-miss operation');
