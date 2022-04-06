% w6k.m - width and height 
close all, clear all, clc
f=imread('shapes1.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('Binary Image');  

%the width and height using BoundingBox
[L,num]=bwlabel(fg);
sL=regionprops(L,'BoundingBox'); 

for m=1:num
  bb(m, 1:4)=sL(m).BoundingBox
  dL=uint8(zeros(size(L))); dL(L==m)=1; 
  figure(m+1), imshow(dL,[]), 
  title(['Object ', num2str(m), '- Width: ', num2str(bb(m,3)), ' Height: ', num2str(bb(m,4))])  
  hold on
  plot(bb(m,1),bb(m,2),'y*');  
  plot(bb(m,1)+bb(m,3),bb(m,2)+bb(m,4),'g*');
  line([bb(m,1), bb(m,1),bb(m,1)+bb(m,3),bb(m,1)+bb(m,3),bb(m,1)],...
      [bb(m,2), bb(m,2)+bb(m,4),bb(m,2)+bb(m,4),bb(m,2),bb(m,2)], 'color','r')
end

%find the width and height using "find"
for m=1:num
[c r]=find(L==m); 
max_r(m)=max(max(r)); min_r(m)=min(min(r)); % pixel points for width
max_c(m)=max(max(c)); min_c(m)=min(min(c)); % pixel points for height
r_width(m)=max_r(m)-min_r(m)+1; %width
c_width(m)=max_c(m)-min_c(m)+1; %height

%show it the position of two points
 dRC=uint8(zeros(size(L))); dRC(L==m)=1; 
 figure(m+7), imshow(dRC,[]),  hold on
title(['Object ', num2str(m), '- Width: ', num2str(r_width(m)), ' Height: ', num2str(c_width(m))])   
 plot(max_r(m), max_c(m), 'g*'); plot(min_r(m), min_c(m), 'y*')
end
[r_width; c_width]
