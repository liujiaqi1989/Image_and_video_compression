function [im_c]=DeQuant_hevc(im_c_q,QP,M)
g=[40,45,51,57,64,72];
im_c=round(im_c_q*g(1,mod(QP,6)+1)*2^(floor(QP/6))*2^(-(8+M-9)));
end