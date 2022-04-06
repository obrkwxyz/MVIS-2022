%w6c.m bwboundaries with full outputs
close all, clear all, clc
f=imread('numcir.png');
figure(1), imshow(f), title('original image'), impixelinfo
FB=imbinarize(f, 100/255); %threshold applied
figure(2), imshow(FB), title('Binary image'), impixelinfo

%In the following, the output of bwboundaries are as follows
%B: boundary of all objexts (including the holes inside)
%L: label matrix, NR: number of objects found
%A: logical sparse matrix detailing parent-child hole dependencies
[B1,L1,NR1,A1]=bwboundaries(FB,'noholes');
figure(3), imshow(L1, []),impixelinfo, 
title('labels of the objects with noholes option')

%display one object with lebelled "3" 
fs=zeros(size(FB));
fs(L1==3)=1;
figure(4), imshow(fs,[]), impixelinfo,
title('display object with label 3 only') 

%find the number of holes inside the objects
[B2,L2,NR2,A2]=bwboundaries(FB,'holes');
figure(5), imshow(L2, []),impixelinfo, 
title('labels of the objectswith holes option')

%the number of all objects including holes inside the region
disp(['The number of all objects including holes is ', num2str(numel(B2))])
%the number of regins (excluding holes)
disp(['the number of regions is ', num2str(NR2)])
%hence the number of holes inside the regions
disp(['The number of holes inside eriogns is ', num2str(numel(B2)-NR2)])

% the dependencies of the objects
disp('Sparse matrix to show parent-chile dependencies')
A2
disp('Full matrix to show parent-chile dependencies')
full(A2)