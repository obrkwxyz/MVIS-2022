%w2v.m Laplacian Operator
close all, clear all, clc
NO=imread('lena_g.bmp');

FL1=fspecial('laplacian', 0)
FL2=[1 1 1;1 -8 1;1 1 1]

NH1=imfilter(NO,FL1);
NH2=imfilter(NO,FL2);

figure(1), imshow(NO),title('Original Image')
figure(2), imshow(NH1),impixelinfo
title('Laplacian Operator with fspecial(alpha=0)')
figure(3), imshow(NH2),impixelinfo
title('Laplacian Operator with the centre value=-8')

%Combining the result with the original image
NAA=imsubtract(NO, NH1); NAA1=imsubtract(NO, NH2);
figure(4), imshowpair(NO,NAA1, 'montage')
title('original image combined with Laplacian Operator(alpha=0)')
figure(5), imshowpair(NO,NAA, 'montage')
title('original image combined with Laplacian Operator(centre value =-8)')

