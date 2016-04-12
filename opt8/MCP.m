function [image_pred]=MCP(image_p,MV,n)
[h,w,d]=size(image_p);
Y=padarray(image_p(:,:,1),[4,4]);
Cb=padarray(image_p(:,:,2),[4,4]);
Cr=padarray(image_p(:,:,3),[4,4]);
image_pred=zeros(h,w,d);
for x=5:n:w+4
    for y=5:n:h+4
        image_pred(y-4:y-4+n-1,x-4:x-4+n-1,1)=Y(y+MV(ceil((y-4)/n),ceil((x-4)/n),1):y+MV(ceil((y-4)/n),ceil((x-4)/n),1)+n-1,x+MV(ceil((y-4)/n),ceil((x-4)/n),2):x+MV(ceil((y-4)/n),ceil((x-4)/n),2)+n-1);
        image_pred(y-4:y-4+n-1,x-4:x-4+n-1,2)=Cb(y+MV(ceil((y-4)/n),ceil((x-4)/n),1):y+MV(ceil((y-4)/n),ceil((x-4)/n),1)+n-1,x+MV(ceil((y-4)/n),ceil((x-4)/n),2):x+MV(ceil((y-4)/n),ceil((x-4)/n),2)+n-1);
        image_pred(y-4:y-4+n-1,x-4:x-4+n-1,3)=Cr(y+MV(ceil((y-4)/n),ceil((x-4)/n),1):y+MV(ceil((y-4)/n),ceil((x-4)/n),1)+n-1,x+MV(ceil((y-4)/n),ceil((x-4)/n),2):x+MV(ceil((y-4)/n),ceil((x-4)/n),2)+n-1);
    end
end

end