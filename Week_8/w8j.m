%w8j.m Logistic regression
%using two exam results, make a decision: reject(1) or accept (2)
close all, clear all, clc
%read data from table
T=readtable('class_data.xlsx', 'Sheet', 'exam');

%separate exam resutls and the decision
T_examI=table2array(T(:, 1:2)); %exam results
T_decO=table2array(T(:,3)); %decision

%we change decision variable into cateorical array for regression analysis
T_dec = categorical(T_decO);

%plot the data
figure(1), plot(T_examI(:,1),T_dec, 'r.'), title('Exam 1 and Outcome')
grid on, xlabel('Exam1'), ylabel('Decision')
figure(2), plot(T_examI(:,2),T_dec, 'b.'),title('Exam 2 and Outcome') 
grid on, xlabel('Exam2'), ylabel('Decision')

figure(3)
gscatter(T_examI(:,1), T_examI(:,2), T_dec, 'rb','xo'); grid on
title('x: Rejected, o: Accepted')
xlabel('Exam1'), ylabel('Exam2'), legend('Rejected', 'Accepted')
%%
%======= divide the data sets to training set and testing set ========
%Divide data to two groups: training set and validation set
%Create random numbers and based on this random numbers, we divide 
%the entire data set into two groups of data set
%We firstly reset the settings of the random number generator 
%rng('default') will generate exactly the same random number everytime!
rng('default')  

%Create random numbers and use it for division
data_length = length(T_dec); %number of data
TestIdx = randperm(data_length,20); %generate 20 numbers for test index 
TrainIdx = setdiff(1:data_length, TestIdx); %index for training

% Note that setdiff returns the data in one set that is 
% not in the other set, with no repetitions. 
% The result is in sorted order.

T_trainI=T_examI(TrainIdx,:); %input for training set 
T_trainO=T_dec(TrainIdx,:); %output for training set

T_testI=T_examI(TestIdx,:); %input for testing set 
T_testO=T_dec(TestIdx,:); %output for testing set 

% we should have ground-truth output of testing set (for comparison later)
% since we use this for comparison, we should ave it as an array not
% catoegory!
T_testON=T_decO(TestIdx,:); 
%%
%======= Build logistic regression model using training set ========
%train the model using logistic regression
[B_coefficient, dev_train, stats_train] = mnrfit(T_trainI, T_trainO, 'model', 'nominal')
%check coefficients and statistics
p_train = stats_train.p;
se_train = stats_train.se;
corrcoef = stats_train.coeffcorr

%%
%validation with test data
[O_prob, dlow, dhi] = mnrval(B_coefficient,T_testI,stats_train);

%The model output should be any class with higher probability 
%max(A, [], 2) will return the column number having the maximum value
%if you use 1 instead of 2, it will return the row number
[maxp_all,O_hat] = max(O_prob,[],2); %find category

%compare the result of regression and the ground truth for accuracy
[O_hat, T_testON]

% accuracy calculation for comparison
accuracy=mean(double(O_hat==T_testON)*100)

% confusoin matrix 
figure(4) 
ConfMat = confusionchart(T_testON, O_hat)
title('Reject (1) or Accept (2) Classification based on 2 exam results') 
xlabel('\bf Predicted class from logistic regression')
ylabel('\bf True (grount-truth) class')

