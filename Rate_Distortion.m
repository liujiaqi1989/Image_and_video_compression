
clear all
close all
clc
figure
title('Rate-Distortion performance of selected experiments of the first Chapter');
xlabel('x:bit/pixel');
ylabel('y:PSNR');
axis([0 20 10 50]);
hold on
smandril_st=plot(8,16.6,'+b');
text(8,16.6,'samndril.tif-starting algorithm');
lena_st=plot(8,15.4,'+b');
text(8,15.4,'lena.tif-starting algorithm');
sail_st=plot(8,17.0,'+b');
text(8,17.0,'monarch.tif-starting algorithm');
chrominance_sail=plot(12,47,'+b');
text(12,47,'sail.tif-Chrominance subsampling');
sail_cif=plot(6,29,'+b');
text(6,29,'sail.tif-RGB-sbusampling(CIF)');
sail_qcif=plot(2,24,'+b');
text(2,24,'sail.tif-RGB-subsampling(QCIF)');
hold off

