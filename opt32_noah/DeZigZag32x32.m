function [im_c_q]=DeZigZag32x32(im_c_q_V)
load zigzag32

P=zigzag32;
im_c_q=zeros(32,32);

for i=1:32
    for j=1:32
    im_c_q(i,j)=im_c_q_V(P(i,j));
    end
end
end