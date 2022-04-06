%w6i.m (signature calculation)
clear all, close all, clc

%try with both images
f=imread('cir.png');
%f=imread('onesqu.bmp');
BW=imbinarize(f, graythresh(f)); 
figure(1),imshow(BW), title('Binary image')
%calculate centroid
stats=regionprops(BW,'Centroid'); c=stats.Centroid;
%Coordinates of boundary
boundary=bwboundaries(BW);
x=boundary{1}(:,1); y=boundary{1}(:,2);
%calculate distance from the centroid to boudanry
distances=sqrt((y-c(1)).^2+(x-c(2)).^2);
%plot signature
t=1:1:length(distances);
figure(2), plot(t,distances);hold on
axis([1 length(distances) 0 max(distances)+20]), grid on