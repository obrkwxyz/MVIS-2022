% Class exercise 11 chicken weight estimation using neural network
clear all, close all, clc
%Read the chicken image processing results for processing 
T=readtable('ce11_prac.xlsx', 'Sheet','chicken');

% for plotmatrix, we need to remove "sample no column"
T_New=table(T.Perimeter, T.Area, T.MajorAxis, T.MinorAxis, T.Weight, ...
    'VariableNames',{'Perimeter','Area','MajorAxis','MinorAxis','Weight'});
% need to convert the table to array for scatter plot
T_New=table2array(T_New);

%inputs and out puts should be row vector not column vector
inputs_O=T_New(:,1:4); targets_O=T_New(:,5); 
%inputs=normalize(inputs_O);
inputs=inputs_O'; targets=targets_O';


