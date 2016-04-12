function [im_c_q]=Quant_hevc(im_c,QP,M)
f=[26214,23302,20560,18396,16384,14564];
im_c_q=round(im_c*f(1,mod(QP,6)+1)*2^(-floor(QP/6))*2^(-(29-M-8)));
end