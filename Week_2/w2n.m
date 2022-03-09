%w2n.m (mathematical convolution)
close all, clear all, clc
image1=[0 1 1 2 1 0 0] %matrix (image)
%correlation
Filter_cor=[4 2 1] %filter
Correlated_image=conv(image1,Filter_cor)
%convolution: filter to be rotated 180 degrees. 
Filter_con=[1 2 4]
convoluted_image=conv(image1,Filter_con)

%2D convolution
A=zeros(10);
A(3:7,3:7)=ones(5); %matrix (image)
f=[1 1 1;1 2 1;1 1 1]./10; %filter
H=conv2(A,f); 
disp('the original matrix'), A, 
disp('the result of convolution'), H(2:11,2:11) %convolution
