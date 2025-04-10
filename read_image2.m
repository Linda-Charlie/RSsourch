function img= read_image2(filepath,number)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
files=dir([filepath,'*.tif']);

for i=1:number
    fileName=strcat(filepath,files(i).name);%字符串附加
    img{i}=imread(fileName);%读取图像，并用单元数组存储每一个图像
end

end