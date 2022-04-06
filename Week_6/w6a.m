%w6a.m bwlabel, bwperim 
close all
clear all
clc

f=imread('numcir.png');

figure(1)
    imshow(f)
    title('original image')
    impixelinfo

FB = imbinarize(f, 100/255); %threshold applied

figure(2)
    imshow(FB)
    title('Binary image')
    impixelinfo

%using bwlabel, we can find the number of objects
[L, num] = bwlabel(FB, 8); 

figure(3)
    imshow(L, [])
    impixelinfo %labelled image
    title(['The number of objects is ', num2str(num)])

%bwperim will find the perimeters of the holes inside the objects as well
f_boun = bwperim(FB,8); 
figure(4)
    imshow(f_boun)
    impixelinfo
    title('Perimeter of objects')

%You can use labels to colour different objects with different colours
fR=f; fG=f; fB=f;

fR(L==1)=255;
fG(L==1)=0;
fB(L==1)=0;
fR(L==2)=0;
fG(L==2)=255;
fB(L==2)=0;

FC = cat(3, fR, fG,fB); %combine three colour components together

figure(5)
    imshow(FC)
    impixelinfo
    title('Coloured Objects')
    