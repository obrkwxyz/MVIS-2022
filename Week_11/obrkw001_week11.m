%ce10p1.m chicken size data - clustering with K-Means and GMM


%% Kane O'Brien
close all, clear all, clc
% read data from table
T = readtable('ce10_prac.xlsx', 'Sheet','chicken1');

% rearrange the table 
T_new = table(T.Perimeter, T.Area, T.MajorAxis, T.MinorAxis, T.Size, T.S_num, ...
    'VariableNames',{'Perimeter','Area','MajorAxis','MinorAxis','Size','S_num'});

% Input data
T_inoutO = T(:, 2:5);
T_input = table2array(T_inoutO); 
% Output data with Size class ('Large', Medium', 'Small') 
T_sizeO = T(:,6);
T_size_cell = table2cell(T_sizeO); %species
T_size_cat = categorical(T_size_cell);
% Output data with size number (Large=1, Medium=2, Small=3)
T_SnumO = T(:,7);
T_Snum = table2array(T_SnumO); 

%% Start to work on here for K-Means and GMM

figure(1)
    gscatter(T_new.Perimeter,T_new.Area, T_Snum)
    xlabel("Chicken Perimeter")
    ylabel("Chicken Area")
    title("Chicken Perimeter vs. Area; S\_num Grouping")

figure(2)
    gscatter(T_new.MajorAxis,T_new.MinorAxis, T_Snum)
    xlabel("Chicken Major Axis")
    ylabel("Chicken Minor Axis")
    title("Chicken Major Axis vs. Minor Axis; S\_num Grouping")


% From the original dataset - we know we WANT 3 clusters; small medium and
% large; that is priori knowledge;
k_cluster = 3; 

%Actually we use the elbow method -- Going to test each parameter

SSE1=[];
SSE2=[];
SSE3=[];
SSE4=[];
for K = 1:10
    [Idx1,C1,SumD1,PointD1] = kmeans(T_new.Perimeter,K);
    [Idx2,C2,SumD2,PointD2] = kmeans(T_new.Area,K);
    [Idx3,C3,SumD3,PointD3] = kmeans(T_new.MajorAxis,K);
    [Idx4,C4,SumD4,PointD4] = kmeans(T_new.MinorAxis,K);
    SSE1(K) = sum(SumD1);
    SSE2(K) = sum(SumD2);
    SSE3(K) = sum(SumD3);
    SSE4(K) = sum(SumD4);
end

figure(3)
subplot(2,2,1)
    plot(SSE1)
    title("SSE1 - Perimeter Elbow")
subplot(2,2,2)
    plot(SSE2)
    title("SSE2 - Area Elbow")
subplot(2,2,3)
    plot(SSE3)
    title("SSE3 - MajorAxis Elbow")
subplot(2,2,4)
    plot(SSE4)
    title("SSE4 - MinorAxis Elbow")

% graphically can determine the elbow/cluster size / point of diminisihing
% returns at approximatly 3 in each figure

k_cluster = 3; 

figure(3)
subplot(2,2,1)
    hold on
    plot(k_cluster,SSE1(k_cluster), 'r*')
    hold off
subplot(2,2,2)
    hold on
    plot(k_cluster,SSE2(k_cluster), 'r*')
    hold off
subplot(2,2,3)
    hold on
    plot(k_cluster,SSE3(k_cluster), 'r*')
    hold off
subplot(2,2,4)
    hold on
    plot(k_cluster,SSE4(k_cluster), 'r*')
    hold off

fprintf("Tabluation of known data-set grouping\n")
tabulate(T_Snum)

[Idx,Centroids,SumD,PointD] = kmeans([T_input],k_cluster,'EmptyAction','singleton','Replicates',5);
fprintf("Tabluation of Perim vs. Area grouping\n")
tabulate(Idx)
% Tabluate shows us the distribution of the chickens grouping, as we calculated;
% This can be compared with the real grouping (s_num) and should be quite similar. 

figure(4)
    gscatter(T_new.Perimeter,T_new.Area,Idx)
    xlabel("Chicken Perimeter")
    ylabel("Chicken Area")
    title("Chicken Perimeter vs. Area; K\_Cluster Grouping","K=3")
    hold on
    scatter(Centroids(:,1),Centroids(:,2),100,'r*')
    hold off

figure(5)
    [sval handle]=silhouette(T_input, Idx)
    title('Silhouette plot, K=3')

mean_sil = mean(sval)
% The mean Silhouette value is 0.756; this is considered 'accurate enough',
% but still some values are likley to be incorrectly classified

%% Heirarchial Clustering

Xdist = pdist([T_input(:,1) T_input(:,2)]);  

xGroup = linkage(Xdist,'average');

figure(6)
    X_dg = dendrogram(xGroup);

[cophen,codist]  = cophenet(xGroup,Xdist);
incorr   = inconsistent(xGroup);
leafOrder = optimalleaforder(xGroup,Xdist);

figure(6)
    X_dg_opt =dendrogram(xGroup,'Reorder',leafOrder);
    title("Optimally Rearranged leaf-Dendogram")

Clus1 = cluster(xGroup,'maxclust',3);

figure(7)
    gscatter(T_input(:,1),T_input(:,2), Clus1)
    xlabel("Chicken Perimeter")
    ylabel("Chicken Area")
    title("Chicken Perimeter vs. Area; Heirarchial Clustering","Nodes=3")

    
    
pause()
   
%% Part 2 - Angle of Repose

close all
clc
clear all

img = imread("aor1.jpg");

img_g = rgb2gray(img);


thresh_l = 15; % Relaxed Threshold values
thresh_u = 254; %
img_th = img_g > thresh_l & img_g < thresh_u;

im_fill = imfill(img_th,'holes'); % fill internal holes

SE = strel('square',30);
SE2 = strel('diamond',3);
im_er = imerode(im_fill,SE);
im_re = imreconstruct(im_er,im_fill);

im_p = imerode(im_re,SE2); %Erode with a small SE to improve the diagonal edge quality; 

figure(2)
    imshow(im_p)
    title("Eroded, denoised image")

im_perim = bwperim(im_p);


stats = regionprops(im_perim,'all');
BB = floor(stats.BoundingBox);
%Vertex of BB
j1 = [BB(1); BB(2)];
j2 = [BB(1)+BB(3); BB(2)];
j3 = [BB(1); BB(2)+BB(4)];
j4 = [BB(1)+BB(3); BB(2)+BB(4)];
% jxy is Vertex in format for scatterplot
jx = [BB(1) BB(1)+BB(3) BB(1) BB(1)+BB(3)];
jy = [BB(2) BB(2) BB(2)+BB(4) BB(2)+BB(4)];
% Jxxyy is lines nodes 1-2-4-3-1
jxx =[j1(1) j2(1) j4(1) j3(1) j1(1)];
jyy =[j1(2) j2(2) j4(2) j3(2) j1(2)];

figure(3)
    imshow(im_perim)
    hold on
    line(jxx,jyy) % Draw BB
    scatter(jx,jy,'r*') % Draw Vertex
    title("Eroded Denoised, image, showing bounding box")

im_crop = im_perim(1: BB(2)+BB(4)-20, BB(1):BB(1)+BB(3));

pause(1/10)
figure(4)
    imshow(im_crop)
    title("Crop image and 20 pixel of the Bounding Box ")
    impixelinfo
pause(1/10)


[~,yy] = size(im_crop);
mid_cl = round(yy/2);

% Examining the data, we can ignore the center ~ 200 pixels 'flat spot' 
% these are 'outliers' and only serve to upset a linear model; these can be
% trimmed however as request instead we will use RobustOps
% Further we know imshow handles coordinates opposite from the matrix format;
% Flip to get the correct orientation; however it will need to be flipped
% again in future

imgL = im_crop(:,1:mid_cl-1);
imgR = im_crop(:,mid_cl+1:end);

imgLp = fliplr(imgL)';
imgRp = fliplr(imgR)';

[Lx_pix,Ly_pix] = find(imgLp==1);
[Rx_pix,Ry_pix] = find(imgRp==1);

% Now we have a linear model
% the estimate(2) is the slope (m in y=mx+c)
% m=rise/run  : tantheta= rise/run Therefore theta = atand(m)

LeftModel = fitlm(Lx_pix,Ly_pix,'RobustOpts','on');
RightModel = fitlm(Rx_pix,Ry_pix,'RobustOpts','on');

Langle = atand(LeftModel.Coefficients.Estimate(2));
Rangle = atand(RightModel.Coefficients.Estimate(2));

figure(66)
subplot(2,2,1)
    imagesc(imgL)
    title("test")
subplot(2,2,2)
    imagesc(imgR)
subplot(2,2,3)
    plot(LeftModel)
    title(Langle)
subplot(2,2,4)
    plot(RightModel)
    title(Rangle)

% now you actually wanted it plotted on the original plots.. Doesnt quite
% line up; have not fully investigated.

LLx = [1 length(Lx_pix)];
LRx = [1 length(Rx_pix)];
Lx1 = LeftModel.Coefficients.Estimate(2)*LLx(2)  + LeftModel.Coefficients.Estimate(1);
Lx2 = LeftModel.Coefficients.Estimate(2)*LLx(1)  + LeftModel.Coefficients.Estimate(1);
Rx1 = RightModel.Coefficients.Estimate(2)*LRx(2) + RightModel.Coefficients.Estimate(1);
Rx2 = RightModel.Coefficients.Estimate(2)*LRx(1) + RightModel.Coefficients.Estimate(1);
LLy = [Lx1 Lx2];
LRy = [Rx1 Rx2];

figure(4)
    imshow(imgL)
    hold on
    line(LLx,LLy)
    title(sprintf("AOR of Left Side %2.2f Degrees",Langle))

figure(5)
    imshow(imgR)
    hold on
    line(LRx,LRy)
    title(sprintf("AOR of Right Side %2.2f Degrees",Rangle))