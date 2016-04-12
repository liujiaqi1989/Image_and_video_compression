function [err_im, MV] = MotionEstimation(image_c,image_p,n)
[h,w,d]=size(image_c);
image_re= padarray(image_p(:,:,1),[n/2,n/2],'replicate');
image_cy=image_c(:,:,1);
SSD=zeros(n+1,n+1);
MV=zeros(h/n,w/n,2);
for x=1:n:w-n+1
    for y=1:n:h-n+1
        for i=-n/2:n/2
            for j=-n/2:n/2
                err=image_re((y+n/2+i):(y+n/2+i+n-1),(x+n/2+j):(x+n/2+j+n-1))-image_cy(y:(y+n-1),x:(x+n-1));
                SSD(i+n/2+1,j+n/2+1)=sum(sum(err.^2));
            end
        end
        m=min(min(SSD));
        [dy,dx]=find(SSD==m);
        MV(ceil(y/n),ceil(x/n),1)=dy(1,1)-(n/2+1);
        MV(ceil(y/n),ceil(x/n),2)=dx(1,1)-(n/2+1);
    end
end
image_pred=MCP(image_p,MV,n);
err_im=round(image_c-image_pred);
end


        
