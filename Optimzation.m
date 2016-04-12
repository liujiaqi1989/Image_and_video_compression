clc
clear all
close all

path(path,'encoder')            % make the encoder-functions visible to matlab
path(path,'decoder')            % make the encoder-functions visible to matlab
path(path,'analysis')           % make the encoder-functions visible to matlab
load dct_hevc;
fileType = '*.bmp';
file_doc = 'foreman';
ImageSequence = dir([file_doc '/' fileType])';
NumImage = length(ImageSequence);
M=3;
%Initialization
for i = 1 : NumImage
    ImageSequence(i).Image_loc = [file_doc '\' ImageSequence(i).name];
    ImageSequence(i).Im_Original = double(imread(ImageSequence(i).Image_loc));
    ImageSequence(i).Im_ict = ictRGB2YCbCr(ImageSequence(i).Im_Original);
    ImageSequence(i).Im_Re =ImageSequence(i).Im_Original;
    ImageSequence(i).Im_Reconstruct=ImageSequence(i).Im_Original;
end
[h,w,d] = size(ImageSequence(1).Im_ict);
PSNR=zeros(1,21);
PSNR_mean=zeros(1,9);
PSNR_still=zeros(1,9);
BR=zeros(1,21);
BR_mean=zeros(1,9);
BR_still=zeros(1,9);
MV=zeros(h*w/64,2);
MV_m_re=zeros(h/8,w/8,2);

k=1;
for QP=40:-4:20

    for j = 1 :NumImage
        if j==1
[im_block,~, ~]=block_splitter(ImageSequence(j).Im_ict,8);
[hb,wb,db]=size(im_block);
for i=1:db
    im_block(:,:,i)=dct8_in*im_block(:,:,i)*dct8_in'*2^(-11);
     im_block(:,:,i)=Quant_hevc(im_block(:,:,i),QP,M);
end



% im_c_q_V=zeros(1,8*8);
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
L=length(zr);
bytestream = enc_huffman( zr+501 , BinCode, Codelengths);
BR(1,j)=8*length(bytestream)/(h*w);
ImageSequence(j).Im_Re =IntraDecode_hevc8(bytestream,BinaryTree,L,db,h,w,d,QP,M);
ImageSequence(j).Im_Reconstruct=ictYCbCr2RGB(ImageSequence(j).Im_Re);
mse1=calcMSE(h,w,d,ImageSequence(j).Im_Original/256,ImageSequence(j).Im_Reconstruct/256);
PSNR(1,j)=calcPSNR(mse1,1); 
BR_still(1,k)=BR(1,j);
PSNR_still(1,k)=PSNR(1,j);
        else
            [err_im, MV_m] = MotionEstimation(ImageSequence(j).Im_ict,ImageSequence(j-1).Im_Re,8);
            [zr1,L1]=IntraEncode_noHuffman_hevc8(err_im,QP,M);
            %Build huffmancode of err_im
            pmf1=hist(zr,-500:1000);
            in_pmf1=pmf1/sum(pmf1)+eps;
            [BinaryTree1, HuffCode1, BinCode1, Codelengths1] = buildHuffman(in_pmf1);
            bytestream1=enc_huffman(zr1+501,BinCode1,Codelengths1);
            a=MV_m(:,:,1);
            b=MV_m(:,:,2);
            MV(:,1)=a(:);
            MV(:,2)=b(:);
            pmf2=hist(MV(:),-4:6);
            in_pmf2=pmf2/sum(pmf2)+eps;
            [BinaryTree2, HuffCode2, BinCode2, Codelengths2] = buildHuffman(in_pmf2);
            bytestream2=enc_huffman( MV(:)+5 , BinCode2, Codelengths2);
            L2=length(MV(:));
            BR(1,j)=8*(length(bytestream1)+length(bytestream2))/(h*w);
            err_re=IntraDecode_hevc8(bytestream1,BinaryTree1,L1,db,h,w,d,QP,M);%decode mv and get the new MCP
            MV_re_v=dec_huffman(bytestream2,BinaryTree2,L2)-5;
            MV_re=reshape(MV_re_v,h*w/64,2);
            MV_m_re(:,:,1)=reshape(MV_re(:,1),h/8,w/8);
            MV_m_re(:,:,2)=reshape(MV_re(:,2),h/8,w/8);
            image_pred=MCP(ImageSequence(j-1).Im_Re,MV_m_re,8);
            ImageSequence(j).Im_Re=err_re+image_pred;
            ImageSequence(j).Im_Reconstruct = ictYCbCr2RGB(ImageSequence(j).Im_Re);
            mse_r=calcMSE(h,w,d,ImageSequence(j).Im_Reconstruct/256,ImageSequence(j).Im_Original/256);
            PSNR(1,j)=calcPSNR(mse_r,1);
        end
       
    end
       PSNR_mean(1,k)=mean(PSNR);
       BR_mean(1,k)=mean(BR);
       k=k+1;
end


figure('units','normalized','outerposition',[0 0 1 1])
hold on
plot(BR_mean,PSNR_mean,'b+-','MarkerSize',10,'LineWidth',2);
plot(BR_still,PSNR_still,'r+-','MarkerSize',10,'LineWidth',2);