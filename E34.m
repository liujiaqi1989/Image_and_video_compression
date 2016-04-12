clc
clear all
close all
tic
path(path,'encoder')            % make the encoder-functions visible to matlab
path(path,'decoder')            % make the encoder-functions visible to matlab
path(path,'analysis')           % make the encoder-functions visible to matlab
load huffman.mat;
im=double(imread('data/images/lena_small.tif'));
im2=double(imread('data/images/lena.tif'));
[h1,w1,d1]=size(im);
[h,w,d]=size(im2);
[im1,codebook]=VQ(im,8,2,2,0.1);
im3=QuanVQ(im2,codebook,2,2);

pmf=hist(im1(:),-500:500);
in_pmf=pmf/sum(pmf)+eps;
[ BinaryTree, HuffCode, BinCode, Codelengths] = buildHuffman(in_pmf);

bytestream1 = enc_huffman( im3(:)+1 , BinCode, Codelengths);
RecieveData = reshape(dec_huffman(bytestream1,BinaryTree,(h/2)*(w/2)*3)-1,h/2,w/2,3);
Im_reconst = zeros(h,w,d);
for k = 1:d
    for i = 1:h/2
        for j = 1:w/2
            Im_reconst(2*i-1,2*j-1,k) = codebook(RecieveData(i,j,k)+1,1);
            Im_reconst(2*i-1,2*j,k) = codebook(RecieveData(i,j,k)+1,2);
            Im_reconst(2*i,2*j-1,k) = codebook(RecieveData(i,j,k)+1,3);
            Im_reconst(2*i,2*j,k) = codebook(RecieveData(i,j,k)+1,4);
             
        end
    end
end

br=8*length(bytestream1)/(h*w*3);
mse2=calcMSE(h,w,d,im2/256,Im_reconst/256);
PSNR1=calcPSNR(mse2,1);
toc
figure
subplot(1,2,1)
imshow(im2/256)
title('Original Lena small')

subplot(1,2,2)
imshow(Im_reconst/256)
title('Reconstructed Lena using Vector Quantization')