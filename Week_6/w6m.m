% w6m.m - find the length of 4 and 8 connectedd perimeter. 
close all, clear all, clc
f=imread('shapes1.bmp');  
fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('Binary Image'); 

%find boundaries using bwperim
%Use "8" for option for 4 connected perimeter
g4=bwperim(fg,8); figure(2), imshow(g4), title('4-connected perimeter');
%Use "4" for option for 8 connected perimeter
g8=bwperim(fg,4); figure(3), imshow(g8), title('8-connected perimeter');

%The length of 8-connected perimeter using  regionpros 
stat=regionprops(fg,'Perimeter');

%Count the number of pixels in 8-connect perimeter 
[L8,num8]=bwlabel(fg,8);
for m=1:num8
    ge4=zeros(size(g4));
    ge4(L8==m)=1;
    %imshow(ge), pause
    gep4=bwperim(ge4,4); %8-connected perimeter
    pixel_number_peri4(m)=length(find(gep4==1))-1; 
    %length of perimeter using regionprops
    Length_peri8(m)=stat(m).Perimeter; 
end
fprintf(['\n The number of pixels in 8 connected perimeters of objects found by bwperim are \n\n ',...
    num2str(pixel_number_peri4),'\n\n'])  
fprintf(['The lengths of 8 connected perimeters of objects found by regionprops are \n\n ',...
    num2str(Length_peri8),'\n'])  