function [im_c_q_V]=ZeroRunDec(codebook,h,w,d)
im_c_q_V=zeros(1,h*w*d);
M=length(codebook);
a=1;
i=1;
while codebook(i)<2000
    if codebook(i)~=0
        im_c_q_V(a)=codebook(i);
        a=a+1;
        i=i+1;
    end
    if codebook(i)==0
        im_c_q_V(a:a+codebook(i+1))=0;
         a=a+codebook(i+1)+1;
        i=i+2;
    end
    if i>M
        break
    end
end
end
    