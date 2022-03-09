%w2q.m (linear smoothing filters) - gausiian filters
W=imread('lena_g.bmp'); % read the original image
WN=imnoise(W,'salt & pepper', 0.02); %Add salt & pepper type noise

%Gaussian filters
% in imgaufilt: The default value of sigma=0.5 
% the default size = 2*ceil(2*sigma)+1. 
% So if we use the default s=0.5, the default size will be 3x3
% can change the size using 'FilterSize',n

WF_gau1=imgaussfilt(WN); %s=0.5 size=3x3
WF_gau2=imgaussfilt(WN,3); %s=3 size=13x13
WF_gau3=imgaussfilt(WN,0.5,'FilterSize',9); %9x9 with s=0.5
WF_gau4=imgaussfilt(WN,3,'FilterSize',9); %9x9 with s=3

figure(1), 
subplot(2,2,1),imshow(WF_gau1),title('3x3 Gaussian filter s=0.5')
subplot(2,2,2),imshow(WF_gau2),title('13x13 Gaussian filter s=3')
subplot(2,2,3),imshow(WF_gau3),title('9x9 Gaussian filter s=0.5')
subplot(2,2,4),imshow(WF_gau4),title('9x9 Gaussian filter s=3')
