function [err_im, MV] = MotionEstimation(image_c,image_p,n)
[h,w,d]=size(image_c);
image_re= padarray(image_p(:,:,1),[4,4],'replicate');
image_cy=image_c(:,:,1);
SSD=zeros(9,9);
MV=zeros(h/n,w/n,2);
for x=1:n:w-n+1
    for y=1:n:h-n+1
        for i=-4:4
            for j=-4:4
                err=image_re((y+4+i):(y+4+i+n-1),(x+4+j):(x+4+j+n-1))-image_cy(y:(y+n-1),x:(x+n-1));
                SSD(i+5,j+5)=sum(sum(err.^2));
            end
        end
        m=min(min(SSD));
        [dy,dx]=find(SSD==m);
        MV(ceil(y/n),ceil(x/n),1)=dy(1,1)-5;
        MV(ceil(y/n),ceil(x/n),2)=dx(1,1)-5;
    end
end
image_pred=MCP(image_p,MV,n);
err_im=round(image_c-image_pred);
end


        
