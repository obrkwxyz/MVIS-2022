% w6l.m - major axis, minor axis and eccentricity using regionprops  
close all, clear all, clc
f=imread('shapes1.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('Binary Image'); % Create a binary image using threshold  

%Obtain major axis, minor axis and eccentricity for all objects   
sB=regionprops(fg,'MajorAxisLength', 'MinorAxisLength','Eccentricity');
%Obtain the same of each object using bwlabel
[L,num]=bwlabel(fg);
sL=regionprops(L,'MajorAxisLength', 'MinorAxisLength','Eccentricity');

for m=1:num
    dL=uint8(zeros(size(L)));
    dL(L==m)=1;
    maj_axis(m)=sL(m).MajorAxisLength;
    min_axis(m)=sL(m).MinorAxisLength;
    eccent(m)=sL(m).Eccentricity;
    figure(m+1), imshow(dL,[]); 
    title(['MajorAxislength: ', num2str(maj_axis(m)), ' MinorAxislength: ', num2str(min_axis(m)), ' Eccentricity: ',num2str(eccent(m))]) 
end
major_axis=[maj_axis]
minor_axis=[min_axis]
eccentricity=[eccent]