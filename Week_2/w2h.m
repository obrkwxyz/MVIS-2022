%w2h.m (Customised LUT)
close all, clear all,clc
%creare look up table
x1=50; x2=100; y1=100; y2=200; 
T1=y1/x1*[1:x1]; 
T2=(y2-y1)/(x2-x1)*[((x1+1):x2)-x1]+y1; 
T3=(255-y2)/(255-x2)*[((x2+1):255)-x2]+y2; 
LUT1=uint8(floor([T1 T2 T3])); 
%apply LUT to the image
En=imread('boy_b.bmp'); 
E2=LUT1(En+1); %you need to add "1" to remove index "0" in the LUT operation

figure(1), imshow(En), title('Original image')
figure(2), imshow(E2), title('After LUT applied') 