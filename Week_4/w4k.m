%w4k.m Number of different size circles using Image Erosion/image
%reconstruction
close all, clear all
TO=imread('circles_colour.bmp'); 
figure(1), imshow(TO), title('Original image') 

T=rgb2gray(TO)>30;
[L,num_0]=bwlabel(T); % The number of all circles
%the numebr of all circles
figure(2), imshow(T), 
title(['The number of all circles is ', num2str(num_0)])

B=strel('diamond',5); 
%Count the smallest circles to find the number of them  
TE1=imerode(T,B); TE1R=imreconstruct(TE1,T); 

%Take the difference between the two = smallest circles only
circle1=T&~TE1R; [LN1,num_N1]=bwlabel(circle1); [L1,num_1]=bwlabel(circle1);
figure(3), 
subplot(2,1,1), imshow(T), title('original image')
subplot(2,1,2), imshow(circle1),
title(['reconstructed image: number of smallest circles: ', num2str(num_N1)])

%Count the next smallest circles 
TE2=imerode(TE1,B); TE2R=imreconstruct(TE2,TE1R); 

%logical operation with the original image to find 2nd smalles circles
circle2=TE1R&~TE2R; [LN2,num_N2]=bwlabel(circle2);
figure(4), 
subplot(2,1,1), imshow(TE1R), title('eroded image')
subplot(2,1,2), imshow(circle2),
title(['reconstructed image: number of 2nd smallest circles: ', num2str(num_N2)])

%Count The middle size circles
TE3=imerode(TE2,B); TE3R=imreconstruct(TE3,TE2R);
 
%logical operation with the original image to find middle sized circles
circle3=TE2R&~TE3R; [LN3,num_N3]=bwlabel(circle3);
figure(5), 
subplot(2,1,1), imshow(TE2R), title('eroded image')
subplot(2,1,2), imshow(circle3),
title(['reconstructed image: number of middle sized circles: ', num2str(num_N3)])

%Count The second largest circles
TE4=imerode(TE3,B); TE4R=imreconstruct(TE4,TE3R); 

%logical operation with the original image to find 2nd largest circles
circle4=TE3R&~TE4R; [LN4,num_N4]=bwlabel(circle4);
figure(5), 
subplot(2,1,1), imshow(TE3R), title('eroded image')
subplot(2,1,2), imshow(circle4),
title(['reconstructed image: number of 2nd largest circles: ', num2str(num_N4)])

%Count the largest cuircle
[LN5,num_N5]=bwlabel(TE4R);
figure(6), imshow(TE4R)
title(['reconstructed image: number of largest circles: ', num2str(num_N5)])

