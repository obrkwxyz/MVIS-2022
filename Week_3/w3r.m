%w3r.m Distance transformation: bwdist
clear all,close all
A=zeros(12,19);
A(3:9,:)=1;A(10:12,7:13)=1;
figure(1),imshow(imresize(A,16,'nearest')),title('Original')
AC=imcomplement(A);

D4 = bwdist(AC,'cityblock')
D8 = bwdist(AC,'chessboard')
figure(2), subimage(mat2gray(D4)), title('City block: 4 distance')
hold on, imcontour(D4)
figure(3), subimage(mat2gray(D8)), title('Chessboard: 8 distance')
hold on, imcontour(D8)