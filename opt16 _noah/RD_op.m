% %no optimazytion
% x1=[0.2273,0.4490,0.6258,0.7383,1.6301];
% y1=[28.5568,32.3619,33.5356,34.1676,37.2377];
% x2=[0.4445,0.9504,1.2110,1.3827,2.4177];
% y2=[27.9174,32.5002,33.8487,34.6259,38.4936];
% %optimazation with hevc 16x16 transform
% x3=[0.1777,0.3397,0.6230,1.0919,1.7001,2.5872];
% y3=[29.0873,30.8997,32.9785,35.5084,38.3089,41.1182];
% %optimazation with hevc 8x8 transform
% x4=[0.2625,0.3754,0.6209,1.0503,1.7348,2.6225];
% y4=[29.5137,31.5420,33.4331,35.5990,38.0767,40.7376];
clc
clear all
close all
load op_16.mat
x1=BR_mean;
y1=PSNR_mean;
x2=BR_still;
y2=PSNR_still;
load noah.mat
BR_still_noah=[0.3963,0.4687,0.5371,0.6001,0.6926,0.8302,0.9219,1.0915,1.4987];
PSNR_still_noah=[39.2211,40.6103,41.7053,42.5229,43.5981,45.0267,45.9407,47.0143,51.2677];

figure('units','normalized','outerposition',[0 0 1 1])
hold on

plot(BR_mean_noah(1:8),PSNR_mean_noah(1:8),'b+-','MarkerSize',10,'LineWidth',2);
plot(BR_still_noah,PSNR_still_noah,'r+-','MarkerSize',10,'LineWidth',2);
%plot(x1,y1,'black+-','MarkerSize',10,'LineWidth',2);
plot(x2,y2,'black+-','MarkerSize',10,'LineWidth',2);
