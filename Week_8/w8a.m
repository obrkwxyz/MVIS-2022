%w8a.m linear regression - example
close all; clear all; clc

% Example given in lecture slides
x=[200, 1000,1550, 900, 1300, 400, 500, 720]';
y=[370, 840, 1080, 750, 910, 395, 495, 680]';

figure(1), scatter(x,y, 'r*'), title('Scatter plot for x and y')
axis([0 max(x)+100 0 max(y)+100]), hold on, grid on

%correlation coefficient
y_cocoef=corrcoef(x,y)

%coefficient of determination
y_coede=(corrcoef(x,y)).^2
%%
%solve for y=bx (without y-intercept, a=0)
beta_d=mldivide(x,y); 
y_hat=beta_d*x; %the estimated values
figure(2)
scatter(x,y, 'r*'), axis([0 max(x)+100 0 max(y)+100]), 
hold on, grid on, 
plot(x, y_hat,'b'), title('y=\beta x and Scatter plot (x,y)')
hold off
%%
%draw residual between y and yhat=bx using stem
y_resi=y-y_hat; %residuals
figure(3), stem(y_resi, 'b*'), 
title(['Residual of y and y=\beta x with \beta= ', num2str(beta_d)])
axis([0 length(y)+1 min(y_resi)-50 max(y_resi)+50]), hold on
