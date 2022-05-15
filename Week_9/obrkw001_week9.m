%% Kane O'Brien obrkw001
% Week 9 class exercise
% 11/05/22

clc
clear all
close all
warning('off','all')
%% Part 1
ver = 1 ;

switch ver
    case 1
        ss= "chicken1";
    otherwise
        ss= "chicken2";
end

T = readtable("ce9_prac.xlsx", 'sheet',ss);
T_new = table(T.Perimeter, T.Area, T.MajorAxis, T.MinorAxis, T.Size, T.S_num, ...
    'VariableNames',{'Perimeter', 'Area','MajorAxis', 'MinorAxis', 'Size', 'S_num' });
% load("trainedModel_obrkw001.mat"); %  previously generated in the classification learner app

ChickenIn  = table2array(T_new(:,1:4));
ChickenOut = table2cell(T_new(:,5:6));

len  = length(ChickenIn);
trainVals = randperm(len,0.8*len);
testVals  = setdiff(1:len, trainVals);

train_data_in  = ChickenIn(trainVals,:);
train_data_out = ChickenOut(trainVals,:);
test_data_in   = ChickenIn(testVals,:);
test_data_out  = ChickenOut(testVals,:);

figure(1)
subplot(2,1,1)
    gscatter(train_data_in(:,1), train_data_in(:,2), train_data_out(:,1))
    title("Perimeter : Area; Grouped - Size")
    xlabel("Training Perimeter")
    ylabel("Training Area")
subplot(2,1,2)
    gscatter(train_data_in(:,3), train_data_in(:,4), train_data_out(:,1))
    title("MajorAxis : MinorAxis; Grouped - Size")
    xlabel("Training Major Axis")
    ylabel("Training Minor Axis")

R_final = table(test_data_in(:,1), test_data_in(:,2), test_data_in(:,3), test_data_in(:,4), ...
    cell2mat(test_data_out(:,2)), ...
    'VariableNames',{'Perimeter', 'Area', 'MajorAxis', 'MinorAxis', 'S_num'});

%% train the model using SVM
% % Dont get stuck for 1 hour because you put responseNames = {'Size'}
% like a dingbat \facepalm.

svmOpts = templateSVM('Standardize',true,'SaveSupportVectors',true);
predictorNames = {'Perimeter','Area','MajorAxis','MinorAxis'};
responseNames = 'Size';
classNames = {'Small','Medium','Large'};

SysModel = fitcecoc(train_data_in,train_data_out(:,1),'Learners',svmOpts,'ResponseName',responseNames, ...
    'PredictorNames',predictorNames,'ClassNames',classNames);

[label,score] = predict(SysModel,test_data_in);

acc_SVM = mean(strcmp(label, test_data_out(:,1)))*100;

figure(2)
    confusionchart(label,test_data_out(:,1), 'RowSummary','total-normalized','ColumnSummary','total-normalized')

R_final{:,6} = label_convert(label(:,1));
R_final.Properties.VariableNames(6) = {'SVM'};

syscval    = crossval(SysModel);
sysPredict = kfoldPredict(syscval);

acc_SVMCV = mean(strcmp(sysPredict, train_data_out(:,1)))*100;

figure(3)
    confusionchart(sysPredict,train_data_out(:,1), 'RowSummary','total-normalized','ColumnSummary','total-normalized')

%% Train the model with K-NN

SysModelK = fitcknn(train_data_in,train_data_out(:,1));

[label,score] = predict(SysModelK,test_data_in);

acc_KNN = mean(strcmp(label, test_data_out(:,1)))*100;

figure(4)
    confusionchart(label,test_data_out(:,1), 'RowSummary','total-normalized','ColumnSummary','total-normalized')

R_final{:,7} = label_convert(label(:,1));
R_final.Properties.VariableNames(7) = {'KNN'};

syscvalK    = crossval(SysModelK);
sysPredictK = kfoldPredict(syscvalK);

acc_KNNCV = mean(strcmp(sysPredictK, train_data_out(:,1)))*100;


models={'SVM', 'SVM_cross', 'KNN', 'KNN_Cross'};
acc = [acc_SVM acc_SVMCV acc_KNN acc_KNNCV];
[bestModel,idx] = max(acc);

fprintf("The best performed classification approach is %s with accuracy of %3.2f%%\n\n", string(models(idx)),bestModel)
