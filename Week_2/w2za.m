%w2za.m logical indexing operation
clear all, close all
A=[1 4 7; 2 5 8; 3 6 9]
D=logical([1 0 0; 0 0 0; 0 1 0])
K=A(D==1)
KK=A(D==0)

B=A 
C=A
A(D==1)=124
C(D==0)=16

B(A==2)=10