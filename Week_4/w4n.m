%w4n.m Boundary extraction using MIP and bwperim
clear all, close all, clc

R=imread('shapes.png'); 
SE1=strel('square',3); %for 4 connected boundary
SE2=strel('diamond',1); % for 8 connected boundary

%Internal boundary extraction using MIP
%3x3 square SE: 4 connected boundary 
RE1=imerode(R,SE1); IB4_MIP=R&~RE1; 
%3x3 diamond SE: 8 connected boundary 
RE2=imerode(R,SE2); IB8_MIP=R&~RE2; 

figure(1), imshow(R),title('Original')
figure(2), imshow(IB8_MIP),
title('IB with 3x3 diamond SE - 8 connected boundary');
figure(3), imshow(IB4_MIP),
title('IB with 3x3 square SE - 4 connected boundary');

%Internal boundary using bwperim 
IB4_BP=bwperim(R,4); %4 connect internal boudnary with bwperim ---- binary image perimeter detection
IB8_BP=bwperim(R,8); %8 connect internal boudnary with bwperim

figure(4), imshow(IB4_BP),
title('Result of bwperim - 8 connected internal boundary');
figure(5), imshow(IB8_BP),
title('Result of bwperim - 4 connected internal boundary');
