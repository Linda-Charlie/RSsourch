function [result,index] = glcm_sm(img,yuan_num,number,dist)
%灰度共生矩阵特征
%读取检索图像计算灰度共生矩阵特征
si=img{1,yuan_num}; %获取检索图像
si_img=rgb2gray(si); %检索图像灰度化处理
%灰度共生矩阵
refglcm1=graycomatrix(si_img,'Offset',[0,1]); %0°
refglcm2=graycomatrix(si_img,'Offset',[-1,1]); %45°
refglcm3=graycomatrix(si_img,'Offset',[-1,0]); %90°
refglcm4=graycomatrix(si_img,'Offset',[-1,-1]); %135°
%灰度共生矩阵特征值
refstats1=graycoprops(refglcm1); 
refstats2=graycoprops(refglcm2); 
refstats3=graycoprops(refglcm3); 
refstats4=graycoprops(refglcm4); 
%建立灰度共生矩阵特征值矩阵
f11=[refstats1.Contrast refstats2.Contrast refstats3.Contrast refstats4.Contrast];
f12=[refstats1.Correlation refstats2.Correlation refstats3.Correlation refstats4.Correlation];
f13=[refstats1.Energy refstats2.Energy refstats3.Energy refstats4.Energy];
f14=[refstats1.Homogeneity refstats2.Homogeneity refstats3.Homogeneity refstats4.Homogeneity];
%逐个读取搜索路径下所有图像计算各自灰度共生矩阵特征
glcmnorm=zeros(number,1);
for ii=1:number
    img_temp=img{1,ii};
    imgGray=rgb2gray(img_temp); %灰度化处理
    %灰度共生矩阵
    glcm1=graycomatrix(imgGray,'Offset',[0,1]); %0°
    glcm2=graycomatrix(imgGray,'Offset',[-1,1]); %45°
    glcm3=graycomatrix(imgGray,'Offset',[-1,0]); %90°
    glcm4=graycomatrix(imgGray,'Offset',[-1,-1]); %135°
    %灰度共生矩阵特征值矩阵
    stats1=graycoprops(glcm1);
    stats2=graycoprops(glcm2);
    stats3=graycoprops(glcm3);
    stats4=graycoprops(glcm4);
    %建立灰度共生矩阵特征值矩阵
    f21=[stats1.Contrast stats2.Contrast stats3.Contrast stats4.Contrast];
    f22=[stats1.Correlation stats2.Correlation stats3.Correlation stats4.Correlation];
    f23=[stats1.Energy stats2.Energy stats3.Energy stats4.Energy];
    f24=[stats1.Homogeneity stats2.Homogeneity stats3.Homogeneity stats4.Homogeneity];
    if dist==1
        %分别计算四个特征矩阵距离
        n1=norm(f11-f21,1);
        n2=norm(f12-f22,1);
        n3=norm(f13-f23,1);
        n4=norm(f14-f24,1);
        %取平均值
        glcmnorm(ii)=(n1+n2+n3+n4)/4;
    elseif dist==2
        %分别计算四个特征矩阵距离
        n1=norm(f11-f21,2);
        n2=norm(f12-f22,2);
        n3=norm(f13-f23,2);
        n4=norm(f14-f24,2);
        %取平均值
        glcmnorm(ii)=(n1+n2+n3+n4)/4;
    end
end

if dist==3
    [result,index]=sort(glcmnorm,1,'descend');
else
    [result,index]=sort(glcmnorm,1,'ascend');
end
end