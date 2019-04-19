function [ num ] = predictNum( img )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
num = inf;
max_corr = 0;
for k=0:9
    if k==5 || k==7
        continue
    end
    temp = imread(['../train_bw/',num2str(k),'.bmp']);
    [h1,w1] = size(temp);
    [h2,w2] = size(img);
    img = imresize(img, [min(h1,h2),min(w1,w2)]);
    temp = imresize(temp, [min(h1,h2),min(w1,w2)]);
    temp = double(temp);
    img = double(img);
    corr = corr2(temp,img);
    if corr > max_corr
        max_corr = corr;
        num = k;
    end
end


end

