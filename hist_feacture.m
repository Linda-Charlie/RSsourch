function[count]=hist_feacture(n,image)
count=cell(1,n);
for i=1:n
    I=rgb2gray(image{1,i});
    [count{1,i},temp]=imhist(I);
end