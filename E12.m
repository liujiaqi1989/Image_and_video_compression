clear all
close all
clc
path( path, 'data/images' );
%frequency response of filter
W1=[1,2,1;2,4,2;1,2,1];
W1=W1/(sum(sum(W1)));   %normalization
fr=fft2(W1);            %frequency response
frs=fftshift(fr);       %adjust the frequency response
figure
subplot(1,2,1);
surf(abs(fr));
title('fft2 frequency response');
subplot(1,2,2);
surf(abs(frs));
title('fftshift frequency response');
saveas(gcf,'data\results\Prefilter.fig');
%filter the test image
tim=double(imread ('satpic1.bmp'))/256;
[height,width,dim]=size(tim);
ptim=prefilterlowpass2d(tim,W1);    %filter the original image
figure
subplot(2,2,1);
imshow( tim, [0 1] );
title('Unfiltered image');
subplot(2,2,2);
imshow( ptim, [0 1] );
title('Filtered image');

%subsample the image
ptim=downsample(ptim,2);
ptim=permute(ptim,[2,1,3]);
ptim=downsample(ptim,2);
ptim=permute(ptim,[2,1,3]);
[dheight,dwidth,ddim]=size(ptim);
subplot(2,2,3);
imshow(ptim,[0 1]);
title('downsampled image');
ptim=upsample(ptim,2);
ptim=permute(ptim,[2,1,3]);
ptim=upsample(ptim,2);
ptim=permute(ptim,[2,1,3]);
[uheight,uwidth,udim]=size(ptim);
subplot(2,2,4);
imshow(ptim,[0 1]);
title('upsampled image');

%PSNR mit prefilter
prtim=prefilterlowpass2d(ptim,W1)*4;
pmse=calcMSE(height,width,dim,tim,prtim);
ppsnr=calcPSNR(pmse,1);
figure
subplot(1,3,1);
imshow(tim,[0 1]);
title('Original image')
subplot(1,3,2);
imshow(prtim,[0 1]);
title('Prefiltered image')

wtim=tim;
wtim=downsample(wtim,2);
wtim=permute(wtim,[2,1,3]);
wtim=downsample(wtim,2);
wtim=permute(wtim,[2,1,3]);
wtim=upsample(wtim,2);
wtim=permute(wtim,[2,1,3]);
wtim=upsample(wtim,2);
wtim=permute(wtim,[2,1,3]);
wrtim=prefilterlowpass2d(wtim,W1)*4;
wmse=calcMSE(height,width,dim,tim,wrtim);
wpsnr=calcPSNR(wmse,1);
subplot(1,3,3);
imshow(wrtim,[0 1]);
title('Image without prefilter');

fprintf('The PSNR of prefiltered image is %f dB\n', ppsnr);
fprintf('The PSNR of unprefiltered image is %f dB',wpsnr);





