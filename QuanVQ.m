function [im_index]=QuanVQ(im,codebook,m,n)
[h,w,d]=size(im);
[num,~]=size(codebook);
err_test=zeros(num,1);
im_index=zeros(h/m,w/n,d);

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
            
        end
    end
end
end