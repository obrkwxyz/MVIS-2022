% w6q.m - other Factors obtained from regionprops
close all, clear all, clc
f=imread('shapes1.bmp'); fg=imbinarize(f, graythresh(f)); 

[L, num]=bwlabel(fg);
figure(1), imshow(L), title('Original Image'); impixelinfo
staB=regionprops(L,'Area', 'Perimeter', 'MajorAxisLength', 'ConvexArea',...
    'BoundingBox', 'ConvexImage');
for i=1:num; 
    % display one object at a time
    WI=zeros(size(fg)); WI(L==i)=1;
    figure(2), imshow(WI); 
    title(['image of object with label ', num2str(i)]), pause(0.5)
    %the net area of object
    area_o(i)=staB(i).Area;
    %actual perimeter of object
    perim(i)=staB(i).Perimeter;
    %major axis of object
    maxis(i)=staB(i).MajorAxisLength;
    %Convex hull area of object
    area_c(i)=staB(i).ConvexArea;
    %boundaing box area of object
    area_b(i)=staB(i).BoundingBox(3)*staB(i).BoundingBox(4);
    %Convex perimeter extracted from convex Image  
    sta_Pem=regionprops(staB(i).ConvexImage,'Perimeter'); 
    Convex_Perimeter(i)=sta_Pem.Perimeter; %Convex perimeter
    form_factor(i)=4.*pi.*area_o(i)./perim(i).^2; %form factor
    roundness(i)=4.*area_o(i)./(pi.*maxis(i));%roundness
    solidity(i)=area_o(i)./area_c(i); %solidity
    extent(i)=area_o(i)./area_b(i); %extent
    compactness(i)=sqrt(4.*area_o(i)./pi)./maxis(i); %compactness
    convexity(i)=Convex_Perimeter(i)./perim(i); %Convexity
end
compactness