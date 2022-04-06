% w6j.m - centroid 
close all, clear all, clc
f=imread('shapes1.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('Binary Image');  hold on
%find the centroid of objects
[L,num]=bwlabel(fg);
sB_E=regionprops(fg,'Centroid','BoundingBox'); %Centroid of all objects 
%plot(sB_E.Centroid(1), sB_E.Centroid(2), 'r*')
 
sB=regionprops(L,'Centroid');
cen=cat(1, sB.Centroid)
cen2=cat(2, sB.Centroid)
for m=1:num
   fl=fg; fl(L~=m)=0;
   figure(m+1), imshow(fl), hold on
   plot(cen(m,1), cen(m,2),'r*')
   title(['Centroid of object ', num2str(m), ': (', ...
       num2str(cen(m,1)), ' , ', num2str(cen(m,2)),')'])
end  
    


