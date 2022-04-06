% w6g.m - Normalised 4 Chain Code or 8 Chian code 
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
%chain codes
W4=chaincode4(W),W8=chaincode8(W)
W4N=normalise(W4), W8N=normalise(W8)
