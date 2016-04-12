function [image_pred]=MCP_haf(image_p,MV,n)
[h,w,d]=size(image_p);

Y = resample(resample(image_p(:,:,1),2,1)',2,1)';
Cb = resample(resample(image_p(:,:,2),2,1)',2,1)';
Cr = resample(resample(image_p(:,:,3),2,1)',2,1)';

a=n+1;
Y = padarray(Y,[a,a]);
Cb = padarray(Cb,[a,a]);
Cr = padarray(Cr,[a,a]);
image_pred=zeros(h,w,d);
for x=a+1:n:w+a
    for y=a+1:n:h+a
        image_pred(y-a:y-a+n-1,x-a:x-a+n-1,1)=Y(2*y-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),1):2:2*y-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),1)+2*n-1,2*x-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),2):2:2*x-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),2)+2*n-1);
        image_pred(y-a:y-a+n-1,x-a:x-a+n-1,2)=Cb(2*y-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),1):2:2*y-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),1)+2*n-1,2*x-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),2):2:2*x-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),2)+2*n-1);
        image_pred(y-a:y-a+n-1,x-a:x-a+n-1,3)=Cr(2*y-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),1):2:2*y-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),1)+2*n-1,2*x-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),2):2:2*x-a-1+MV(ceil((y-a)/n),ceil((x-a)/n),2)+2*n-1);
    end
end

end