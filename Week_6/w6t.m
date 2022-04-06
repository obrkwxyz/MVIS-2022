%w6t.m: texture descriptor - co-occurance matrix
%https://au.mathworks.com/help/images/texture-analysis-1.html
clc, clear all, close all
A=[1 1 5 6 8;2 3 5 7 1;4 5 7 1 2;8 5 1 2 5];
AI=uint8(A)
%Grey level co-occurrence matrix with offset [0 1] - 0 degree
[glcm_0,SI1] = graycomatrix(AI,'Offset',[0 1],'NumLevels',8,'GrayLimits',[]);
glcm_0
stats_0 = graycoprops(glcm_0)

%Grey level co-occurrence matrix with offset [-1 1] - 45 degree
[glcm_45,SI1] = graycomatrix(AI,'Offset',[-1 1],'NumLevels',8,'GrayLimits',[]);
glcm_45
stats_45 = graycoprops(glcm_45)

%Grey level co-occurrence matrix with offset [-1 0] - 90 degree
[glcm_90,SI1] = graycomatrix(AI,'Offset',[-1 0],'NumLevels',8,'GrayLimits',[]);
glcm_90
stats_90 = graycoprops(glcm_90)

%Grey level co-occurrence matrix with offset [-1 -1] - 135 degree
[glcm_135,SI1] = graycomatrix(AI,'Offset',[-1 -1],'NumLevels',8,'GrayLimits',[]);
glcm_135
stats_135 = graycoprops(glcm_135)
