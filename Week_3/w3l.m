%w3l.m Detect red colour flower - using colour indices thresholding
close all
clear all
clc

F=imread('flower2.jpg');

figure(1)
    imshow(F)
    title('original') 

FR=F(:,:,1);
FG=F(:,:,2);
FB=F(:,:,3);

%Normalised RGB Model (rgb)
Sum= double(FR) + double(FG) + double(FB) + 0.00001; %find the elements sum

% normalisation process
for i=1:3
    NF(:,:,i) = double(F(:,:,i))./Sum;
end
NFR = NF(:,:,1);
NFG=NF(:,:,2);
NFB=NF(:,:,3);

%DGRI(r-g) threholding
RminG = imsubtract(NFR,NFG); 
RminGT = RminG>0.5;

figure(2)
    imshow(RminG)
    title('Intensity of DGRI: r-g')
    impixelinfo

figure(3)
    imshow(RminGT)
    title('Threshold DGRI: (r-g >0.5)') 
%%
%Normalised difference index (NDI): (r-g)/(r+g)
NDI = imsubtract(NFR,NFG)./(imadd(NFR,NFG)+0.00001);
NDI_T = NDI>0.5;
figure(4), imshow(NDI), title('Intensity of NDI: (r-g)/(r+g)'),impixelinfo
figure(5), imshow(NDI_T), title('Threshold NDI: (r-g)/(r+g) > 0.5') 
%%
%Excessive Green Index (EGI): 2g-r-b
EGI=imsubtract(immultiply(NFG,2),(imadd(NFR,NFB)));
EGI_T=EGI<0;
figure(6), imshow(EGI), title('Intensity of EGI: 2g-r-b'),impixelinfo
figure(7), imshow(EGI_T), title('Threshold EGI: (2g-r-b) < 0') 

%%
%Modified excessive index (MEI): (2r-g-b)
MEI=imsubtract(immultiply(NFR,2),(imadd(NFG,NFB)));
MEI_T=MEI>1.1;
figure(8), imshow(MEI), title('Intensity of MEI: 2r-g-b'),impixelinfo
figure(9), imshow(MEI_T), title('Threshold MEI: (2r-g-b) > 1.1') 

