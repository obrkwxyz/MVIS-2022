%w5n.m (Hough transform)-We try to find 5 longest lines
clear all, close all, clc
I  = imread('circuit.tif'); 
rotI = imrotate(I,33,'crop');% rotate image 
figure(1), imshow(rotI); title('original image')
BW = edge(rotI,'canny'); 
figure(2), imshow(BW); title('edge found (Canny detector)')

[H,theta,rho] = hough(BW,'RhoResolution',0.5,'ThetaResolution',0.5);
figure(3), imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
        'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on; 
%will identify "5" lines
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:)))); 
x = theta(P(:,2)); y = rho(P(:,1)); title('The Accumulator Array')
plot(x,y,'linestyle','none','marker','square', 'color','r')
lines = houghlines(BW,theta,rho,P,'FillGap',55,'MinLength',7);

figure(4), imshow(rotI), hold on
title('Identified lines')
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'*','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'*','LineWidth',2,'Color','green');

    %find the longest lines among all lines
    %using Euclidean distance (sqrt(x^2+y^2))
    %norm will calculate Euclidean distance between two points
    %you should subtract the two points 
   len = norm(lines(k).point1- lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

disp(['longest line segment: from (',num2str(xy_long(1,1)), ' ',...
    num2str(xy_long(1,2)), ') to (',num2str(xy_long(2,1)), ' ',...
    num2str(xy_long(2,2)), '), and the length of the line is ', ...
    num2str(max_len) ])
