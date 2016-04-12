function [im_qt,d2]=LloydMax3_new(im,M,e)
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
d1=0;
d2=1;
%%
while abs(d2-d1)/d2>e
d1=d2;
a=0;
for k=1:d
    for i=1:h
        for j=1:w
           % index=floor(im(i,j,k)/dis);
           err=abs(codebook(:,1)-im(i,j,k));%Choose the interval
           [r,~]=find(err==min(err),1);
           index=r-1;
           im_index(i,j,k)=index;
           codebook(index+1,2)=codebook(index+1,2)+im(i,j,k);
           codebook(index+1,3)=codebook(index+1,3)+1;
           a=a+(im(i,j,k)-codebook(index+1,1))^2;
           d2=a;
        end
    end
end
%%
%update the codebook of the non-zero cells
for i=1:num
if codebook(i,3)~=0
   codebook(i,1)=codebook(i,2)./codebook(i,3);
end
end

%update the codebook of the zero cells
while ~isempty(find(codebook(:,3)==0,1))
    [pf,~]=find(codebook(:,3)==0,1);
    [pm,~]=find(codebook(:,3)==max(codebook(:,3)),1);
    codebook(pf,:)=codebook(pm,:);
    codebook(pf,1)=codebook(pf,1)+1;
    codebook(pf,3)=floor((codebook(pf,3)+1)/2);
    codebook(pm,3)=floor(codebook(pm,3)/2);
end
codebook(:,2)=0;
codebook(:,3)=0;

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



