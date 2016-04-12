function [im_qt]=InvUniQuant(im_index,M)
[h,w,d]=size(im_index);
im_qt=zeros(h,w,d);
num=2^M;
dis=1/num;
ege_value=zeros(num+1,1);
ege_value(1)=0;
ege_value(num+1)=1;
for i=2:num
    ege_value(i)=ege_value(i-1)+dis;
end
indice=zeros(2,num);
indice(1,1:num)=0:(num-1);
for i=1:num
    indice(2,i)=1/2*(ege_value(i)+ege_value(i+1));
end
for k=1:d
for i=1:h
  for j=1:w
  [a,b]=find(indice(1,:)==im_index(i,j,k));
  im_qt(i,j,k)=indice(2,b);
  end
end
end
end