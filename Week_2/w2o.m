%w2o.m (linear smoothing filters) - Averaging and weighted averaging filters 
close all, clear all 
W=imread('lena_g.bmp'); % read the original image
WN=imnoise(W,'salt & pepper', 0.05); %Add salt & pepper type noise
%creating two box filters
F_box1=fspecial('average',[3,3]); % create 3x3 box filter
F_box2=fspecial('average',[9,9]); % create 9x9 box filter
disp('3x3 box filter'), F_box1
disp('9x9 box filter'), F_box2
WF_box1=imfilter(WN,F_box1,'replicate'); %apply the box filter
WF_box2=imfilter(WN,F_box2,'replicate'); 
 
%creating weighted averaing filter 
F_wbox1=ones(3,3); F_wbox1(2,2)=4; 
F_wbox1=F_wbox1/sum(sum(F_wbox1)); %weighted averaging filter
 
F_wbox2=ones(9,9); F_wbox2(2:8,2:8)=2; F_wbox2(3:7,3:7)=4;
F_wbox2(4:6,4:6)=8; F_wbox2(5,5)=16;
F_wbox2=F_wbox2/sum(sum(F_wbox2)); %weighted averaging filter
disp('3x3 weighted averaging filter'), F_wbox1
disp('9x9 weighted averaging filter'), F_wbox2
 
WF_wbox1=imfilter(WN,F_wbox1,'replicate'); 
WF_wbox2=imfilter(WN,F_wbox2,'replicate'); 
 
figure(1), imshow(WN), title('original with salt & pepper noise')
figure(2), 
subplot(2,2,1), imshow(WF_box1), title('3x3 box filter')
subplot(2,2,2),imshow(WF_box2),title('9x9 box filter')
subplot(2,2,3),imshow(WF_wbox1),title('3x3 weighted averaging filter')
subplot(2,2,4),imshow(WF_wbox2),title('9x9 weighted averaging filter')



