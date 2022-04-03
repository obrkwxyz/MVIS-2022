%w5m.m (Hough transform: find lines using houghlines.m)
close all, clear all, clc
w5l
hlines=houghlines(f, theta, rho, peaks,'MinLength',1);
figure(3), imshow(f), hold on % put the hough lines to the original image

for k = 1:numel(hlines)
    %identify both end points of line segments and draw a line
    x1(k) = hlines(k).point1(1);     y1(k) = hlines(k).point1(2);
    x2(k) = hlines(k).point2(1);     y2(k) = hlines(k).point2(2);
    plot([x1(k) x2(k)],[y1(k) y2(k)],'Color','r','LineWidth', 1)
    impixelinfo
end

%Show the starting point and end points of lines
for k = 1:numel(hlines)
   start_point=[x1(k) y1(k)]
   end_point=[x2(k) y2(k)]
end