function [im_qt,codebook]=VQ(im,M,m,n,e)
[h,w,d]=size(im);

%initialize the codebook
num=2^M;
dis=256/num;
ege_value=zeros(num+1,1);
ege_value(1)=0;
ege_value(num+1)=256;
for i=2:num
    ege_value(i)=ege_value(i-1)+dis;
end
indice=zeros(2,num);
indice(1,1:num)=0:(num-1);
for i=1:num
    indice(2,i)=1/2*(ege_value(i)+ege_value(i+1));
end
im_index=zeros(h/m,w/n,d);
codebook=zeros(num,2*m*n+1);
for i=1:m*n
codebook(:,i)=indice(2,:);
end
err_test=zeros(num,1);
d_initial=0;
x=1;
d1=1/eps;

%minimize the distortion
while  x~=0
    x=x+1;
for k=1:d
    for i=1:m:h-m+1
        for j=1:n:w-n+1
            traindata=reshape(im(i:i+m-1,j:j+m-1,k)',1,m*n); %get the triandata of the image
            for a=1:num
            err_test(a,1)=sum((traindata-codebook(a,1:4)).^2);
            end
            
            [r,~]=find(err_test==min(err_test),1);

            index=r-1;
            im_index(floor(i/m)+1,floor(j/n)+1,k)=index;
            codebook(index+1,m*n+1:m*n+m*n)=codebook(index+1,m*n+1:m*n+m*n)+traindata;
            codebook(index+1,m*n+m*n+1)=codebook(index+1,m*n+m*n+1)+1; 
            d_initial=d_initial+min(err_test);
        end
    end
end
d2=d_initial;
if abs(d2-d1)/d2<e
    break
end

%update the codebook of the non-zero cells
for i=1:num
if codebook(i,2*m*n+1)~=0
   codebook(i,1:m*n)=codebook(i,m*n+1:2*m*n)/codebook(i,2*m*n+1);
end
end

%update the codebook of the zero cells
while ~isempty(find(codebook(:,m*n*2+1)==0,1))
    [pf,~]=find(codebook(:,m*n*2+1)==0,1);
    [pm,~]=find(codebook(:,m*n*2+1)==max(codebook(:,m*n*2+1)),1);
    codebook(pf,:)=codebook(pm,:);
    codebook(pf,m*n)=codebook(pf,m*n)+1;
    codebook(pf,m*n+m*n+1)=floor((codebook(pf,m*n+m*n+1)+1)/2);
    codebook(pm,m*n+m*n+1)=floor(codebook(pm,m*n+m*n+1)/2);
end


% reset the codebook
codebook(:,m*n+1:2*m*n)=0;
codebook(:,2*m*n+1)=0;
d1=d2;
end

im_qt=im_index;
end