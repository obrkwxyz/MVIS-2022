% w6n.m - Area measures
close all, clear all, clc
f=imread('shapes2.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('Binary Image');
%find area measures
sB=regionprops(fg,'Area','BoundingBox','ConvexImage',...
    'ConvexHull','ConvexArea')

%coordinate of left top corner on bounding box
x_LT=fix(sB.BoundingBox(1)); y_LT=fix(sB.BoundingBox(2));
%width of bounding box
x_W=sB.BoundingBox(3); y_W=sB.BoundingBox(4);
% Display the bounding box
figure(2), imshow(fg), title('Bounding Box of image')
% top left corner of the bounding box
hold on, plot(x_LT, y_LT,'r*')
% Display the bounding box using line function
line([x_LT, x_LT+x_W,x_LT+x_W,x_LT,x_LT], ...
    [y_LT, y_LT,y_LT+y_W,y_LT+y_W,y_LT], 'color','y');
%display convex hull image
figure(3), imshow(sB.ConvexImage), title('ConvexHull of image')
%display the coordinates of each vertex of polygon
sB.ConvexHull;
%the area of the object
f_area=sB.Area
%the size of bounding box
boundingbox_Area=x_W*y_W
%convex hull area
convexarea=sB.ConvexArea
%the list of vertex of convex hull
convexhull=sB.ConvexHull

