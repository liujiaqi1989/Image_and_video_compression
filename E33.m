clc
clear all
close all

path(path,'encoder')            % make the encoder-functions visible to matlab
path(path,'decoder')            % make the encoder-functions visible to matlab
path(path,'analysis')           % make the encoder-functions visible to matlab
load huffman.mat;
im=double(imread('data/images/lena.tif'));
[h,w,d]=size(im);
e=0.001;
%[im2,mse]=LloydMax3(im,3,e);
[im2,mse]=LloydMax3_new(im,3,e);
figure
subplot(1,2,1)
imshow(im/256);
subplot(1,2,2)
imshow(im2/256);
mse2=calcMSE(h,w,d,im/256,im2/256);
PSNR1=calcPSNR(mse2,1);

