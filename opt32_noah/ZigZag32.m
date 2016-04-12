function [ Zigzag ] = ZigZag32()
Zigzag=zeros(32,32);
Zigzag(1,1)=1;
for k=1:31
    if (mod(k,2)~=0)
    Zigzag(1,k+1)=Zigzag(1,k)+1;
    else
    Zigzag(1,k+1)=Zigzag(1,k)+4*round(k/2);
    end
end
p=1;
for k=1:2:32
for i=1:31
        if (mod(i,2)==0)
        Zigzag(i+1,k)=Zigzag(i,k)+p;
        else
        Zigzag(i+1,k)=Zigzag(i,k)+2*i;
        end
end
p=p+4;
end

s=3;
for k=2:2:32
    for i=1:31
        if (mod(i,2)~=0)
        Zigzag(i+1,k)=Zigzag(i,k)+s;
        else
        Zigzag(i+1,k)=Zigzag(i,k)+2*i;
        end
    end
   s=s+4;
end
Zigzag(2:1:32,32:-1:2)=Zigzag(2:1:32,32:-1:2)-1;
Zigzag(3:1:32,32:-1:3)=Zigzag(3:1:32,32:-1:3)-3;
l=5;
for i=4:32
Zigzag(i:1:32,32:-1:i)=Zigzag(i:1:32,32:-1:i)-l;
l=l+2;
end
end
