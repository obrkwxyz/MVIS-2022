%w8g.m multiple linear regression - with real data
clear all; close all, clc

%Read the chicken image processing results for processing 
T=readtable('table_pracm.xlsx', 'Sheet','chi_multi');

%generate a random number
T_rand=rand(size(T.Perimeter))*500+200;

% for plotmatrix, we need to remove "sample no column"
T_new=table(T.Perimeter, T.Area, T.MinorAxis, T_rand, T.Weight, ...
    'VariableNames',{'Perimeter', 'Area', 'MinorAxis', ...
    'Rand_num', 'Weight'});

% need to convert the table to array for scatter plot
TM=table2array(T_new);
T_per=TM(:,1); T_area=TM(:,2);
T_miax=TM(:,3); T_ran=TM(:,4); T_wei=TM(:,5);

%plotmatrix - scatter plot between each variable (need to check 4th row)
figure(1), plotmatrix(TM, 'r*'), 
title('scatter plot perimeter, area, minor axis and weight')

%Check the correlation coefficients aomg all independent variabbles
% and depedent variables
coef=corrcoef(TM)

% we can use scatter plot between each variable againt weight
figure(2), scatter(T_per, T_wei, 'r*'), grid on
title('scatter plot: Perimeter & Weight')
figure(3), scatter(T_area, T_wei, 'r*'), grid on
title('scatter plot: Area & Weight')
figure(4), scatter(T_miax, T_wei, 'r*'), grid on
title('scatter plot: MinorAxis & Weight')
figure(5), scatter(T_ran, T_wei, 'r*'), grid on
title('scatter plot: Random Number & Weight')
%%
% ordinary Linear regression with perimeter and MinorAxis
TPM_lm = fitlm(T_new,'Weight~Perimeter+MinorAxis')
TPM_conf_int=coefCI(TPM_lm)
TPM_pValue=coefTest(TPM_lm)
%% 
% ordinary Linear regression 
TPAM_lm = fitlm(T_new,'Weight~Perimeter+Area+MinorAxis')
TPAM_conf_int=coefCI(TPAM_lm)
TPAM_pValue=coefTest(TPAM_lm)
%%
 % ordinary Linear regression 
TPMR_lm = fitlm(T_new,'Weight~Perimeter+MinorAxis+Rand_num')
TPMR_conf_int=coefCI(TPMR_lm)
TPMR_pValue=coefTest(TPMR_lm)
%%
%find residual between the actual y and values obtained from the equation
TPAM_resO=TPM_lm.Residuals; 
%need to change table to array for stem operation
TPAM_res=table2array(TPAM_resO);
figure(6), stem(TPAM_res(:,1)), 
title('residuals - perimeter, Area and minoraxis')

%plot the histogram of residuals
figure(7), plotResiduals(TPM_lm), grid on
title('histogram of Residual of fitting equation')

%plot the probability of residuals
figure(8), plotResiduals(TPM_lm,'probability'), grid on
title(['Probabiliry of residuals with OLSR: R-square= ',...
    num2str(TPM_lm.Rsquared.Ordinary)])
%%
%===== OLSR + Outlier removed ============
%From the plot, we can see that there are a few
% outliers less than -200 and higher than 200. 
TPAM_outs=find(TPAM_resO.Raw<-200 | TPAM_resO.Raw>200)
%linear regression analysis with exclusion of outliers 
TPAM_lmE = fitlm(T,'Weight~Perimeter+Area+MinorAxis','Exclude', TPAM_outs)

%plot the probability of residuals
figure(9), plotResiduals(TPAM_lmE,'probability'), grid on
title(['Probabiliry of residuals with OLSR + outliers removed: R-square= ',...
    num2str(TPAM_lmE.Rsquared.Ordinary)])
%%
%=====WLSR (robust) regression ============
TPAM_lmR = fitlm(T,'Weight~Perimeter+Area+MinorAxis','RobustOpts','on')
%plot the probability of residuals with reboust regression
figure(10), plotResiduals(TPAM_lmR,'probability')
title(['Probabiliry of residuals with WLSR: R-square= ',...
    num2str(TPAM_lmR.Rsquared.Ordinary)])

%%
%=====WLSR (robust) regression + Outlier removed ============
%linear regression analysis with exclusion of outliers and 
% robust regression
TPAM_lmRE = fitlm(T,'Weight~Perimeter+Area+MinorAxis',...
    'RobustOpts','on','Exclude', TPAM_outs)

TPAM_conf_intRE=coefCI(TPAM_lmRE)
TPAM_pValueRE=coefTest(TPAM_lmRE)


%plot the probability of residuals with reboust regression
figure(11), plotResiduals(TPAM_lmRE,'probability')
title(['Probabiliry of residuals with WLSR + outliers removed: R-square= ', ...
    num2str(TPAM_lmRE.Rsquared.Ordinary)])
