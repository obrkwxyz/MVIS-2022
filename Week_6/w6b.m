%w6b.m bwboundaries with brief outputs
close all
clear all
clc

f=imread('numcir.png');

figure(1)
    imshow(f)
    title('original image')
    impixelinfo

FB = imbinarize(f, 100/255); %threshold applied
figure(2)
    imshow(FB)
    title('Binary image')
    impixelinfo

f_boun=bwperim(FB,4);

figure(3)
    imshow(f_boun)
    title('perimeter of objects')
%using bwboundaries. It will find the boundaries of the holes inside 
%the objects as default. If "noholes" is used, then the boundaries
%of the holes inside the objects will not be extracted
%see the difference
B_noholes=bwboundaries(FB,'noholes'),
fz=zeros(size(FB));
figure(4), 
for k1 = 1:length(B_noholes)
    boundary1 = B_noholes{k1};
    imshow(fz,[]),hold on 
    plot(boundary1(:,2), boundary1(:,1), 'c', 'LineWidth', 1)
    title(['The object label with noholes option: ', num2str(k1)])
    pause(0.5), hold off
end

B_holes=bwboundaries(f,'holes'),numel(B_holes)
fz=zeros(size(FB));
figure(5), 
for k2 = 1:length(B_holes)
    boundary2 = B_holes{k2};
    imshow(fz,[]),hold on 
    plot(boundary2(:,2), boundary2(:,1), 'y', 'LineWidth', 1)
    title(['The object label with holes option: ', num2str(k2)])
    pause(0.5), hold off
end

B_holes{1} %display all coordinates of objects with label 1 
B_holes{1}(1,:) %the first row
B_holes{1}(:,1) % entire x coordinates

