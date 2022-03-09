%w2r.m (non-linear smoothing filters)- compare with bos filters
close all, clear all 
W=imread('lena_g.bmp'); % read the original image
WN=imnoise(W,'salt & pepper', 0.05); %Add salt & pepper type noise

%Box filters
F_box1=fspecial('average',[3,3]); % create 3x3 box filter
disp('3x3 box filter'), F_box1
WF_box1=imfilter(WN,F_box1,'replicate'); 

% maximum filter (last one in the order) 
WF_max=ordfilt2(WN,9,ones(3,3)); 
%minimum filter (first one in the order) 
WF_min=ordfilt2(WN,1,ones(3,3)); 
%median filter(middle one in the order) 
WF_med2=ordfilt2(WN,5,ones(3,3)); 
%median filter using medfilt2
WF_med1=medfilt2(WN,[3 3]); 

figure(1), imshow(WN), title('original with salt and pepper noise')
figure(2), 
subplot(2,2,1),imshow(WN), title('original with salt and pepper noise')
subplot(2,2,2),imshow(WF_box1), title('3x3 Box filter')
subplot(2,2,3),imshow(WF_med1),title('median filter using medfilt2')
subplot(2,2,4),imshow(WF_med2),title('median filter using ordfilt2')
figure(3) 
subplot(1,2,1),imshow(WF_min),title('Min filter using ordfilt2')
subplot(1,2,2),imshow(WF_max),title('Max filter using ordfilt2')

