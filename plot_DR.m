% BR_mean=[0.6185,0.7216,1.3282,1.6145,2.6404];
% PSNR_mean=[31.9158,32.1688,32.8781,33.0677,33.8711];
% BR_still=[1.0897,1.2162,1.8371,2.0840,3.0456];
% PSNR_still=[33.1288,33.7551,36.3252,37.2406,40.2168];

load opt.mat
load noah.mat
figure
hold on
plot(BR_mean,PSNR_mean,'b+-','MarkerSize',10,'LineWidth',2);
%plot(BR_still,PSNR_still,'r+-','MarkerSize',10,'LineWidth',2);
plot(BR_mean_noah,PSNR_mean_noah,'b+-','MarkerSize',10,'LineWidth',2);
