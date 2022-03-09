%w2p.m (linear smoothing filters) - binominal filters
W=imread('lena_g.bmp'); % read the original image
WN=imnoise(W,'salt & pepper', 0.02); %Add salt & pepper type noise

aa=[1 2 1]; bb=(aa'*aa);F_bino1=bb/sum(sum(bb)); % 3x3 binomial filter
cc=[1 2 4 8 16 8 4 2 1]; dd=(cc'*cc);F_bino2=dd/sum(sum(dd));% 5x5 binomial filter
disp('3x3 Binomial filter'), F_bino1, 
disp('9x9 Binomial filter'), F_bino2
 
WF_bino1=imfilter(WN,F_bino1,'replicate'); 
WF_bino2=imfilter(WN,F_bino2,'replicate'); 
figure(3), 
subplot(2,2,1), imshow(WF_box1), title('3x3 Box filter')
subplot(2,2,2),imshow(WF_box2),title('9x9 Box filter')
subplot(2,2,3),imshow(WF_bino1),title('3x3 binomial filter')
subplot(2,2,4),imshow(WF_bino2),title('9x9 binomial filter')

