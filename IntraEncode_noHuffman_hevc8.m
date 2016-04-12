function [zr,L]=IntraEncode_noHuffman_hevc8(im,QP,M)
load dct_hevc;
[h,w,d]=size(im);
[im_block,h,w]=block_splitter(im,8);
[hb,wb,db]=size(im_block);
for i=1:db
    im_block(:,:,i)=dct8_in*im_block(:,:,i)*dct8_in'*2^(-(8+2*M-3));
     im_block(:,:,i)=Quant_hevc(im_block(:,:,i),QP,M);
end
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
L=length(zr);
end