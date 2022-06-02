%% Week 11 Class Exercise - Kane O'Brien 1/6/22

close all
clear all
clc



img = imread("sqb.png");

img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

im_g = rgb2gray(img);
im_b = imbinarize(im_g);

im_fill = imfill(im_b,[250,250]);


figure(1)
    imshow(im_fill);
    hold on
    plot(250,250,'r*');
    text(260,260,"This clearly doesnt work");
    title("Part A")
    hold off


SE1 = strel('square',10);
im_dil = imdilate(im_b,SE1);

im_fill2 = imfill(im_dil,'holes');
im_er = imerode(im_fill2,SE1);

im_bound = bwperim(im_er);

figure(2)
    imshow(im_bound);
    title("Part B")

im_fill3 = imfill(im_bound,[250,250]);

figure(3)
    imshow(im_fill3)
    hold on
    plot(250,250,'r*');
    title("Part C")
    hold off

im_redbound = ~im_b & im_bound;


img_r(im_redbound == 1) = 255;
img_g(im_redbound == 1) = 0;
img_b(im_redbound == 1) = 0;

img_fin = cat(3,img_r,img_g,img_b);

figure(4)
    imshow(img_fin)

%% Part 2: CHIIIIIKEEEN

chickenTable = readtable("ce11_prac.xlsx",Sheet="chicken");
inputs  = table2array(chickenTable(:,2:end-1))';
targets = table2array(chickenTable(:,end))'; 

nData = length(chickenTable.Sample);
nTrain = floor(0.7*nData);
nValidate = floor(0.15*nData);
nTest   = floor(0.15*nData);


figure(1)
subplot(2,2,1)
    gscatter(chickenTable.Perimeter, chickenTable.Weight)
    title("Perimeter vs. Weight")
    grid on
subplot(2,2,2)
    gscatter(chickenTable.Area, chickenTable.Weight)
    title("Area vs. Weight")
    grid on
subplot(2,2,3)
    gscatter(chickenTable.MajorAxis, chickenTable.Weight)
    title("Major Axis vs. Weight")
    grid on
subplot(2,2,4)
    gscatter(chickenTable.MinorAxis, chickenTable.Weight)
    title("Minor Axis Vs. Weight")
    grid on


nHidden = 10;
NN = fitnet(nHidden);

%divide data into training/validation and testing set
NN.divideParam.trainRatio = 70/100;
NN.divideParam.valRatio   = 15/100;
NN.divideParam.testRatio  = 15/100;

[NN,tr] = train(NN,inputs,targets); 

training_data   = inputs(:,tr.trainInd);
test_data       = inputs(:,tr.testInd);
val_data        = inputs(:,tr.valInd);

outputs = NN(inputs);

Perf = perform(NN, targets, outputs);
errors = gsubtract(targets,outputs);
MSE = sqrt(mean(errors.^2)); % Overall MSE

error_train = gsubtract(targets(tr.trainInd),outputs(tr.trainInd));
error_test  = gsubtract(targets(tr.testInd),outputs(tr.testInd));
error_val   = gsubtract(targets(tr.valInd),outputs(tr.valInd));

MSE_train =  sqrt(mean(error_train.^2)); % Training dataset MSE
MSE_test  =  sqrt(mean(error_test.^2)); % Testing dataset MSE
MSE_val   =  sqrt(mean(error_val.^2)); % Validation dataset MSE

MSE_Vec = [MSE_train MSE_test MSE_val]
% The above matrix shows us the testing, training and validation mean
% square errors. When the model is overfitted, the reality becomes that the
% model becomes good at recognising the patterns in the data it was trained
% on specificially, but should any outlier exist, the model behaves poorly.
% the fitnet function finds the global minimum that satisfies the equation
% within an allowed error margin, but as we are providing it 70% of the
% data for training, the model often becomes slightly over fitted. This is
% visible when we click the performance plot within the nntraintool, often
% the training data will converge to a minimum, but the train and test will
% begin to diverge.

% Further, on different runs, the data is randomized so different outputs
% of the above MSE vector are shown; [79.0398  107.6602  106.2515] and
% [55.4389   60.7697   64.2168] show that the testing data MSE is often
% lower than the test and validation MSE, again indicating mild
% overfitting.

img= imread("chicken1.jpg");

im_r = img(:,:,1);
im_g = img(:,:,2);
im_b = img(:,:,3);

b_th = 115;
SE = strel('disk',30);
im_th = im_b > b_th;

im_er = imerode(im_th,SE);
im_re = imreconstruct(im_er,im_th);



stats= regionprops(im_re,'Area','Perimeter','MajorAxisLength','MinorAxisLength');
chick_preds = struct2array(stats)';
pred_weight = NN(chick_preds)


figure(2)
    imshow(im_re);
    title(sprintf("The estimate weight: %4.2f g",pred_weight))

 % I feel like something is wrong with this, the predicted weight can be
 % -1kg - +7kg which doesnt seem right; the MSE is never greater than 200gm
 % difference; the morphological processing doenst change?
