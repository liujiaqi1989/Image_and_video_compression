function [err_im, MV] = MotionEstimation_h(image_c,image_p,n)
[h,w,d]=size(image_c);
image_re= padarray(image_p(:,:,1),[n/2,n/2],'replicate');
image_cy=image_c(:,:,1);
SSD=zeros(1,23);
MV=zeros(h/n,w/n,2);
ddx=[-8,-4,-4,-4,-4,-2,-1,-1,-1,0,0,0,0,0,1,1,1,2,4,4,4,4,8];
ddy=[0,8,4,-4,-8,0,2,0,-2,4,1,0,-1,-4,2,0,-2,0,8,4,-4,-8,0];
for x=1:n:w-n+1
    for y=1:n:h-n+1
        for i=1:23  
            err=image_re((y+n/2+ddy(i)):(y+n/2+ddy(i)+n-1),(x+n/2+ddx(i)):(x+n/2+ddx(i)+n-1))-image_cy(y:(y+n-1),x:(x+n-1));
            SSD(1,i)=sum(sum(err.^2));
        end
        m=min(min(SSD));
        [~,pos]=find(SSD==m);
        dy=ddy(1,pos(1));
        dx=ddx(1,pos(1));
        MV(ceil(y/n),ceil(x/n),1)=dy;
        MV(ceil(y/n),ceil(x/n),2)=dx;
    end
end
image_pred=MCP(image_p,MV,n);
err_im=round(image_c-image_pred);
end