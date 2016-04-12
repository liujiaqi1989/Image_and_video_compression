function [image_reconstruct]=subsample(image_original)
[height, width, dim]=size(image_original);
%creat a new matrix and copy the original image
image_new=padarray(image_original,[4,4],'symmetric');
%downsample
for i=1:dim
 image_new_d1(:,:,i)=resample(image_new(:,:,i),1,2,3);
end
 image_new_d2=permute(image_new_d1,[2,1,3]);
for i=1:dim
 image_new_d3(:,:,i)=resample(image_new_d2(:,:,i),1,2,3);
end
 image_new_d=permute(image_new_d3,[2,1,3]);
%cropback
[h,w,d]=size(image_new_d);
image_new2=image_new_d(3:h-2,3:w-2,:);

%wrapround
image_new3=padarray(image_new2,[2,2],'symmetric');

%upsample
for i=1:dim
   image_new3_u1(:,:,i)=resample(image_new3(:,:,i),2,1,3);
end
   image_new3_u2=permute(image_new3_u1,[2,1,3]);
for i=1:dim
   image_new3_u3(:,:,i)=resample(image_new3_u2(:,:,i),2,1,3);
end
   image_new_u=permute(image_new3_u3,[2,1,3]);

%cropback
[h,w,d]=size(image_new_u);
image_r=image_new_u(5:h-4,5:w-4,:);

image_reconstruct=image_r;


end
