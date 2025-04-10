function [index,result]=GIST_sm(img,yuan_num,number,dist)
result=zeros(1,number);
listlength=number;  %获取图片库中图片数量
GIST=double([]);
image1=img{1,yuan_num};
clear param1
param1.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param1.numberBlocks = 4;
param1.fc_prefilt = 4;
[gist1, param1] = LMgist(image1, '', param1);
for i1=1:listlength
    image=img{1,i1};
    % GIST Parameters:
    clear param
    param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
    param.numberBlocks = 4;
    param.fc_prefilt = 4;

    % Computing gist:
    [gist, param] = LMgist(image, '', param);
    GIST(i1,:)=gist;
    if(dist==1)
        result(1,i1)=norm(double(gist1-gist),1);
    else
        result(1,i1)=norm(double(gist1-gist),2);
    end
end
[result,index]=sort(result,'ascend');

end