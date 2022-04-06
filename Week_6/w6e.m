% w6e.m - 4 Chain Code or 8 Chian code 
%you need chaingcode4.m and chaincode 8.m files
clear all, close all, clc
W=[0 0 0 0 0 0 0;
   0 0 1 1 1 0 0;
   0 0 1 0 1 1 0;
   0 0 1 0 0 1 0;
   0 1 1 0 0 1 0;
   0 1 0 0 1 1 0;
   0 1 1 1 1 0 0;
   0 0 0 0 0 0 0];

%chain codes for the example in the lecture sldies
disp('chain codes for the example in the lecture sldies')
W4=chaincode4(W),W8=chaincode8(W)
