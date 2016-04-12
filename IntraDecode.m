function [im]=IntraDecode(bytestream,BinaryTree,L,db,h,w,d,factor)
zr=dec_huffman(bytestream,BinaryTree,L)-500-1;
im_block=zeros(8,8,db);
a=1;
b=1;
for i=1:L
    if zr(1,i)==1000
        zrb=zr(1,a:i);
        a=1+i;
        im_c_q_V=ZeroRunDec(zrb,8,8,1);
        im_block(:,:,b)=DeZigZag8x8(im_c_q_V);
        b=b+1;
    end
end
for i=1:db/d
block_q(:,:,1)=im_block(:,:,i);
block_q(:,:,2)=im_block(:,:,i+db/d);
block_q(:,:,3)=im_block(:,:,i+2*db/d);
block_q=DeQuant8x8(block_q,factor);
im_block(:,:,i)=block_q(:,:,1);
im_block(:,:,i+db/d)=block_q(:,:,2);
im_block(:,:,i+2*db/d)=block_q(:,:,3);
end
for i=1:db
    im_block(:,:,i)=IDCT8x8(im_block(:,:,i));
end
im=Invblock(im_block,h,w,d,8);
end