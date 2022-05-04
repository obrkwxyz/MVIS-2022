%w8f.m linear regression using fitlm (outlier excluded 
% and robust regression) with real data
clear all; close all, clc

%Read the chicken image processing results for processing 
TS=readtable('table_pracm.xlsx', 'Sheet','chi_sml');
%TS=readtable('table_prac.xlsx', 'Sheet','chicken');
TS_M=table2array(TS);

chi_area=TS_M(:,3); chi_wei=TS_M(:,6);
%scatter plot between area and weight (between two avriables)
figure(1), scatter(chi_area, chi_wei,"."), 
title('scatter plot between area and weight')
x=chi_area; y=chi_wei;

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

%y value obtained by linear equation
yO_fitted=yO_lm.Fitted; 

%check how the line is well fitted with datapoint
figure(1), scatter(x,y, 'r*'), 
title('Scatter plot for x and y and fitted line with OLSR')
axis([min(x)-2000 max(x)+100 min(y)-100 max(y)+100]), hold on
grid on
plot(x, yO_fitted, 'b'), hold off

%Linear regression model plot
figure(2), plot(yO_lm), grid on
title('Linear regression model with OLSR')

%find residual between the actual y and values obtained from teh equation
%the error between real y value and estimated y value
yO_resiO=yO_lm.Residuals; 

%need to change table to array for stem operation
yO_resi=table2array(yO_resiO);
%check residual (we use just "raw" value
figure(3), stem(yO_resi(:,1)), grid on
title(['Residual (OLSR) of fitting equation with y= ', ...
    num2str(yO_lm.Coefficients.Estimate(2)), 'x+', ...
    num2str(yO_lm.Coefficients.Estimate(1))])
axis([0 length(y)+1 min(min(yO_resi))-50 max(max(yO_resi))+50]), 

%Check the amount of residual using plotresiduals
%plot the histogram of residuals
figure(4), plotResiduals(yO_lm), 
grid on,title('histogram of Residual of fitting equation (OLSR)')

figure(5), plotResiduals(yO_lm, 'fitted'), 
grid on, title('scatter plot of Residual of fitting equation (OLSR)')

%plot the probability of residuals
figure(6), plotResiduals(yO_lm,'probability'), grid on
title(['Probabiliry of residuals (OLSR) with Ordinary LR: R-square= ',...
    num2str(yO_lm.Rsquared.Ordinary)])

%%
%====== with Robust regression============
%linear regression analysis with robust regression
yR_lm=fitlm(x,y, 'RobustOpts', 'on')

%find residual between the actual y and values obtained from teh equation
%the error between real y value and estimated y value
yR_resiO=yR_lm.Residuals; 

%weight applied to data set
yR_weights=yR_lm.Robust.Weights;

%check 95% confidence intervals (should not contain "0")
yR_confi_int=coefCI(yR_lm)

%need to change table to array for stem operation
yR_resi=table2array(yR_resiO);
%check residual (we use just "raw" value
figure(7), stem(yR_resi(:,1)), grid on,
title('Residual of robust least square regression (WLSR)')

%plot the probability of residuals with reboust regression
figure(8), 
subplot(1,2,1), plotResiduals(yO_lm,'probability'), grid on
title('Probabiliry of residuals with OLSR')
subplot(1,2,2), plotResiduals(yR_lm,'probability'), grid on
title('Probabiliry of residuals with WLSR')

%%
%====== with Robust regression and outliers excluded ============
%find outliers with the threshold value of 200
y_outs=find(yO_resiO.Raw>200 | yO_resiO.Raw<-200)

%linear regression analysis with exclusion 
%of outliers and reboust regression
yRE_lm=fitlm(x,y, 'RobustOpts', 'on', 'Exclude', y_outs)

%residual
yRE_resiO=yRE_lm.Residuals;
yRE_resi=table2array(yRE_resiO);

%check 95% confidence intervals (should not contain "0")
yRE_confi_int=coefCI(yRE_lm)

%plot the probability of residuals with reboust regression and exclude
%outliers
figure(9), plotResiduals(yRE_lm,'probability'), grid on
title(['Residuals with outliers removed and robust LR: R-square= ',...
    num2str(yRE_lm.Rsquared.Ordinary)])

%compare the amount of residuals
[yO_resi(:,1), yR_resi(:,1), yRE_resi(:,1)]