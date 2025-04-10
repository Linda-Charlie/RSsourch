function [result,index] = my_filter_sm(img,number,yuan_num,dist)
%滤波器特征
%读取检索图像
refimg=img{1,yuan_num}; %读取检索图像
%图像大小归一化
[m,n,~]=size(refimg);
%如果图像不满足256*256，则对图像进行扩展
if m<256||n<256
    for i=1:256
        for j=1:256
            if i-m>0||j-n>0
                refimg(i,j,1)=0;
                refimg(i,j,2)=0;
                refimg(i,j,3)=0;
            end
        end
    end
end
%canny算子提取边缘，得到二值图像
reffilteredimg=edge(refimg(:,:,1),'canny',[0.032,0.08],3);

%逐个读取搜索路径下所有图像
graynorm=zeros(number,1);
minus1=zeros(256,256);
for ii=1:number %图像名
    img_temp=img{1,ii}; %逐个读取图像
    %图像大小归一化
    [m,n,~]=size(img_temp);
    if m<256||n<256
        for i=1:256
            for j=1:256
                if i-m>0||j-n>0
                    img_temp(i,j,1)=0;
                    img_temp(i,j,2)=0;
                    img_temp(i,j,3)=0;
                end
            end
        end
    end
    %canny算子提取边缘，得到二值图像
    filteredimg=edge(img_temp(:,:,1),'canny',[0.032,0.08],3);
    
    for i=1:256
        for j=1:256
            if filteredimg(i,j)==1&&reffilteredimg(i,j)==1
                minus1(i,j)=1;
            end
        end
    end
    
    if dist==1
        graynorm(ii)=norm(minus1,1);
    elseif dist==2
        graynorm(ii)=norm(minus1,2);
    end
end

%排序
[result,index]=sort(graynorm,1,'descend');%返回索引即可
end