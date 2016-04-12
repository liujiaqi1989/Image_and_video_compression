clear all
close all
clc
im1=imread('data/images/lena.tif');
im=double(im1);
[h,w,d]=size(im1);

% %a
% pre_im=zeros(h,w,d);
% 
% for k=1:d
%     pre_im(:,1,k)=im(:,1,k);
%     for j=2:w
%         pre_im(:,j,k)=im(:,j-1,k);
%     end
% end
% err_im=pre_im-im;
% err_pmf=stats_marg(err_im);
% err_pmf_supp=err_pmf(err_pmf>0);
% err_H=calc_entropy(err_pmf_supp);

%b
im2=ictRGB2YCbCr(im);
pre_im2=zeros(h,w,d);
err_im2=zeros(h,w,d);
for j=1:h-1
    for k=1:w-1
pre_im2(j+1,k+1,1) = (7/8)*im2(j+1,k,1) -(1/2)*im2(j,k,1) +(5/8)*im2(j,k+1,1);
pre_im2(j+1,k+1,2) = (3/8)*im2(j+1,k,2) -(1/4)*im2(j,k,2) +(7/8)*im2(j,k+1,2);
pre_im2(j+1,k+1,3) = (3/8)*im2(j+1,k,3) -(1/4)*im2(j,k,3) +(7/8)*im2(j,k+1,3);
    end
end
err_im2=pre_im2-im2;
err_pmf2=stats_marg(err_im2);
err_H2=calc_entropy(err_pmf2);




