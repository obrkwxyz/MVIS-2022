%w8b.m linear regression using basic fitting interface
 clear all; close all, clc

%given simple example
x=[200, 1000,1550, 900, 1300, 400, 500, 720]';
y=[370, 840, 1080, 750, 910, 395, 495, 680]';
% draw a scatter plot first 
figure(1), scatter(x,y, 'r*'), title('Scatter plot for x and y')
axis([0 max(x)+100 0 max(y)+100]), hold on
grid on

%do the basic fitting interface in figure 1
%1. in figure(1), figure window
%   choose Tools --> Basic fitting
%2. From a small window apprears: select fitting method: 
%   in our case, "choose linear". Then click left arrow at the bottom of
%   the window "-->"
%3. the new window shows the slope and y-intercept with the amount of
%   residuals.You can save the result by clicking "save to Workspace"
%4. then ina new window, you can put a new value for "x' to obtain the
%   values for y