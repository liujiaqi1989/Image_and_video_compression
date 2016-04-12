function PSNR=calcPSNR(MSE, n)
PSNR=10*log10((2^n-1)/MSE);
end