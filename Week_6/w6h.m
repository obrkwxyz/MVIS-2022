%w6h.m (Chain Code - Shape number)
%shape number is more robust for the orientation of the object
clear all, close all, clc
% create an L shaped matrix 
L=zeros(5,5);L(2:4,2:3)=1;L(3:4,4)=1
%Rotate 90 degrees for comparison purpose
LR=rot90(L);

%Chain code & normalised chain code: still they are different
disp('- Chain codes: different before and after the rotation')
C=chaincode4(L);CR=chaincode4(LR); [C;CR]
disp('- Normalised chain codes: different before and after the rotation')
C_N=normalise(C); CR_N=normalise(CR); [C_N; CR_N]

%Shape numbers: they are the same
disp('-Shape numbers: the same before and after the rotation')
%we shift left: to find the difference we shift the chain code first
C_shift=circshift(C,[0 -1]); 
%Shape number: find the difference (C(n+1)-C(n)) with mod 4
C_Dif=mod(C_shift-C,4); 
%Then we normalised the results = shape number
ShapeC=normalise(C_Dif);
%After the rotation, we do the same  
CR_shift=circshift(CR,[0 -1]); %shift left
CR_Dif=mod(CR_shift-CR,4); 
ShapeCR=normalise(CR_Dif);
%compare the result = they are the same
[ShapeC; ShapeCR]
