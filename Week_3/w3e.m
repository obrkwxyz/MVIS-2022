%w3e.m: Colour Quantisation
clear all
close all
clc

X1= imread('button1.jpg');

figure(1)
    imshow(X1)
    title('256 levels')
    colorbar

[X2,map2] = rgb2ind(X1,32,'nodither');

figure(2)
    imshow(X2,map2)
    title('32 levels')
    colorbar

[X3,map3] = rgb2ind(X1,8,'nodither');

figure(3)
    imshow(X3,map3)
    title('8 levels')
    colorbar

imwrite(X2,map2,'button_L64.bmp','bmp')
imwrite(X3,map3,'button_L32.bmp','bmp')

