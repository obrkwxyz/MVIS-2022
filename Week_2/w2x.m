%w2x.m  High boost filtering
close all, clear all
N=imread('lena_g.bmp');
%filter with k>1
k=2
F_ori=[0 0 0; 0 1 0; 0 0 0]; F_avg1=fspecial('average', 3);  
F_dif=F_ori-F_avg1; % this is the unsharp masking filter
N_mask=imfilter(N,F_dif); %Apply the unsharp masking filter to the image 
N_unsharp=imlincomb(1, N, 1, N_mask); 
N_highboost=imlincomb(1, N, k, N_mask); 

figure(1), imshow(N), title('original image')
figure(2), imshow(N_unsharp), title('UnSharp Masking image')
figure(3), imshow(N_highboost), title('high-Boost filtering image')
