function[img2,num]=democo(img,ind,number)%点选反馈
num=number-1;
img2=cell(1,num);%为单元数组预分配内存
for ii=1:number%是由于索引必须从2开始，所以-1后不可能出现为0的情况
    if ii<ind
        img2{1,ii}=img{1,ii}; 
    elseif ii==ind
        continue;
    else
        img2{1,ii-1}=img{1,ii};
    end
end