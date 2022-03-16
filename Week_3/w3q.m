% w3q.m : Distance transformation: bwdist (lecture slide example)
close all, clear all
A=[0 0 0 0 0 0 0 0; 0 1 1 1 1 1 1 0; 0 1 1 1 1 1 1 0; ...
   0 1 1 1 1 0 0 0; 0 1 1 1 1 0 0 0; 0 0 0 0 0 0 0 0]
%complement of the matrix is necessary to obtain the distance for the pixel
%inside the objects
AC=imcomplement(A);

[D4,L4] = bwdist(AC,'cityblock'); D4
[D8,L8] = bwdist(AC,'chessboard'); D8
[DE,LE] = bwdist(AC); DE % Euclidean distance is default
figure(1),imshow(imresize(A,48,'nearest')),title('original')
figure(2), subimage(mat2gray(D4)), title('City block: 4 distance')       
figure(3), subimage(mat2gray(D8)), title('Chessboard: 8 distance') 
figure(4), subimage(mat2gray(DE)), title('Euclidean')     
