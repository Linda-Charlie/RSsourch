function[result,index]=sift_sm(img,number,yuan_num,dist)
refimg=img{1,yuan_num};
grayrefimg=rgb2gray(refimg);
%用sift来提取特征
%会提示数组大小不兼容
[des1,~]=sift(grayrefimg);
[r1,l1]=size(des1);%提取的列数一致
snorm=1:number;
for ii=1:number
    timg=img{1,ii};
    graytimg=rgb2gray(timg);
    [des2,~]=sift(graytimg);
    [r2,l2]=size(des2);%提取的列数一致
    tempmat=min(r1,r2);
    destemp=zeros(tempmat,l1);
    if(r1<r2)
        for i=1:r1
            for j=1:l2
        destemp(i,j)=des2(i,j);
            end
        end
    if dist==1
        snorm(ii)=norm(destemp-des1,1);
    else
        snorm(ii)=norm(destemp-des1,2);
    end        
    else
         for i=1:r2
            for j=1:l1
        destemp(i,j)=des1(i,j);
            end
         end
    if dist==2
        snorm(ii)=norm(des2-destemp,2);
    else
        snorm(ii)=norm(des2-destemp,1);
    end        
    end
end
[index,result]=sort(snorm,'ascend');