function [center]= demoforkmeans(N,des)
%为了实现sift算法辨析相似度写的kmeans聚类
%N为聚类数量
[m,n]=size(des);%表示矩阵data大小，m行n列
pattern=zeros(m,n+1);%生成0矩阵
center=zeros(N,n);%初始化聚类中心
pattern(:,1:n)=des(:,:);
for x=1:N
    center(x,:)=des( randi(300,1),:);%第一次随机产生聚类中心
end
while 1 %循环迭代每次的聚类簇；
    distence=zeros(1,N);%最小距离矩阵
    num=zeros(1,N);%聚类簇数矩阵
    new_center=zeros(N,n);%聚类中心矩阵
    
    for x=1:m
        for y=1:N
            distence(y)=norm(des(x,:)-center(y,:));%计算到每个类的距离
        end
        [~, temp]=min(distence);%求最小的距离
        pattern(x,n+1)=temp;%划分所有对象点到最近的聚类中心；标记为1,2,3；
    end
    k=0;
    for y=1:N
        for x=1:m
            if pattern(x,n+1)==y
                new_center(y,:)=new_center(y,:)+pattern(x,1:n);
                num(y)=num(y)+1;
            end
        end
        new_center(y,:)=new_center(y,:)/num(y);%求均值，即新的聚类中心；
        if norm(new_center(y,:)-center(y,:))<0.1%检查集群中心是否已收敛。如果是则终止。
            k=k+1;
        end
    end
    if k==N
        break;
    else
        center=new_center;
    end
end
