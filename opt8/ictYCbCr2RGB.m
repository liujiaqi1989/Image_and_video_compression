function [rimage]=ictYCbCr2RGB(oimage)
Y=oimage(:,:,1);
Cb=oimage(:,:,2);
Cr=oimage(:,:,3);
R=Y+1.402*Cr;
G=Y-0.344*Cb-0.714*Cr;
B=Y+1.772*Cb;
rimage(:,:,1)=R;
rimage(:,:,2)=G;
rimage(:,:,3)=B;
end
