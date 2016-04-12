clear all
close all
clc
tim=double(imread ('sail.tif'))/256;
tim_YCbCr=ictRGB2YCbCr(tim);
%downsample
for i=2:3
    tim_YCbCr1(:,:,i)=resample(tim_YCbCr(:,:,i),1,2,3);
    tim_YCbCr2(:,:,i)=tim_YCbCr1(:,:,i)';
    tim_YCbCr3(:,:,i)=resample(tim_YCbCr2(:,:,i),1,2,3);
    tim_YCbCr4(:,:,i)=tim_YCbCr3(:,:,i)';
end

%upsample
for i=2:3
    tim_YCbCr5(:,:,i)=resample(tim_YCbCr4(:,:,i),2,1,3);
    tim_YCbCr6(:,:,i)=tim_YCbCr5(:,:,i)';
    tim_YCbCr7(:,:,i)=resample(tim_YCbCr6(:,:,i),2,1,3);
    tim_YCbCr8(:,:,i)=tim_YCbCr7(:,:,i)';  
end
tim_YCbCr8(:,:,1)=tim_YCbCr(:,:,1);
tim_RGB=ictYCbCr2RGB(tim_YCbCr8);
figure
subplot(1,2,1);
imshow(tim);
title('original image');
subplot(1,2,2);
imshow(tim_RGB);
title('reconstructed image');

%bitrate
[height,width,dim]=size(tim);
bitrate=(height*width+1/4*(height*width)+1/4*(height*width))*8/(width*height);

%PSNR
mse=calcMSE(height,width,dim,tim,tim_RGB);
PSNR=round(calcPSNR(mse,1));

fprintf('The Bitrate is %d b/p \n', bitrate);
fprintf('The PSNR is %d dB',PSNR);
