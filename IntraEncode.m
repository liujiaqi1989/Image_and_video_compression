function [bytestream,L,db]=IntraEncode(im,BinCode,Codelengths,factor)
[h,w,d]=size(im);
[im_block,h,w]=block_splitter(im,8);
[hb,wb,db]=size(im_block);
for i=1:db
    im_block(:,:,i)=DCT8x8(im_block(:,:,i));
end
for i=1:db/d
block_q(:,:,1)=im_block(:,:,i);
block_q(:,:,2)=im_block(:,:,i+db/d);
block_q(:,:,3)=im_block(:,:,i+2*db/d);
block_q=Quant8x8(block_q,factor);
im_block(:,:,i)=block_q(:,:,1);
im_block(:,:,i+db/d)=block_q(:,:,2);
im_block(:,:,i+2*db/d)=block_q(:,:,3);
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
bytestream = enc_huffman( zr+501 , BinCode, Codelengths);
end