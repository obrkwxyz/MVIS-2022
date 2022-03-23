%w4c.m Image Dilation/Erosion: Dual relation
close all
clear all
clc

T=imread('blob_bw.bmp');

% dilation is applied to the original image
SE = strel('square',9); 

%dilation --> complement
td=imdilate(T,SE);
tde=imerode(td,SE); 
tdc=imcomplement(td);

%complement --> erosion 
tc=imcomplement(T);
tce=imerode(tc,SE);
te=imerode(T,SE);
ted=imdilate(te,SE);

figure(1)
    imshow(T)
    title('Original') 
    pause(1/10)

figure(2)
subplot(2,2,1)
    imshow(td)
    title('dilation')
subplot(2,2,2)
    imshow(tde)
    title('dialtion --> erosion: no inverse')
subplot(2,2,3)
    imshow(te)
    title('erosion')
subplot(2,2,4)
    imshow(ted)
    title('erosion --> dilation: no inverse')
    pause(1/10)

figure(3)
subplot(2,2,1)
    imshow(td)
    title('dilation')
subplot(2,2,2)
    imshow(tdc)
    title('dialtion --> complement')
subplot(2,2,3)
    imshow(tc)
    title('complement')
subplot(2,2,4)
    imshow(tce)
    title('complement --> erosion: Dual relation')
    pause(1/10)
