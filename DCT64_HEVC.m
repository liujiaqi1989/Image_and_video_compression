clc
clear all
close all
for i=0:31
    for j=0:31
        if i==0
            A=1;
        else
            A=sqrt(2);
        end
        H(i+1,j+1)=A/sqrt(32)*cos(pi/32*(j+1/2)*i);
    end
end
H(1,:)=64;
H(2:32,1:32)=round(H(2:32,1:32)*64*sqrt(32));
for i=1:32
    for j=1:32
        if H(i,j)==84
            H(i,j)=83;
        end
        if H(i,j)==-84
             H(i,j)=-83;
        end
        if H(i,j)==39
              H(i,j)=38;
        end
        if H(i,j)==-39
            H(i,j)=-38;
        end
        if H(i,j)==26
            H(i,j)=25;
        end
        if H(i,j)==-26
            H(i,j)=-25;
        end
        if H(i,j)==39
            H(i,j)=38;
        end
        if H(i,j)==-39
            H(i,j)=-38;
        end
        if H(i,j)==47
            H(i,j)=46;
        end
        if H(i,j)==-47
            H(i,j)=-46;
        end
        if H(i,j)==30
            H(i,j)=31;
        end
        if H(i,j)==-30
            H(i,j)=-31;
        end
        if H(i,j)==35
            H(i,j)=36;
        end
        if H(i,j)==-35
            H(i,j)=-36;
        end
    end
end
    dct32_in=H;
    dct8_in=zeros(8,8);
    a=1;
    for i=1:4:32
        dct8_in(a,:)=H(i,1:8);
        a=a+1;
    end
    dct16_in=zeros(16,16);
    b=1;
    for i=1:2:32
        dct16_in(b,:)=H(i,1:16);
        b=b+1;
    end
        
save dct_hevc.mat dct32_in dct8_in dct16_in
%Norm measure

