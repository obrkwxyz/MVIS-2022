%w8c.m linear regression using fitlm
clear all; close all, clc

%given simple example
x=[200, 1000,1550, 900, 1300, 400, 500, 720]';
y=[370, 840, 1080, 750, 910, 395, 495, 680]';

%linear regression analysis - the result is a linear model 
%it is like a tructure datatype. So we use dot notation
yO_lm=fitlm(x,y)

% takeout beta coefficient(slope) and y-intercept for check
yO_coef=yO_lm.Coefficients.Estimate 
yO_beta=yO_lm.Coefficients.Estimate(2); %slope of the line
yO_alpha=yO_lm.Coefficients.Estimate(1); %y-intercept
%%

%asess the model fit!
%R-squared value
yO_orcode=yO_lm.Rsquared.Ordinary; 
yO_adcode=yO_lm.Rsquared.Adjusted; 

%check p-Value (should be less than 0.05)
yO_pValue=coefTest(yO_lm)

%check 95% confidence intervals (should not contain "0")
yO_confi_int=coefCI(yO_lm)

%y value obtained by linear equation
yO_fitted=yO_lm.Fitted; 
%%
%check how the line is well fitted with datapoint
figure(1), scatter(x,y, 'r*'), title('Scatter plot for x and y and fitted line')
axis([0 max(x)+100 0 max(y)+100]), hold on
grid on
plot(x, yO_fitted, 'b'), hold off
%%
%find residual between the actual y and values obtained from teh equation
%the error between real y value and estimated y value
yO_resiO=yO_lm.Residuals; 

%need to change table to array for stem operation
yO_resi=table2array(yO_resiO);
%check residual (we use just "raw" value
figure(2), stem(yO_resi(:,1)), grid on
title(['Residual of fitting equation with y= ', num2str(yO_beta), 'x+', num2str(yO_alpha)])
axis([0 length(y)+1 min(min(yO_resi))-50 max(max(yO_resi))+50]), 
 %%
%check for x=1200
yO_1200=yO_beta*1200+yO_alpha

%Linear regression model plot
figure(3), plot(yO_lm), grid on
title(['Linear regression model y= ', num2str(yO_beta), 'x+', num2str(yO_alpha)])

