%w4yb.m Alternating sequential filtering 
clear all,close all, clc
C=imread('lena_g.bmp');
figure(1), imshow(C),title('Original')
SE1=strel('diamond',5);
 
CC=imclose(C,SE1); CCO=imopen(CC,SE1);
CO=imopen(C,SE1); COC=imclose(CO,SE1);

C_ASC=C;
for k =1:4
     SE2 =strel('diamond',k);
     SE2.Neighborhood
     C_ASC = imclose(imopen(C_ASC,SE2),SE2);
     figure(k), imshow(C_ASC); 
     title(['Alternating sequential filtering with size ', num2str(k)])
end
 
figure(k+1), 
subplot(2,2,1), imshow(C), title('Original Image')
subplot(2,2,2), imshow(CCO),title('Close - Open')
subplot(2,2,3), imshow(COC),title('Open - Close')
subplot(2,2,4), imshow(C_ASC),title('Alternating sequential filtering')
   