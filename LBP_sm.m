function[result,index] = LBP_sm(number,img,yuan_num,dist)
%LBP特征,sim_num是想要的相似图像在文件夹中的位置数
%检索图像
siimg=rgb2gray(img{1,yuan_num});
[m,n]=size(siimg); %图像大小
refimgn=zeros(m,n); %各个像素LBP值
%计算各个像素LBP值
for i=2:m-1
    for j=2:n-2
        pow=0;
        for p=i-1:i+1
            for q=j-1:j+1
                if siimg(p,q)>siimg(i,j)
                    if p~=i||q~=j
                        refimgn(i,j)=refimgn(i,j)+2^pow;
                        pow=pow+1;
                    end
                end
            end
        end
    end
end
%将图像分为四等份，分别计算直方图
hist1=cell(1,4);
hist1{1}=imhist(refimgn(1:floor(m/2),1:floor(n/2)));
hist1{2}=imhist(refimgn(1:floor(m/2),floor(n/2)+1:n));
hist1{3}=imhist(refimgn(floor(m/2)+1:m,1:floor(n/2)));
hist1{4}=imhist(refimgn(floor(m/2)+1:m,floor(n/2)+1:n));

%逐个读取搜索路径下所有图像
LBPfa=zeros(number,1);
for ii=1:number
    if(ii==yuan_num)
        continue
    else
    img_temp=rgb2gray(img{1,ii}); %逐个读取图像
    [m,n]=size(img_temp);
    imgn=zeros(m,n);
    for i=2:m-1
        for j=2:n-2
            pow=0;
            for p=i-1:i+1
                for q=j-1:j+1
                    if img_temp(p,q)>img_temp(i,j)
                        if p~=i||q~=j
                            imgn(i,j)=imgn(i,j)+2^pow;
                            pow=pow+1;
                        end
                    end
                end
            end
        end
    end
    hist2=cell(1,4);
    hist2{1}=imhist(imgn(1:floor(m/2),1:floor(n/2)));
    hist2{2}=imhist(imgn(1:floor(m/2),floor(n/2)+1:n));
    hist2{3}=imhist(imgn(floor(m/2)+1:m,1:floor(n/2)));
    hist2{4}=imhist(imgn(floor(m/2)+1:m,floor(n/2)+1:n));
    
    if dist==1
        n1=norm(hist1{1}-hist2{1},1);
        n2=norm(hist1{2}-hist2{2},1);
        n3=norm(hist1{3}-hist2{3},1);
        n4=norm(hist1{4}-hist2{4},1);
        LBPfa(ii)=(n1+n2+n3+n4)/4;
    elseif dist==2
        n1=norm(hist1{1}-hist2{1},2);
        n2=norm(hist1{2}-hist2{2},2);
        n3=norm(hist1{3}-hist2{3},2);
        n4=norm(hist1{4}-hist2{4},2);
        LBPfa(ii)=(n1+n2+n3+n4)/4;
    else
        return;
    end
    end
end

%排序
[result,index]=sort(LBPfa,1,'ascend');

%返回前排序后的索引和结果数组
end