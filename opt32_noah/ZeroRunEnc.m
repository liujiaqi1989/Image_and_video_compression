function [codebook_new2]=ZeroRunEnc(im_c_q_V,h,w,d)
codebook=zeros(1,h*w*d)+2000;
a=1;
i=1;
M=length(im_c_q_V);
while i<=M
    if im_c_q_V(i)~=0
      codebook(a)=im_c_q_V(i);
      
    end
    if im_c_q_V(i)==0
        codebook(a)=0;
        a=a+1;
        l=0;
        c=i+1;
        while c<=M
            if im_c_q_V(c)==0
               l=l+1;
                  c=c+1;
            else
                break
            end
         
        end
        codebook(a)=l;
        if l>0
            i=i+l;
        end
    end
    i=i+1;
    a=a+1;
end
codebook_new=codebook(codebook<2000);
m=length(codebook_new);
if codebook_new(m-1)==0
    codebook_new(m-1)=2000;
    codebook_new2=codebook_new(1:m-1);
else
    codebook_new2=[codebook_new,2000];
end
        

end