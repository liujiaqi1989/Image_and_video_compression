clc
clear all
close all

path(path,'encoder')            % make the encoder-functions visible to matlab
path(path,'decoder')            % make the encoder-functions visible to matlab
path(path,'analysis')           % make the encoder-functions visible to matlab

%factor=1;
factor = [0.2,0.4,0.5,0.6,0.8,1,1.2,1.5,2];
BR_t=zeros(1,9);
PSNR_t=zeros(1,9);
for k=1:numel(factor)
im=double(imread('foreman/foreman0020.bmp'));
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
block_q=Quant8x8(block_q,factor(k));
im_block(:,:,i)=block_q(:,:,1);
im_block(:,:,i+db/d)=block_q(:,:,2);
im_block(:,:,i+2*db/d)=block_q(:,:,3);
end
im_c_q_V=zeros(1,8*8);
a=1;
zrl=zeros(1,h*w*d);
for i=1:db
im_c_q_V=ZigZag8x8(im_block(:,:,i));
zre=ZeroRunEnc(im_c_q_V,8,8,1);
l=length(zre);
zrl(1,a:a+l-1)=zre;
a=a+l;
end
for i=h*w*d:-1:1
    if zrl(1,i)>0
        zr=zrl(1,1:i);
        break
    end
end
pmf=hist(zr,-500:1000);
in_pmf=pmf/sum(pmf)+eps;
[BinaryTree, HuffCode, BinCode, Codelengths] = buildHuffman(in_pmf);
im_lenna=double(imread('foreman/foreman0020.bmp'));
[hl,wl,dl]=size(im_lenna);
im_lenna_YCbCr=ictRGB2YCbCr(im_lenna);
[bytestream,L,dc]=IntraEncode(im_lenna_YCbCr,BinCode, Codelengths,factor(k));
br=8*length(bytestream)/(hl*wl);
im_r=IntraDecode(bytestream,BinaryTree,L,dc,hl,wl,dl,factor(k));
im_re=ictYCbCr2RGB(im_r);
figure
subplot(1,2,1)
imshow(im_lenna/256);
subplot(1,2,2)
imshow(im_re/256);
mse1=calcMSE(hl,wl,dl,im_lenna/256,im_re/256);
PSNR1=calcPSNR(mse1,1);


%Inter mode
fileType = '*.bmp';
file_doc = 'foreman';
ImageSequence = dir([file_doc '/' fileType])';
NumImage = length(ImageSequence);
%Initialization
for i = 1 : NumImage
    ImageSequence(i).Image_loc = [file_doc '\' ImageSequence(i).name];
    ImageSequence(i).Im_Original = double(imread(ImageSequence(i).Image_loc));
    ImageSequence(i).Im_ict = ictRGB2YCbCr(ImageSequence(i).Im_Original);
    ImageSequence(i).Im_Re =im_r;
    ImageSequence(i).Im_Reconstruct=im_re;
end
PSNR=zeros(1,21);
BR=zeros(1,21);
PSNR(1,1)=PSNR1;
BR(1,1)=br;
MV=zeros(h*w/64,2);
MV_m_re=zeros(h/8,w/8,2);

for i=2:NumImage
    if i==2;
    [err_im, MV_m] = MotionEstimation(ImageSequence(i).Im_ict,ImageSequence(i-1).Im_Re,8);
    [zr,L1]=IntraEncode_noHuffman(err_im,factor(k));
    pmf1=hist(zr,-500:1000);
    in_pmf1=pmf1/sum(pmf1)+eps;
    [BinaryTree1, HuffCode1, BinCode1, Codelengths1] = buildHuffman(in_pmf1);
    bytestream1=enc_huffman(zr+501,BinCode1,Codelengths1);
    a=MV_m(:,:,1);
    b=MV_m(:,:,2);
    MV(:,1)=a(:);
    MV(:,2)=b(:);
    pmf2=hist(MV(:),-4:6);
    in_pmf2=pmf2/sum(pmf2)+eps;
    [BinaryTree2, HuffCode2, BinCode2, Codelengths2] = buildHuffman(in_pmf2);
    bytestream2=enc_huffman( MV(:)+5 , BinCode2, Codelengths2);
    L2=length(MV(:));
    BR(1,i)=8*(length(bytestream1)+length(bytestream2))/(h*w);
    err_re=IntraDecode(bytestream1,BinaryTree1,L1,db,h,w,d,factor(k));%decode mv and get the new MCP
    MV_re_v=dec_huffman(bytestream2,BinaryTree2,L2)-5;
    MV_re=reshape(MV_re_v,h*w/64,2);
    MV_m_re(:,:,1)=reshape(MV_re(:,1),h/8,w/8);
    MV_m_re(:,:,2)=reshape(MV_re(:,2),h/8,w/8);
    image_pred=MCP(ImageSequence(i-1).Im_ict,MV_m_re,8);
    ImageSequence(i).Im_Re=err_re+image_pred;
    BR(1,i)=8*(length(bytestream1)+length(bytestream2))/(h*w);
    else
    [err_im, MV_m] = MotionEstimation(ImageSequence(i).Im_ict,ImageSequence(i-1).Im_Re,8);
    a=MV_m(:,:,1);
    b=MV_m(:,:,2);
    MV(:,1)=a(:);
    MV(:,2)=b(:);
    L2=length(MV(:));
    [bytestream1,L,db]=IntraEncode(err_im,BinCode1,Codelengths1,factor(k));
    bytestream2=enc_huffman( MV(:)+5 , BinCode2, Codelengths2);
    BR(1,i)=8*(length(bytestream1)+length(bytestream2))/(h*w);
    err_re=IntraDecode(bytestream1,BinaryTree1,L,db,h,w,d,factor(k));%decode mv and get the new MCP
    MV_re_v=dec_huffman(bytestream2,BinaryTree2,L2)-5;
    MV_re=reshape(MV_re_v,h*w/64,2);
    MV_m_re(:,:,1)=reshape(MV_re(:,1),h/8,w/8);
    MV_m_re(:,:,2)=reshape(MV_re(:,2),h/8,w/8);
    image_pred=MCP(ImageSequence(i-1).Im_ict,MV_m_re,8);
    ImageSequence(i).Im_Re=err_re+image_pred;   
    end
end
for i=2:NumImage
ImageSequence(i).Im_Reconstruct = ictYCbCr2RGB(ImageSequence(i).Im_Re);
mse_r=calcMSE(h,w,d,ImageSequence(i).Im_Reconstruct/256,ImageSequence(i).Im_Original/256);
PSNR(1,i)=calcPSNR(mse_r,1);
end
Br_mean=mean(BR);
PSNR_mean=mean(PSNR);
BR_t(1,k)=Br_mean;
PSNR_t(1,k)=PSNR_mean;
end
figure('units','normalized','outerposition',[0 0 1 1])
plot(BR_t,PSNR_t,'b+-','MarkerSize',10,'LineWidth',2);
% figure
% subplot(1,2,1)
% imshow (ImageSequence(21).Im_Original/256);
% subplot(1,2,2)
% imshow(ImageSequence(21).Im_Reconstruct/256);