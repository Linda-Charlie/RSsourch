function[result,index]=gray_sm(n,yuan_num,count,dist)%灰度直方图排序法
temp=1:n;
for ii=1:n
        if dist==1
       temp(ii)=norm(count{1,ii}-count{1,yuan_num},1);
        elseif dist==2
       temp(ii)=norm(count{1,ii}-count{1,yuan_num},2);
        else
            return
        end
end
[result,index]=sort(temp,'ascend');
end