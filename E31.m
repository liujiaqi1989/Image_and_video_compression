clc
clear all
close all

path(path,'encoder')            % make the encoder-functions visible to matlab
path(path,'decoder')            % make the encoder-functions visible to matlab
path(path,'analysis')           % make the encoder-functions visible to matlab
load huffman.mat;
im= double(imread('data/images/lena_small.tif'))/256;
M=[1 2 3 5 7];
P=[0 0 0 0 0];
[h,w,d]=size(im);
for i=1:5
im2=UniQuant(im,M(i));
im3=InvUniQuant(im2,M(i));
MSE=calcMSE(h,w,d,im,im3);
PSNR=calcPSNR(MSE,1);
P(i)=PSNR;
end
im= double(imread('data/images/lena.tif'))/256;
M1=[3 5];
P1=[0 0];
[h,w,d]=size(im);
for i=1:2
im2=UniQuant(im,M1(i));
im3=InvUniQuant(im2,M1(i));
MSE=calcMSE(h,w,d,im,im3);
PSNR=calcPSNR(MSE,1);
P1(i)=PSNR;
end
figure
plot(M,P);
hold on;
plot(M1,P1);