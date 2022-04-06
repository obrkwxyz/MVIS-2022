%w6v.m: texture descriptor - How to use it
clear all, close all, clc
I1 = imread('texture_ex1.png');
I2=uint8(ones(size(I1))*150);
I3 = imread('texture_ex2.png');
I4 = imread('texture_ex3.png');

figure(1), 
subplot(2,2,1), imshow(I1), impixelinfo
subplot(2,2,2), imshow(I2), impixelinfo
subplot(2,2,3), imshow(I3), impixelinfo
subplot(2,2,4), imshow(I4), impixelinfo

%[glcm1,SI1] = graycomatrix(I1,'NumLevels',32);
[glcm1,SI1] = graycomatrix(I1);
[glcm2,SI2] = graycomatrix(I2);
[glcm3,SI3] = graycomatrix(I3);
[glcm4,SI4] = graycomatrix(I4);

figure(2), 
subplot(2,2,1), imshow(rescale(SI1)),impixelinfo
subplot(2,2,2), imshow(rescale(SI2)),impixelinfo
subplot(2,2,3), imshow(rescale(SI3)),impixelinfo
subplot(2,2,4), imshow(rescale(SI4)),impixelinfo

stats1 = graycoprops(glcm1);
stats2 = graycoprops(glcm2);
stats3 = graycoprops(glcm3);
stats4 = graycoprops(glcm4);

prop_Contrast=[stats1.Contrast, stats2.Contrast, stats3.Contrast, stats4.Contrast];
prop_Correlation=[stats1.Correlation, stats2.Correlation, stats3.Correlation, stats4.Correlation];
prop_Energy=[stats1.Energy, stats2.Energy, stats3.Energy,  stats4.Energy];
prop_Homogeneity=[stats1.Homogeneity, stats2.Homogeneity, stats3.Homogeneity, stats4.Homogeneity];

disp=('Contrast Correlation Energy Homogeneity')
text_prop=[prop_Contrast;prop_Correlation;prop_Energy;prop_Homogeneity]
