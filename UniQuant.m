function [im_index]=UniQuant(im,M)

% im=double(im)/256;
[h,w,d]=size(im);
num=2^M;
dis=1/num;
% ege_value=zeros(num+1,1);
% ege_value(1)=0;
% ege_value(num+1)=1;
% for i=2:num
%     ege_value(i)=ege_value(i-1)+dis;
% end
% indice=zeros(2,num);
% indice(1,1:num)=0:(num-1);
% for i=1:num
%     indice(2,i)=1/2*(ege_value(i)+ege_value(i+1));
% end
im_index=zeros(h,w,d);

    for k=1:d
        for i=1:h
            for j=1:w
                im_index(i,j,k)=floor(im(i,j,k)/dis);
            end
        end
    end

end