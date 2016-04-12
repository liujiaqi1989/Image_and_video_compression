clear all
close all
clc
tim=double(imread ('data\images\sail.tif'))/256;
for i=1:3
    tim1(:,:,i)=resample(tim(:,:,i),1,4);
    tim2(:,:,i)=tim1(:,:,i)';
    tim3(:,:,i)=resample(tim2(:,:,i),1,4);
    tim4(:,:,i)=tim3(:,:,i)';
end
for i=1:3
   tim5(:,:,i)=resample(tim4(:,:,i),4,1);
    tim6(:,:,i)=tim5(:,:,i)';
    tim7(:,:,i)=resample(tim6(:,:,i),4,1);
    tim8(:,:,i)=tim7(:,:,i)';  
end
[height,width,dim]=size(tim);
bitrate=round((1/16*height*width+1/16*(height*width)+1/16*(height*width))*8/(width*height));

%PSNR
mse=calcMSE(height,width,dim,tim,tim8);
PSNR=round(calcPSNR(mse,1));

fprintf('The Bitrate is %d b/p \n', bitrate);
fprintf('The PSNR is %d dB',PSNR);