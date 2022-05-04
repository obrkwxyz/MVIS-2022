
%% Kane O'Brien obrkw001
% Week 8 class exercise
% 05/05/22

clc
clear all
close all
warning('off','all')

%% Part 1
fprintf("----------------------------------------------\n")
fprintf("---------Non-Robust Linear Equation-----------\n")
fprintf("----------------------------------------------\n")
ver = 1  ;

switch ver
    case 1
        ss= "chicken1";
    otherwise
        ss= "chicken2";
end

T = readtable("ce8_prac.xlsx", 'sheet',ss);

T_new = table(T.Perimeter, T.Area, T.MajorAxis, T.MinorAxis, T.Weight, ...
    'VariableNames',{'Perimeter', 'Area','MajorAxis', 'MinorAxis', 'Weight' });


%Factor 8:2;
chick_data = table2array(T_new);
l=length(chick_data)*0.8;

T_train = T_new(1:l,:); %% Tables for mlrm
T_test  = T_new(l+1:end,:);

chick_training = chick_data(1:l,:); %% Arrays for slrm
chick_test = chick_data(l+1:end,:);


% plot scatters v. Weight; all data
figure(1)
    scatter(chick_data(:,1),chick_data(:,5))
    title("Chicken Perimeter vs. Weight scatter")
figure(2)
    scatter(chick_data(:,2),chick_data(:,5))
    title("Chicken Area vs. Weight scatter")
figure(3)
    scatter(chick_data(:,3),chick_data(:,5))
    title("Chicken Major Axis vs. Weight scatter")
figure(4)
    scatter(chick_data(:,4),chick_data(:,5))
    title("Chicken Minor Axis vs. Weight scatter")

% 2) Single Variable linear regression: using each of the features obtain a
% linear regression model against the weight, seperately

perim_weight_lr     = fitlm(chick_training(:,1), chick_training(:,5));
area_weight_lr      = fitlm(chick_training(:,2), chick_training(:,5));
majorAx_weight_lr   = fitlm(chick_training(:,3), chick_training(:,5));
minorAx_weight_lr   = fitlm(chick_training(:,4), chick_training(:,5));

rmses = [perim_weight_lr.RMSE area_weight_lr.RMSE majorAx_weight_lr.RMSE minorAx_weight_lr.RMSE];
[val,idx] = min(rmses);
fprintf("Found min at %d, with RMSE at %3.3f\n",idx,val)

switch idx
    case 1
        y_beta  = perim_weight_lr.Coefficients.Estimate(2);
        y_alpha = perim_weight_lr.Coefficients.Estimate(1);
        x_var   = 'Perimeter';
    case 2
        y_beta  = area_weight_lr.Coefficients.Estimate(2);
        y_alpha = area_weight_lr.Coefficients.Estimate(1);
        x_var   = 'Area';
    case 3
        y_beta  = majorAx_weight_lr.Coefficients.Estimate(2);
        y_alpha = majorAx_weight_lr.Coefficients.Estimate(1);
        x_var   = 'Major Axis';
    case 4
        y_beta  = minorAx_weight_lr.Coefficients.Estimate(2);
        y_alpha = minorAx_weight_lr.Coefficients.Estimate(1);
        x_var   = 'Minor Axis';
end

fprintf("Linear equation: Weight = %3.3f*(%s) + %3.3f\n",y_beta,x_var,y_alpha)

estimatedWeight = y_beta .* chick_test(:,idx) + y_alpha;

errorWeight = abs((estimatedWeight - chick_test(:,5)))./chick_test(:,5)*100;
meanError = mean(errorWeight);
fprintf("The mean error of the non-robust linear regression model is %2.2f %%\n",meanError)


%% Robust Regression now...
% Leave the outliers in the dataset
fprintf("----------------------------------------------\n")
fprintf("-----------Robust Linear Equation-------------\n")
fprintf("----------------------------------------------\n")

perim_weight_Roblr    = fitlm(chick_training(:,1),chick_training(:,5),"RobustOpts","on");
area_weight_Roblr     = fitlm(chick_training(:,2),chick_training(:,5),"RobustOpts","on");
majorAx_weight_Roblr  = fitlm(chick_training(:,3),chick_training(:,5),"RobustOpts","on");
minorAx_weight_Roblr  = fitlm(chick_training(:,4),chick_training(:,5),"RobustOpts","on");

rmsesRob = [perim_weight_Roblr.RMSE area_weight_Roblr.RMSE majorAx_weight_Roblr.RMSE minorAx_weight_Roblr.RMSE];

[val,idx] = min(rmsesRob);
fprintf("Found min at %d, with RMSE at %3.3f\n",idx,val)

switch idx
    case 1
        y_beta  = perim_weight_Roblr.Coefficients.Estimate(2);
        y_alpha = perim_weight_Roblr.Coefficients.Estimate(1);
        x_var   = 'Perimeter';
    case 2
        y_beta  = area_weight_Roblr.Coefficients.Estimate(2);
        y_alpha = area_weight_Roblr.Coefficients.Estimate(1);
        x_var   = 'Area';
    case 3
        y_beta  = majorAx_weight_Roblr.Coefficients.Estimate(2);
        y_alpha = majorAx_weight_Roblr.Coefficients.Estimate(1);
        x_var   = 'Major Axis';
    case 4
        y_beta  = minorAx_weight_Roblr.Coefficients.Estimate(2);
        y_alpha = minorAx_weight_Roblr.Coefficients.Estimate(1);
        x_var   = 'Minor Axis';
end

fprintf("Robust linear equation: Weight = %3.3f*(%s) + %3.3f\n",y_beta,x_var,y_alpha)

estimatedWeightRob = y_beta .* chick_test(:,idx) + y_alpha;

errorWeightRob = abs( (estimatedWeightRob - chick_test(:,5))) ./chick_test(:,5)*100;
meanErrorRob = mean(errorWeightRob);
fprintf("The mean error of the robust linear regression model is %2.2f %%\n",meanErrorRob)


%% Obtain the multiple linear regression model with all features together
% Use the new model to estimate the weight of the chiecken using the test
% data set. calculate the mean of the percentage of differences using only
% testing data. show the equation using fprintf

fprintf("----------------------------------------------\n")
fprintf("-------Multiple-Robust Linear Equation--------\n")
fprintf("----------------------------------------------\n")

% T_new for MLRM, use table with wilkinson notation; not the array as
% before.

mlmr = fitlm(T_train,"Weight~Perimeter+Area+MajorAxis+MinorAxis",'RobustOpts',"on");

mlmr_CI     = coefCI(mlmr);
mlmr_Pval   = coefTest(mlmr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

est_int = mlmr.Coefficients.Estimate(1); % Intercept
est_per = mlmr.Coefficients.Estimate(2); % Perimeter
est_ara = mlmr.Coefficients.Estimate(3); % Area
est_maj = mlmr.Coefficients.Estimate(4); % Major
est_min = mlmr.Coefficients.Estimate(5); % Minor

fprintf("Linear equation: Weight = %3.3f*1{Intercept} + %3.3f*Perimeter + %3.3f*Area + %3.3f*MajorAxis + %3.3f*Minor Axis \n", ...
    est_int, est_per, est_ara, est_maj, est_min)

estWeight = est_int + (est_per.*table2array(T_test(:,"Perimeter"))) + (est_ara.*table2array(T_test(:,"Area"))) + ...
    (est_maj.*table2array(T_test(:,"MajorAxis"))) + (est_min.*table2array(T_test(:,"MinorAxis")));

errorWeightMulti = ((abs(estWeight - table2array(T_test(:,"Weight")))) ./table2array(T_test(:,"Weight"))) *100;

meanErrorMulti = mean(errorWeightMulti);
fprintf("The mean error of the Robust linear regression model is %2.2f %%\n",meanErrorMulti)

fprintf("----------------------------------------------\n")

%% 9) Use the formula of 8 to estimate the chicken weight utilising feature data obtained from an image:
% Read image chicken1.jpg, threshold, morphological etc removing all noise.
% display the final binarized image. Find all features, then calculate the
% weight showing the wieght in the title of the image to 2sigfig, xxxx.xx g
% g for gram, note should have using round(result*100)/100

chkimg = imread("chicken1.jpg");
    chk_r = chkimg(:,:,1);
    chk_g = chkimg(:,:,2);
    chk_b = chkimg(:,:,3);

% figure(5)
% subplot(2,2,1)
%     imshow(chkimg)
% subplot(2,2,2)
%     imshow(chk_r)
%     title("red")
%     impixelinfo
% subplot(2,2,3)
%     imshow(chk_g)
%     title("green")
%     impixelinfo
% subplot(2,2,4)
%     imshow(chk_b)
%     title("blue")
%     impixelinfo

% r_th = 
g_th = 150;
b_th = 150;

imth = (chk_b > b_th) & (chk_g > g_th);

SE = strel('disk',6);
imer = imerode(imth,SE);
imrecon = imreconstruct(imer,imth);

% figure(6)
%     imshow(imrecon)
%     title("denoised chook")

rp = regionprops(imrecon,'all');

ChookWeightEst = est_int + (est_per*rp.Perimeter) + (est_ara*rp.Area) + ...
    (est_maj*rp.MajorAxisLength) + (est_min*rp.MinorAxisLength);

% fprintf("Area: %3.3f\n" + ...
%     "MajorAxis: %3.3f\n" + ...
%     "MinorAxis: %3.3f\n" + ...
%     "Perimeter: %3.3f\n" + ...
%     "ChookWeight: %3.3f\n" ...
%     ,rp.Area,rp.MajorAxisLength,rp.MinorAxisLength,rp.Perimeter,ChookWeight)

str = "The estimated weight: "+num2str(round(ChookWeightEst*100)/100)+ " grams";

figure(7)
    imshow(chkimg)
    pause(3/10)
    title(str)

fprintf("-------------------FIN------------------------\n")











