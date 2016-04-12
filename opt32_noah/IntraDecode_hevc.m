function [im]=IntraDecode_hevc(bytestream,BinaryTree,L,db,h,w,d,QP,M)
load dct_hevc;
zr=dec_huffman(bytestream,BinaryTree,L)-500-1;
im_block=zeros(32,32,db);
a=1;
b=1;
for i=1:L
    if zr(1,i)==2000
        zrb=zr(1,a:i);
        a=1+i;
        im_c_q_V=ZeroRunDec(zrb,32,32,1);
        im_block(:,:,b)=DeZigZag32x32(im_c_q_V);
        b=b+1;
    end
end

for i=1:db
    im_block(:,:,i)=DeQuant_hevc(im_block(:,:,i),QP,M);
    im_block(:,:,i)=dct32_in'*im_block(:,:,i)*dct32_in*2^(-19);
end
im=Invblock(im_block,h,w,d,32);
end