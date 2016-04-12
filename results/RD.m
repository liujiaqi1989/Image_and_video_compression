% load foreman_16.mat
% PSNR_mean_16=PSNR_mean;
% BR_mean_16=BR_mean;
% load foreman.mat
% BR_still_o=BR_still;
% PSNR_still_o=PSNR_still;
% BR_mean_o=BR_mean;
% PSNR_mean_o=PSNR_mean;
% load foreman_8.mat
load ele.mat
PSNR_mean_o=PSNR_mean;
BR_mean_o=BR_mean;
load ele_8.mat
BR_still_8=BR_still;
PSNR_still_8=PSNR_still;
BR_mean_8=BR_mean;
PSNR_mean_8=PSNR_mean;
load ele_16_haf.mat
BR_mean_16_haf=BR_mean;
PSNR_mean_16_haf=PSNR_mean;
load ele_16_h.mat
BR_mean_16_h=BR_mean;
PSNR_mean_16_h=PSNR_mean;
BR_still_16_h=BR_still;
PSNR_still_16_h=PSNR_still;
load ele_16.mat
figure('units','normalized','outerposition',[0 0 1 1])
hold on
plot(BR_mean,PSNR_mean,'black+-','MarkerSize',10,'LineWidth',2);
%plot(BR_still,PSNR_still,'r+-','MarkerSize',10,'LineWidth',2);
plot(BR_mean_o,PSNR_mean_o,'green+-','MarkerSize',10,'LineWidth',2);
plot(BR_mean_16_haf,PSNR_mean_16_haf,'r+-','MarkerSize',10,'LineWidth',2);
plot(BR_mean_8,PSNR_mean_8,'b+-','MarkerSize',10,'LineWidth',2);
%plot(BR_mean_16_haf,PSNR_mean_16_haf,'y+-','MarkerSize',10,'LineWidth',2)