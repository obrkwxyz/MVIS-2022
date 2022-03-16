%w3f.m-colour dithering - dither option should be used in rgb2ind
w3e;

clc

[X4_d,map4] = rgb2ind(X1,8,'dither');

figure(4)
subplot(1,2,1)
    imshow(X3,map3)
    title('8 levels-nodithering')
subplot(1,2,2)
    imshow(X4_d,map4)
    title('8 levels-dithering')
