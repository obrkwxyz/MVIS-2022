%w2a.m (image offset processing)
close all
clear all
clc
H1=imread('boy_b.bmp');

H1=imadjust(H1, [], [0.2 0.8]);

H2=imadd(H1,50);
H3=imsubtract(H1,50); %you can do imadd (H1,-80)
figure(1)
    imshow(H1)
    title('original Image')
figure(2)
    imshow(H2)
    title('Positive offset')
figure(3)
    imshow(H3)
    title('Negative offset')

H4=immultiply(H1,0.5);  
H5=immultiply(H1,2);  % You can use imdivide(H,2) instead
H6=imsubtract(immultiply(H1,2),40);

figure(4)
    imshow(H4)
    title('Compressed Gain (Multiply by 0.5)')
figure(5)
    imshow(H5)
    title('Stretched Gain (Multiply by 2)')
figure(6)
    imshow(H6)
    title('Gain + Offset')
