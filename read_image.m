function number= read_image(filepath)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
files=dir([filepath,'*.tif']);
%计算结构体中图像数目
number=length(files);
end