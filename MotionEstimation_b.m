function [err_im, MV] = MotionEstimation_b(image_c,image_p,n)
[h,w,d]=size(image_c);
image_re= padarray(image_p(:,:,1),[2*n,2*n],'replicate');
image_cy=image_c(:,:,1);
SSD=zeros(4*n+1,4*n+1);
MV=zeros(h/n,w/n,2);
for x=1:n:w-n+1
    for y=1:n:h-n+1
        for i=-2*n:2*n
            for j=-2*n:2*n
                err=image_re((y+2*n+i):(y+2*n+i+n-1),(x+2*n+j):(x+2*n+j+n-1))-image_cy(y:(y+n-1),x:(x+n-1));
                SSD(i+2*n+1,j+2*n+1)=sum(sum(err.^2));
            end
        end
        m=min(min(SSD));
        [dy,dx]=find(SSD==m);
        MV(ceil(y/n),ceil(x/n),1)=dy(1,1)-(2*n+1);
        MV(ceil(y/n),ceil(x/n),2)=dx(1,1)-(2*n+1);
    end
end
image_pred=MCP_b(image_p,MV,n);
err_im=round(image_c-image_pred);
end


        
