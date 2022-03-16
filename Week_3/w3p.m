% w3p.m : Distance transformation: bwdist
close all, clear all
A = zeros(5,5); A(2,2) = 1; A(4,4) = 1
[D4,L4] = bwdist(A,'cityblock')
[D8,L8] = bwdist(A,'chessboard')
[DE,LE] = bwdist(A) % Euclidean distance is default
figure(1),imshow(imresize(A,48,'nearest')),title('original')
figure(2), subimage(mat2gray(D4)), title('City block: 4 distance')       
figure(3), subimage(mat2gray(D8)), title('Chessboard: 8 distance')      
figure(4), subimage(mat2gray(DE)), title('Euclidean')   