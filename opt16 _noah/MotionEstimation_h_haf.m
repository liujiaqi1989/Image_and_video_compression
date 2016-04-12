function [err_im, MV] = MotionEstimation_h_haf(image_c,image_p,n)
[h,w,d]=size(image_c);
image_r = resample(resample(image_p(:,:,1),2,1)',2,1)';
a=n+1;
image_re= padarray(image_r(:,:,1),[a,a],'replicate');
image_cy=image_c(:,:,1);
SSD=zeros(1,23);
SSD1=zeros(3,3);
MV=zeros(h/n,w/n,2);
ddx=2*[-8,-4,-4,-4,-4,-2,-1,-1,-1,0,0,0,0,0,1,1,1,2,4,4,4,4,8];
ddy=2*[0,8,4,-4,-8,0,2,0,-2,4,1,0,-1,-4,2,0,-2,0,8,4,-4,-8,0];
for x=1:n:w-n+1
    for y=1:n:h-n+1
        for i=1:23  
            err=image_re((2*y-1+a+ddy(i)):2:(2*y-1+a+ddy(i)+2*n-1),(2*x-1+a+ddx(i)):2:(2*x-1+a+ddx(i)+2*n-1))-image_cy(y:(y+n-1),x:(x+n-1));
            SSD(1,i)=sum(sum(err.^2));
        end
        m=min(min(SSD));
        [~,pos]=find(SSD==m);
        dy=ddy(1,pos(1));
        dx=ddx(1,pos(1));
       
        for l=-1:1
            for k=-1:1
            err1=image_re((2*y-1+a+dy+k):2:(2*y-1+a+dy+k+2*n-1),(2*x-1+a+dx+l):2:(2*x-1+a+dx+l+2*n-1))-image_cy(y:(y+n-1),x:(x+n-1));   
            SSD1(k+2,l+2)=sum(sum(err1.^2));
            end
        end
        m=min(min(SSD1));
        [k1,l1]=find(SSD1==m);
        MV(ceil(y/n),ceil(x/n),1)=dy+k1(1)-2;
        MV(ceil(y/n),ceil(x/n),2)=dx+l1(1)-2;
    end
end
image_pred=MCP_haf(image_p,MV,n);
err_im=round(image_c-image_pred);
end