function [image_pred]=MCP_b(image_p,MV,n)
[h,w,d]=size(image_p);
Y=padarray(image_p(:,:,1),[2*n,2*n]);
Cb=padarray(image_p(:,:,2),[2*n,2*n]);
Cr=padarray(image_p(:,:,3),[2*n,2*n]);
image_pred=zeros(h,w,d);
for x=2*n+1:n:w+2*n
    for y=2*n+1:n:h+2*n
        image_pred(y-2*n:y-2*n+n-1,x-2*n:x-2*n+n-1,1)=Y(y+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),1):y+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),1)+n-1,x+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),2):x+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),2)+n-1);
        image_pred(y-2*n:y-2*n+n-1,x-2*n:x-2*n+n-1,2)=Cb(y+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),1):y+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),1)+n-1,x+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),2):x+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),2)+n-1);
        image_pred(y-2*n:y-2*n+n-1,x-2*n:x-2*n+n-1,3)=Cr(y+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),1):y+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),1)+n-1,x+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),2):x+MV(ceil((y-2*n)/n),ceil((x-2*n)/n),2)+n-1);
    end
end

end