function [E_num] = label_convert(SVMlabel)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
E_num=nan(size(SVMlabel));
E_num(strcmp(SVMlabel, 'Small'))=3;
E_num(strcmp(SVMlabel, 'Medium'))=2;
E_num(strcmp(SVMlabel, 'Large'))=1;
end

