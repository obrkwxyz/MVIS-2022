% w6o.m - Perimeter measures
close all, clear all, clc
f=imread('shapes2.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('Original Image'); 
%convex hull and perimeter
sB=regionprops(fg,'ConvexImage','Perimeter');

%perimeter of the original image obtained by bwperim
fg_perim=bwperim(fg,4); 
figure(2), imshow(fg_perim), 
title(['length of perimeter of original object: ', num2str(sB.Perimeter)])

%perimeter of Convex Hull: for 8-connected perimeter, use "4"
con_perim=bwperim(sB.ConvexImage,4);  
%length of perimeter of convexhull
sC=regionprops(sB.ConvexImage,'Perimeter'); % conex Perimeter 

figure(3), imshow(sB.ConvexImage), 
title('Vonvext hull of the object')
figure(4), imshow(con_perim)
title(['length of perimeter of ConvexHull: ', num2str(sC.Perimeter)])

object_perimeter=sB.Perimeter
convexhull_perimeter=sC.Perimeter