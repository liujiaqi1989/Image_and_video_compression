
function [ PREFILTERED_image ] = prefilterlowpass2d( ORIGINAL_image,W )
[height,width,dim] = size(ORIGINAL_image);
 for i = 1 :1: dim
    PREFILTERED_image (:,:,i) = conv2( ORIGINAL_image (:,:,i),W,'same');
 end
end