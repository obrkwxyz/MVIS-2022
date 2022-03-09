%w2f.m: Threshold using graythresh
clear all, close all, clc
S=imread('clip.tif');  

[t1, EM1]=graythresh(S); %EM1 is effectivenss of threshold value

ST=imbinarize(S,t1); %Thresholded using Ostu's method)
figure(1), 
subplot(1,2,1)
    imshow(S)
    title('original image')
subplot(1,2,2)
    imshow(ST),
    title(['Ostu method-Threshold ', num2str(t1*255), ' Effectiveness: ', num2str(EM1)])

R=imread('rice.tif');
[t2, EM2]=graythresh(R); 

RT1=imbinarize(R,t2); 

figure(2), 
subplot(1,2,1)
    imshow(R)
    title('original image')
subplot(1,2,2)
    imshow(RT1),
    title(['Ostu method-Threshold ', num2str(t2*255), ' Effectiveness: ', num2str(EM2)])

%you can use ostuthresh directly with imhist
[counts,x] = imhist(R);
t3 = otsuthresh(counts);
RT2 = imbinarize(R,t3);
figure(3)
    imshow(RT2)
    title(['Ostu method-Threshold ',num2str(t3*255)])
