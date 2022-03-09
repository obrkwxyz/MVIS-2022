%w2zb.m logical array 
clear all, close all, clc
a=[1 2 3; 4 5 6; 7 8 9]
b=a>5
c=a; d=a;
% what we want, if the element in matrix a is higher than 5, we apply
% square root and if it is not, we apply square of the element. 
% if we use if/else and foe/end, it will take a long time
for ii=1:size(a,1)
    for jj=1:size(a,2)
        if a(ii,jj)>5
            c(ii,jj) = sqrt(a(ii,jj));
        else
            c(ii,jj) = (a(ii,jj))^2;
        end
    end
end

% if we use "vectorisation", we will have
d(b)=sqrt(a(b));
d(~b)=a(~b).^2;