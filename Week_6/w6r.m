 % w6r.m - Euler Number for topological description
close all, clear all, clc
f=imread('abcd.bmp'); fg=imbinarize(f, graythresh(f)); 
figure(1), imshow(fg), title('original Image'); 

[L, num]=bwlabel(fg);
%Euler Number 
staB=regionprops(L,'EulerNumber')
for kk=1:num
    EN_rp(kk)=staB(kk).EulerNumber;
    EN_bweuler(kk)=bweuler(L==kk);
    dL=uint8(zeros(size(L))); dL(L==kk)=1; 
    figure(kk+1), imshow(dL,[]),
    title(['Object ', num2str(kk), ' Euler Number: ', num2str(EN_rp(kk))]) 
end
EN_rp