%w4q.m Hit-or-miss operation: find all corners
clear all, close all, clc
%generate a shape
W=zeros(14,15); W(2:4,9:13)=1; W(3,14)=1; W(3:4,3:6)=1; W(5,2)=1; 
W(5:6,3:12)=1;W(5,13)=1; W(7:8,3:4)=1;W(9,4)=1; W(10:13,3:9)=1;
W(7:9,10:13)=1; W(10,10:12)=1;W(11,10:11)=1; W(12,10)=1;
figure(1), imagesc(W), colormap('gray'), axis image, title('Original')

%generate SE to detect  four corners
SE1=[0 1 0;-1 1 1;-1 -1 0], %detect left bottom corner
SE2=[0 1 0;1 1 -1;0 -1 -1], %detect right bottom corner
SE3=[0 -1 -1;1 1 -1;0 1 0], %detect right top corner
SE4=[-1 -1 0;-1 1 1;0 1 0], %detect left top corner
%Apply bwhitmiss operation
H1=bwhitmiss(W,SE1); H2=bwhitmiss(W,SE2);
H3=bwhitmiss(W,SE3); H4=bwhitmiss(W,SE4);

figure(2), 
subplot(2,2,1), imagesc(H1), colormap('gray'), axis image, title('left bottom corner')
subplot(2,2,2), imagesc(H2), colormap('gray'), axis image, title('right bottom corner')
subplot(2,2,3), imagesc(H3), colormap('gray'), axis image, title('right top corner')
subplot(2,2,4), imagesc(H4), colormap('gray'), axis image, title('left top corner')
%Union (OR operation) them together
ToH=H1|H2|H3|H4;
figure(3),imagesc(ToH), colormap('gray'), axis image,title('Result of Hit-Miss')
