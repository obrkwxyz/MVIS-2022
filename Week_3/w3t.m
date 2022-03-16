%w3p.m Interpolation: three methods 
close all,clear all, clc
X=[1 2;2 4]
XN=imresize(X,2,'nearest')
XL=imresize(X,2,'bilinear')
XC=imresize(X,2,'bicubic')

