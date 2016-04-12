clear all
close all
clc
path(path,'data')
%path(path,'data/images')
im=double(imread ('sail.tif'))/256;
[h,w,d]=size(im);
im_r=subsample(im);
MSE=calcMSE(h,w,d,im,im_r);
PSNR=calcPSNR(MSE, 1)