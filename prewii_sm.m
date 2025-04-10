function [result,index]=prewii_sm(img,number,yuan_num,dist)
refimg=img{1,yuan_num};
rg=rgb2gray(refimg);
bw1=edge(rg,'sobel');
[r1,l1]=size(bw1);
prewii=1:number;
for ii=1:number
    tempimg=img{1,ii};
    rt=rgb2gray(tempimg);
    bw2=edge(rt,'sobel');
    [r2,l2]=size(bw2);
    tempmat=max(r1,r2);
    tempnat=max(l1,l2);
    destemp1=zeros(tempmat,tempnat);
    destemp2=zeros(tempmat,tempnat);
    for i=1:r1
        for j=1:l1
            destemp1(i,j)=bw1(i,j);
        end
    end
    for k=1:r2
        for d=1:l2
            destemp2(k,d)=bw2(k,d);
        end
    end
    if dist==1
        prewii(ii)=norm(destemp1-destemp2,1);
    else
         prewii(ii)=norm(destemp1-destemp2,2);
    end
end       
[result,index]=sort(prewii,'ascend');
end