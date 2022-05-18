%% OBRKW001 - Class exam 18/5/22
%% PART B
clc
clear all
close all
%% Part 1
img = imread("q3a.png");
img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

% figure(1)
%     imshow(img)

figure(2)
subplot(1,3,1)
    imshow(img_r)
    impixelinfo
subplot(1,3,2)
    imshow(img_g)
    impixelinfo
subplot(1,3,3)
    imshow(img_b)
    impixelinfo


% test_red = 200 ;%less
% test_green = 100; %;less
% test_imth = img_r < test_red & img_g < test_green;

th_r = 207; %% Return to this if time; the morphographic processing is a little off; hence the euler numbers arent right.
img_th = img_r > th_r;

% 
% test_img = ~test_imth&img_th;
% figure(3)
% subplot(1,2,1)
%     imshowpair(~test_imth,img_th,'montage')
% subplot(1,2,2)
%     imshow(~test_imth&img_th)

%Cards back
SE1 = strel('disk', 25);
im_er = imerode(img_th,SE1);
im_re = imreconstruct(im_er,img_th);
im_cardback = imfill(im_re,'holes');

% Numbers
SE2 = strel('disk',11);
% im_er2 = imerode(~test_img,SE2);
im_er2 = imerode(~img_th,SE2);
im_re2 = imreconstruct(im_er2,~img_th);

im_numbs = im_re2 & im_cardback;
%%
labels = bwlabel(im_numbs);
numnums = max(max(labels));

str = "The number of all numbers: "+ num2str(numnums);

figure(4)
    imshow(im_numbs)
    title(str);

% B) Find the number 8 and 0
% use a for loop to iterate the label numbers and find the euier numbers
% that are not 1... En = surface-holes * therefore 8 = -1, 0 = 0
% 0 => Green
% 8 => red
% else => blue


numeights = 0;
numzeros = 0;
for i = 1:numnums
    stat = regionprops((labels==i),'EulerNumber');
%     
    if stat.EulerNumber == -1
        % number 8 -red
%        fprintf("red")
        img_r(labels == i) = 255;
        img_g(labels == i) = 0;
        img_b(labels == i) = 0;
        numeights = numeights+1;
    elseif stat.EulerNumber == -8 %% These euler numbers arent quite right.
       % number 0 - Green
%         fprintf("green")
        img_r(labels == i) = 0;
        img_g(labels == i) = 255;
        img_b(labels == i) = 0;
        numzeros = numzeros +1;
    else
       % all other numbers - blue
%         fprintf("blue")
        img_r(labels == i) = 0;
        img_g(labels == i) = 0;
        img_b(labels == i) = 255;
    end
end

str= "The number of 8: "+ num2str(numeights) + "The number of 0: "+ num2str(numzeros)+" All remaining numbers: "+num2str(numnums-numeights-numzeros);


img_BB = cat(3,img_r,img_g,img_b);
figure(5)
    imshow(img_BB) %% My morphographic numbers are off enough to allow a hole in the zeros; therefore this is mildly wrong
    title(str)


