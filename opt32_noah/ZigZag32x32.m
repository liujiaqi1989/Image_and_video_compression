function [im_c_q_V]=ZigZag32x32(im_c_q)
load zigzag32

P=zigzag32;
    im_c_q_V(P(:))=im_c_q(:);
end