%w8i.m polynomial regression (with 3rd order function) 
clear all; close all, clc

%generate a random function to fit 4TH order function.
%Create a nonlinear function to use polynomial regression 
x=-5:0.2:5;
y=-3*x.^3-2*x.^2+7*x+1-9*randn(size(x));
figure(1), scatter(x,y,'r*'),hold on, grid on

%try with linear regression first
y_lrm = fitlm(x,y)
y_conf_int=coefCI(y_lrm)
y_pValue=coefTest(y_lrm)

%y value obtained by linear equation
y_fitted=y_lrm.Fitted; 
plot(x, y_fitted, 'b'), hold off
title(['Scatter plot and fitted line using OLR. R-Square= ',...
    num2str(y_lrm.Rsquared.Ordinary)])

%try with 2nd order polynomial regression
[coeff2, S_err2] = polyfit(x,y,2) 
%generate some different x values 
x_new=min(x)-1:0.2:max(x)+1; 
%obtain the estimated value
[y_hat2, delta2]=polyval(coeff2,x_new,S_err2);

%check whether 50% of predictons inside y_hat+-delta
figure(2), plot(x,y,'k*')
hold on, 
plot(x_new, y_hat2,'r-')
plot(x_new,y_hat2+delta2,'b--',x_new,y_hat2-delta2,'b--')
grid on
title('Plot of Data (Points) and Model (Line) - 2nd order')
legend('Data','Linear Fit','y+-delta','Location','north')
hold off

%try with 3rd order polynomial regression
[coeff3, S_err3] = polyfit(x,y,3) 
%obtain the estimated value
[y_hat3, delta3]=polyval(coeff3,x_new,S_err3);

%check whether 50% of predictons inside y_hat+-delta
figure(3), plot(x,y,'k*')
hold on, 
plot(x_new, y_hat3,'r-')
plot(x_new,y_hat3+delta3,'b--',x_new,y_hat3-delta3,'b--')
grid on
title('Plot of Data (Points) and Model (Line) - 3rd order')
legend('Data','Linear Fit','y+-delta','Location','north')
hold off

