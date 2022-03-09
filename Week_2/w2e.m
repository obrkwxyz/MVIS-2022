%w2e.m logical operation of thresholded images
close all,clear all, clc
H1=imread('coin1.bmp');
H2=imread('coin2.bmp');

HD1=imsubtract(H1,H2);
HD2=imsubtract(H2,H1);
figure(1)
subplot(1,2,1)
    imshow(HD1)
    title('Image1-Image2')
subplot(1,2,2)
    imshow(HD2)
    title('Image2-image1')
%Threshold
HD3=HD1>80; HD4=HD2>80;

%comparison between logical operation and arithmetic operation
%the results looks the same. but check whos and see the difference 
%So you should use logical oepration for logical datatype!
HD5=HD3|HD4; %logical operation for image addition
HD6=imadd(HD3,HD4); %arithmetic operation for image addition

figure(2)
subplot(1,2,1)
    imshow(HD5)
    title('Logical operation')
subplot(1,2,2)
    imshow(HD6)
    title('Image addition')

whos