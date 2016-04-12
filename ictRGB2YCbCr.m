function [rimage]=ictRGB2YCbCr(oimage)
R=oimage(:,:,1);
G=oimage(:,:,2);
B=oimage(:,:,3);
Y=0.299*R+0.587*G+0.114*B;
Cb=-0.169*R-0.331*G+0.5*B;
Cr=0.5*R-0.419*G-0.081*B;
rimage(:,:,1)=Y;
rimage(:,:,2)=Cb;
rimage(:,:,3)=Cr;
end