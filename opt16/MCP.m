function [image_pred]=MCP(image_p,MV,n)
[h,w,d]=size(image_p);
Y=padarray(image_p(:,:,1),[n/2,n/2]);
Cb=padarray(image_p(:,:,2),[n/2,n/2]);
Cr=padarray(image_p(:,:,3),[n/2,n/2]);
image_pred=zeros(h,w,d);
for x=n/2+1:n:w+n/2
    for y=n/2+1:n:h+n/2
        image_pred(y-n/2:y-n/2+n-1,x-n/2:x-n/2+n-1,1)=Y(y+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),1):y+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),1)+n-1,x+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),2):x+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),2)+n-1);
        image_pred(y-n/2:y-n/2+n-1,x-n/2:x-n/2+n-1,2)=Cb(y+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),1):y+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),1)+n-1,x+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),2):x+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),2)+n-1);
        image_pred(y-n/2:y-n/2+n-1,x-n/2:x-n/2+n-1,3)=Cr(y+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),1):y+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),1)+n-1,x+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),2):x+MV(ceil((y-n/2)/n),ceil((x-n/2)/n),2)+n-1);
    end
end

end