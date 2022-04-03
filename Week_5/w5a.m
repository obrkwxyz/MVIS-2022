%w5a.m (Line detection) 
clear all, close all, clc
GO=imread('ic_con.jpg');
%apply a threhold
G=GO>50; 
figure(1), imshow(G), title('Original Image')

%line detection filters
B1=[-1 -1 -1;2 2 2;-1 -1 -1]; %horisontal line 
B2=[-1 2 -1;-1 2 -1;-1 2 -1]; %vertical line 

B3=[-1 -1 2;-1 2 -1;2 -1 -1]; %+45 degree line 
B4=[2 -1 -1;-1 2 -1;-1 -1 2]; %-45 degree line 

%Alternative 45 degree line detection filters
B5=[-2 -1 0;-1 0 1;0 1 2];
B6=[0 1 2;-1 0 1;-2 -1 0];

%applying filters to detect lines
GB1=imfilter(G,B1,'replicate'); GB2=imfilter(G,B2,'replicate'); 
AG1=GB1|GB2; %combine the results together
figure(2), 
subplot(1,2,1), imshow(GB1),title('Horisontal Line')
subplot(1,2,2), imshow(GB2),title('Vertical Line')

GB3=imfilter(G,B3,'replicate'); GB4=imfilter(G,B4,'replicate'); 
AG2=GB3|GB4; %combine the results together
figure(3), 
subplot(1,2,1), imshow(GB3),title('+45 degrees')
subplot(1,2,2),  imshow(GB4),title('-45 degrees')

%apply 45 degree filters
SB1=imfilter(G,B5,'replicate'); SB2=imfilter(G,B6,'replicate');
SB=SB1|SB2;
figure(4), 
subplot(1,2,1), imshow(SB1),title('45 degree')
subplot(1,2,2), imshow(SB2), title('-45 degrees')

figure(5), 
subplot(1,2,1), imshow(AG2),title('Horizontal + vetical Combined')
subplot(1,2,2), imshow(SB), title('45 degree filtered images combined')