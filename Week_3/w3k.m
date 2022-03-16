%w3k.m Detect red colour flower - using colour component threshold
close all
clear all
clc

F=imread('flower2.jpg');

%RGB colour components
FR=F(:,:,1);
FG=F(:,:,2);
FB=F(:,:,3);

figure(1)
    imshow(F)
    title('original')
    impixelinfo

figure(2)
subplot(2,2,1)
    imshow(F)
    title('original')
    impixelinfo
subplot(2,2,2)
    imshow(FR)
    title('Red component')
    impixelinfo
subplot(2,2,3)
    imshow(FG)
    title('Green component')
    impixelinfo
subplot(2,2,4)
    imshow(FB)
    title('Blue component')
    impixelinfo
% threshold applied to red colour component
FRT = (FR>90 & FR<160); %threshold for R

%threshold applied to green colour component
FGT=(FG<20); %threshold for G

figure(3)
subplot(1,2,1)
    imshow(FRT)
    title('Threshold for R>90 & R<160 in RGB model')
subplot(1,2,2)
    imshow(FGT)
    title('Threshold for G<20 in RGB model')

%Normalised RGB Model (rgb)
Sum=double(FR)+double(FG)+double(FB)+0.00001; %find the elements 

% sum normalisation process
for i=1:3
    NF(:,:,i) = double(F(:,:,i))./ Sum;
end
NFR = NF(:,:,1);
NFG = NF(:,:,2);
NFB = NF(:,:,3);

figure(4)
subplot(2,2,1)
    imshow(NF)
    title('original-normalised')
    impixelinfo
subplot(2,2,2)
    imshow(NFR)
    title('intensity level of r in rgb model')
    impixelinfo
subplot(2,2,3)
    imshow(NFG)
    title('intensity level of g in rgb model')
    impixelinfo
subplot(2,2,4)
    imshow(NFB)
    title('intensity level of b in rgb model')
    impixelinfo

NFRT = NFR>0.75; %threshold using r component

figure(5)
    imshow(NFRT);
    title('Threshold for r>0.75 in rgb model')

%HSV model
HF=rgb2hsv(F);
HFH=HF(:,:,1);
HFS=HF(:,:,2);
HFV=HF(:,:,3);

figure(6)
subplot(2,2,1)
    imshow(HF)
    title('original-HSV model')
    impixelinfo
subplot(2,2,2)
    imshow(HFH)
    title('intensity level of H')
    impixelinfo
subplot(2,2,3)
    imshow(HFS)
    title('intensity level of S')
    impixelinfo
subplot(2,2,4)
    imshow(HFV)
    title('intensity level of V')
    impixelinfo

HFHT = (HFH<0.05|HFH>0.95); % threshold using H component HFH less than 0.5 OR HFH greater than 0.95

figure(7)
    imshow(HFHT);
    title('Threshold for H>0.95 or H<0.05 in HSV')


cform = makecform('srgb2lab'); % Lab colour transformation structure 
F_Lab = applycform(F,cform); % Apply it to the image
FL = F_Lab(:,:,1);
Fa = F_Lab(:,:,2);
Fb = F_Lab(:,:,3);

figure(8) 
subplot(2,2,1)
    imshow(F_Lab)
    title('original-Lab model')
    impixelinfo
subplot(2,2,2)
    imshow(FL)
    title('intensity level of L')
    impixelinfo
subplot(2,2,3)
    imshow(Fa)
    title('intensity level of a')
    impixelinfo
subplot(2,2,4)
    imshow(Fb)
    title('intensity level of b')
    impixelinfo

%threshold using a component
LFAT = Fa>160;
figure(9)
    imshow(LFAT);
    title('Threshold for a>160 in Lab model')
