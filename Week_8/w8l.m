%w8l.m Logistic regression
% we use Fisher's iris flower data
% 50 samples from each of three species of iris ((Iris setosa (1), Iris
% virginica (2) and Iris versicolor(3))
% In here, we use all four feature to see how logistic regression works. 
close all, clear all, clc
%read data from table
% you can do simply load fisheries
Iris=readtable('class_data.xlsx', 'Sheet', 'iris');

%separate measurements and the species
Iris_inO=Iris(:, 2:5); Iris_cla_Ori=Iris(:,6); 
Iris_clanumO=Iris(:,7);
Iris_in=table2array(Iris_inO); %measurements
Iris_claO=table2cell(Iris_cla_Ori); %species
%species number (for comparison purpose, I put the number for each species
%setosa =1, versicolor =2 and virginica =3. 
Iris_clanum=table2array(Iris_clanumO); 

%we change species into cateorical array for regression analysis
Iris_cla = categorical(Iris_claO);

figure(1),
gscatter(Iris_in(:,1), Iris_in(:,2), Iris_cla, 'brg','xo.'); grid on
title('Fisher''s Iris Data 1 - Sepal'), xlabel('Sepal Length (cm)'), 
ylabel('Sepal Width (cm)')

figure(2),
gscatter(Iris_in(:,3), Iris_in(:,4), Iris_cla,'brg','xo.'); grid on
title('Fisher''s Iris Data 2 - Petal'), xlabel('Petal Length (cm)'), 
ylabel('Petal Width (cm)')

%%
%======= divide the data sets to training set and testing set ========
%Divide data to two groups: training set and validation set
%Create random numbers and based on this random numbers, we divide 
%the entire data set into two groups of data set
%We firstly reset the settings of the random number generator 
%rng('default') will generate exactly the same random number everytime!
rng('default')  

% divide data for training and validation
data_length = length(Iris_cla);
TestIdx = randperm(data_length,30); %index for test
TrainIdx = setdiff(1:data_length, TestIdx); %index for training

% Note that setdiff returns the data in one set that is 
% not in the other set, with no repetitions. 
% The result is in sorted order.

IrisIn_train=Iris_in(TrainIdx,:); %training input
IrisOut_train=Iris_cla(TrainIdx,:); %training output
IrisNum_train=Iris_clanum(TrainIdx,:); %training output as number

IrisIn_test=Iris_in(TestIdx,:); %teating input
IrisOut_test=Iris_cla(TestIdx,:); %testing output
IrisNum_test=Iris_clanum(TestIdx,:); %testing output as number

%%
%train the model using logistic regression
[B_all, dev_all, stats_all] = mnrfit(IrisIn_train, IrisOut_train, 'model', 'nominal');
p_all = stats_all.p;
se_all = stats_all.se;

%%
%validation with test data
[i4_prob, d_low, d_hi] = mnrval(B_all,IrisIn_test, stats_all);
%the category will be found: any categoty with highest probability 
% will be chosen
[maxp_4,i4_hat] = max(i4_prob,[],2); %find category

%how many each cases are selected
probs_setosa = i4_prob(IrisOut_test=='setosa',1)
probs_versicolor  = i4_prob(IrisOut_test=='versicolor',2)
probs_virginica = i4_prob(IrisOut_test=='virginica',3)

%compare the result of regression and the ground truth = accuracy
[i4_hat, IrisNum_test]
accuracy=mean(double(i4_hat==IrisNum_test)*100)

% confusoin matrix 
figure(3) 
ConfMat = confusionchart(IrisNum_test, i4_hat)
title('setosa(1), versicolor(2), virginica(3) using petal length only') 
xlabel('\bf Predicted class from logistic regression')
ylabel('\bf True (grount-truth) class')
