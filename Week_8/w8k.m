%w8k.m Logistic regression
% we use Fisher's iris flower data
% 50 samples from each of three species of iris ((Iris setosa (1), Iris
% virginica (2) and Iris versicolor(3))
% In here, we use only one feature to see how this regression works. 
close all, clear all, clc
%read data from table
%you can do simply "load fisheries"
Iris=readtable('class_data.xlsx', 'Sheet', 'iris');

%separate measurements and the species
Iris_inO=Iris(:, 2:5); Iris_cla_Ori=Iris(:,6); 
Iris_clanumO=Iris(:,7);
Iris_in=table2array(Iris_inO); %input data
Iris_claO=table2cell(Iris_cla_Ori); %classes 
%species number (for comparison purpose, I put the number for each species
%setosa =1, versicolor =2 and virginica =3. 
Iris_clanum=table2array(Iris_clanumO); 

%we change species into cateorical array for regression analysis
Iris_cla = categorical(Iris_claO);

% As a starting, we use only one feature - Petal length 
petL=Iris_in(:,1);

figure(1)
scatter(petL, Iris_cla, 'b*'); grid on
title('Scatter plot for datapoints')
xlabel('Petal length'), ylabel('Species')
%%
%======= divide the data sets to training set and testing set ========
%Divide data to two groups: training set and validation set
%Create random numbers and based on this random numbers, we divide 
%the entire data set into two groups of data set
%We firstly reset the settings of the random number generator 
%rng('default') will generate exactly the same random number everytime!
rng('default')  

%then create random number
data_length = length(Iris_cla);
TestIdx = randperm(data_length,30); %index for test
TrainIdx = setdiff(1:data_length, TestIdx); %index for training
% Note that setdiff returns the data in one set that is 
% not in the other set, with no repetitions. 
% The result is in sorted order.

petL_train=petL(TrainIdx,:); %training input
spe_train=Iris_cla(TrainIdx,:); %training output
spenum_train=Iris_clanum(TrainIdx,:); %training output as number

petL_test=petL(TestIdx,:); %testing input
spe_test=Iris_cla(TestIdx,:); %testing output
spenum_test=Iris_clanum(TestIdx,:); %testing output as number
%%

%======= Build logistic regression model using training set ========
%train the model using logistic regression
[B, dev, stats_iris1] = mnrfit(petL_train, spe_train, 'model', 'nominal');
B_pval = stats_iris1.p;
B_se = stats_iris1.se;

%%
%validation with test data
[i_prob, d_low, d_hi]= mnrval(B,petL_test,stats_iris1);
%the category will be found: any categoty with highest probability 
% will be chosen
[maxp,i_hat] = max(i_prob,[],2); %find category

%compare the result of regression and the ground truth = accuracy
[i_hat, spenum_test]
accuracy=mean(double(i_hat==spenum_test)*100)

% confusoin matrix 
figure(2) 
ConfMat = confusionchart(spenum_test, i_hat)
title('setosa(1), versicolor(2), virginica(3) using petal length only') 
xlabel('\bf Predicted class from logistic regression')
ylabel('\bf True (grount-truth) class')
%%

% === draw the sigmoid curve for three classes =========
% We can draw sigmoid curcve for the three classes
% First we create a new set of continuous input using linspace
% then create the predicted classes accordint to the model 
% obtained from mrfit  
% note that this plot will owrk only one input variable case
%for more than 2 input variable, we cannot create this sort of plot 
% create a new input vector 
val_curveX = linspace(0,10)'; 
%obtain the probabilities for prediction using the new created input
inew_prob = mnrval(B,val_curveX,'model','nominal'); 

%drar sigmoid curve fot three classes
figure(3)
plot(val_curveX,inew_prob), axis([0 10 -0.1 1.1]), grid on
title('probability for 3 categories obtained from regression model')
legend('Prob(y=1)','Prob(y=2)','Prob(y=3)','location','best')

%The put the predicted class obtained using testing data set 
% to validate the result 
figure(4), plot(val_curveX,inew_prob), hold on, grid on
title('Sigmoid curve for 3 categories obtained from regression model')
legend('Prob(y=1)','Prob(y=2)','Prob(y=3)','location','best')

%draw test data point to the figure 
t1 = (i_hat==1); 
plot(petL_test(t1),maxp(t1),'color','b','marker','o','linestyle','none')
t2 = (i_hat==2); 
plot(petL_test(t2),maxp(t2),'color','k','marker','*','linestyle','none')
t3 = (i_hat==3); 
plot(petL_test(t3),maxp(t3),'color','r','marker','v','linestyle','none')
