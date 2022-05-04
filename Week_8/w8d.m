%w8d.m linear regression using fitlm with outlier excluded
clear all; close all, clc

%add some abnormal points to the example 
x=[200, 1000,1550, 900, 1300, 400, 500, 720, 600, 1100]';
y=[370, 840, 1080, 450, 910, 395, 495, 680, 820, 520]';

%linear regression analysis - the result is a linear model 
%it is like a tructure datatype. So we use dot notation
yO_lm=fitlm(x,y)

%asess the model fit!
%R-squared value
yO_orcode=yO_lm.Rsquared.Ordinary; 

%check p-Value (should dbe less than 0.05)
yO_pValue=coefTest(yO_lm)

%check 95% confidence intervals (should not contain "0")
yO_confi_int=coefCI(yO_lm)
%%
%y value obtained by linear equation
yO_fitted=yO_lm.Fitted; 

%check how the line is well fitted with datapoint
figure(1), scatter(x,y, 'r*'), title('Scatter plot for x and y and fitted line')
axis([0 max(x)+100 0 max(y)+100]), hold on
grid on
plot(x, yO_fitted, 'b'), hold off

%Linear regression model plot
figure(2), plot(yO_lm), grid on
title('Linear regression model with outliers')

%find residual between the actual y and values obtained from teh equation
%the error between real y value and estimated y value
yO_resiO=yO_lm.Residuals 

%need to change table to array for stem operation
yO_resi=table2array(yO_resiO);
%check residual (we use just "raw" value
figure(3), stem(yO_resi(:,1)), grid on
title(['Residual of fitting equation with y= ', ...
    num2str(yO_lm.Coefficients.Estimate(2)), 'x+', ...
    num2str(yO_lm.Coefficients.Estimate(1))])
axis([0 length(y)+1 min(min(yO_resi))-50 max(max(yO_resi))+50]), 
%%
%Check the amount of residual using plotresiduals
%plot the histogram of residuals
figure(4), plotResiduals(yO_lm), 
grid on,title('histogram of Residual of fitting equation')

figure(5), plotResiduals(yO_lm, 'fitted'), 
grid on, title('scatter plot of Residual of fitting equation')
%%
%plot the probability of residuals
figure(6), plotResiduals(yO_lm,'probability'), grid on
title(['Probabiliry of residuals with Ordinary LR: R-square= ',...
    num2str(yO_lm.Rsquared.Ordinary)])
%%
%find outliers with the threshold value of 200
yO_outs=find(yO_resiO.Raw>200 | yO_resiO.Raw<-200)

%New linear regression mode with outliers excluded 
yE_lm=fitlm(x,y, 'Exclude', yO_outs)

%check p-Value (should dbe less than 0.05)
yE_pValue=coefTest(yE_lm)

%check 95% confidence intervals (should not contain "0")
yE_confi_int=coefCI(yE_lm)

%New Linear regression model plot
figure(7), plot(yE_lm), grid on
title('Linear regression model with outliers')

%residula plot
figure(8), plotResiduals(yE_lm, 'fitted'), 
grid on, title('scatter plot of Residual of fitting equation')
