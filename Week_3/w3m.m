%w3m.m- connected components
close all,clear all, clc
%generate an arbitrary image and resize it for display
BW=zeros(8,8); BW(2:4,3:6)=1; BW(5:7,2)=1; BW(8,4:5)=1;
%enlarge the original for display
BW_big=imresize(BW,16,'nearest'); 
figure(1), imshow(BW_big), title('Original')

%bwlabel: labeling with 4-connected components 
[L4,num_com4]=bwlabel(BW,4)
[L8,num_com8]=bwlabel(BW,8)

% the number of objects
disp(['number of 4-connected components is =  ', num2str(num_com4)])
disp(['number of 8-connected components is =  ', num2str(num_com8)])

% find all pixel locations with label=1 in 4-connected components. 
[r41,c41] = find(L4==1); rc4_1 = [r41 c41] 


