function MSE=calcMSE(height, width, dim, oimage, rimage)
if dim==1
MSE=sum((oimage-rimage).^2)/width*height*dim;   
end
if dim==2
MSE=sum(sum((oimage-rimage).^2))/(width*height*dim);
end
if dim==3
    MSE=sum(sum(sum((oimage-rimage).^2)))/(width*height*dim);
end
end
