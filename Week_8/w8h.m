%w8h.m polynomial regression (with 2nd order function) 
clear all; close all, clc

%generate a random function to fit 4TH order function.
%Create a nonlinear function to use polynomial regression 
x=-5:0.2:5;
%y=5*x.^4-3*x.^3-2*x.^2+7*x+1-5*randn(size(x));
y=-2*x.^2+7*x+1-5*randn(size(x));
figure(1), scatter(x,y,'r*'),hold on, grid on

%try with linear regression first
y_lm = fitlm(x,y)

%y value obtained by linear equation
yL_hat=y_lm.Fitted; 
plot(x, yL_hat, 'b'), hold off
title(['Scatter plot and fitted line using OLR. R-Square= ',...
    num2str(y_lm.Rsquared.Ordinary)])
%%
%try with 2nd order polynomial regression
[coeff, S_err] = polyfit(x,y,2) 
%generate some different x values 
x_new=min(x)-1:0.2:max(x)+1; 
%obtain the estimated value
[y_hat, delta]=polyval(coeff,x_new,S_err);

%check whether 50% of predictons inside y_hat+-delta
figure(2), plot(x,y,'k*')
hold on, 
plot(x_new, y_hat,'r-')
plot(x_new,y_hat+delta,'b--',x_new,y_hat-delta,'b--')
grid on
title('Plot of Data (Points) and Model (Line) - 2nd order')
legend('Data','Linear Fit','y+-delta','Location','south')
hold off
