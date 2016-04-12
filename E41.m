clc
clear all
close all

path(path,'encoder')            % make the encoder-functions visible to matlab
path(path,'decoder')            % make the encoder-functions visible to matlab
path(path,'analysis')           % make the encoder-functions visible to matlab
im=double(imread('data/images/lena_small.tif'));
[h,w,d]=size(im);
[im2]=ictRGB2YCbCr(im);
[im_block,h,w]=block_splitter(im2,8);
[hb,wb,db]=size(im_block);
for i=1:db
    im_block(:,:,i)=DCT8x8(im_block(:,:,i));
end
for i=1:db/d
block_q(:,:,1)=im_block(:,:,i);
block_q(:,:,2)=im_block(:,:,i+db/d);
block_q(:,:,3)=im_block(:,:,i+2*db/d);
block_q=Quant8x8(block_q,1);
im_block(:,:,i)=block_q(:,:,1);
im_block(:,:,i+db/d)=block_q(:,:,2);
im_block(:,:,i+2*db/d)=block_q(:,:,3);
end
im_c_q_V=zeros(1,64*64*3);
for i=1:db
im_c_q_V((i-1)*64+(1:64))=ZigZag8x8(im_block(:,:,i));
end
zr=ZeroRunEnc(im_c_q_V,h,w,d);
pmf=hist(zr,-500:1000);
in_pmf=pmf/sum(pmf)+eps;
[BinaryTree, HuffCode, BinCode, Codelengths] = buildHuffman(in_pmf);
im_lenna=double(imread('data/images/lena.tif'));
[hl,wl,dl]=size(im_lenna);
im_lenna_YCbCr=ictRGB2YCbCr(im_lenna);
[bytestream,L,dc]=IntraEncode(im_lenna_YCbCr,BinCode, Codelengths,1);
br=8*length(bytestream)/(hl*wl*3);
im_r=IntraDecode(bytestream,BinaryTree,L,dc,hl,wl,dl,1);
im_re=ictYCbCr2RGB(im_r);
figure
subplot(1,2,1)
imshow(im_lenna/256);
subplot(1,2,2)
imshow(im_re/256);
mse=calcMSE(hl,wl,dl,im_lenna/256,im_re/256);
PSNR=calcPSNR(mse,1);