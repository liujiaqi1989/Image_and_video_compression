function [im_qt,d2]=LloydMax3(im,M,e)
[h,w,d]=size(im);
num=2^M;
dis=256/num;
ege_value=zeros(num+1,1);
ege_value(1)=0;
ege_value(num+1)=255;
for i=2:num
    ege_value(i)=ege_value(i-1)+dis;
end
indice=zeros(2,num);
indice(1,1:num)=0:(num-1);
for i=1:num
    indice(2,i)=round(1/2*(ege_value(i)+ege_value(i+1)));
end
im_index=zeros(h,w,d);
codebook=zeros(num,3);
codebook(:,1)=indice(2,:);
n=1;
% MSE=0;
d_initial=0;
for k=1:d
    for i=1:h
        for j=1:w
            index=floor(im(i,j,k)/dis);
            im_index(i,j,k)=index;
            codebook(index+1,2)=codebook(index+1,2)+im(i,j,k);
            codebook(index+1,3)=codebook(index+1,3)+1;
            d_initial=d_initial+(im(i,j,k)-codebook(index+1,1))^2;
        end
    end
end
d1=d_initial;
codebook(:,1)=round(codebook(:,2)./codebook(:,3));
codebook(:,2)=0;
codebook(:,3)=0;

while n~=0
    n=n+1
a=0;
for k=1:d
    for i=1:h
        for j=1:w
           % index=floor(im(i,j,k)/dis);
           err=abs(codebook(:,1)-im(i,j,k));
           [r,c]=find(err==min(err));
           [p,q]=size(r);
           if double(p)<=1
           index=r-1;
           else
               index=r(1,1)-1;
           end
            im_index(i,j,k)=index;
            codebook(index+1,2)=codebook(index+1,2)+im(i,j,k);
            codebook(index+1,3)=codebook(index+1,3)+1;
            a=a+(im(i,j,k)-codebook(index+1,1))^2;
            d2=a;
        end
    end
end
if abs(d2-d1)/d2<=e
    break
end
codebook(:,1)=round(codebook(:,2)./codebook(:,3));
codebook(:,2)=0;
codebook(:,3)=0;
d1=d2;
end
im_qt=zeros(h,w,d);
for k=1:d
for i=1:h
  for j=1:w
  im_qt(i,j,k)=codebook(im_index(i,j,k)+1,1);
  end
end
end

end



