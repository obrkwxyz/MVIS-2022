%w3n.m- bwlabel connected components
close all,clear all, clc
%generate an arbitrary image and resize it for display
BW=zeros(8,8); BW(2:4,3:6)=1; BW(5:7,2)=1; BW(8,4:5)=1;
%enlarge the original for display
BW_big=imresize(BW,16,'nearest'); 
figure(1), imshow(BW_big), title('Original')

CC4=bwconncomp(BW,4) % identify the connected component
CC8=bwconncomp(BW,8) % identify the connected component

%display the number of conencted components in the image
disp(['number of 4-connedted components is =  ', num2str(CC4.NumObjects)])
disp(['number of 8-connedted components is =  ', num2str(CC8.NumObjects)])

BW
% to see the first linear indices of the first element.
CC4.PixelIdxList{1}

%we can erase with the pixels with label=2
BW2=BW; BW2(CC4.PixelIdxList{2}) = 0;
BW_big2=imresize(BW2,16,'nearest'); %enlarge the image for display
figure(2), imshow(BW_big2); title('pixels with label 2 erased')