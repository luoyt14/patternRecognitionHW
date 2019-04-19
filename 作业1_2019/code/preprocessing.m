function [img, x_cut, y_cut] = preprocessing(test_img)
%PREPROCESSING Summary of this function goes here
%   Detailed explanation goes here


[row,col] = size(test_img);
block_length = floor(col*0.125);
block = mat2cell(test_img,[floor(row*0.57) row-floor(row*0.57)],...
    [block_length block_length block_length block_length block_length block_length block_length col-7*block_length]);

r = [1 floor(row*0.57)+1 row];
c = [1 block_length+1 2*block_length+1 3*block_length+1 4*block_length+1 5*block_length+1 6*block_length+1 7*block_length+1 col];


for m = 1:2
   for n = 1:8 
        bg = ordfilt2(block{m,n},1,ones(3,3)); %最小值滤波提取划痕和噪声作为背景
        level = graythresh(bg);
        bg = ~im2bw(bg,level);        
        
        A = imtophat(block{m,n},strel('disk',50)); %顶帽滤波去除光照影响     
        A = ordfilt2(A,2,ones(2,2));  %中值滤波
        A = imadjust(A);  %调节图片亮度
        levelA = graythresh(A);
        A = ~im2bw(A,levelA);  %二值化
        block{m,n} = A-bg ;
    end
end

%图像分块二值化
% for m = 1:2
%     for n = 1:8
%         sub_block = block(r(m):r(m+1)-1,c(n):c(n+1)-1);
%         bg = ordfilt2(sub_block,1,ones(3,3)); %最小值滤波提取划痕和噪声作为背景
%         level = graythresh(bg);
%         bg = ~im2bw(bg,level);
%         
%         A = imtophat(sub_block,strel('disk',50)); %顶帽滤波去除光照影响
%         A = ordfilt2(A,2,ones(2,2));  %中值滤波
%         A = imadjust(A);  %调节图片亮度
%         levelA = graythresh(A);
%         A = ~im2bw(A,levelA);  %二值化
%         
%         sub_block = A-bg ;
%         block(r(m):r(m+1)-1,c(n):c(n+1)-1) = sub_block;
%     end
% end

img = ~cell2mat(block); %分块组合成一个矩阵

% for m = 1:2
%     img(r(m),:) = 1;
% end
% 
% for n = 1:8
%     img(:,c(n)) = 1;
% end

%%投影法分割数字
h1 = sum(img);  %垂直投影
h2 = sum(img,2);  %水平投影
x_cut = [1];  %垂直分割位置
y_cut = [1];  %水平分割位置
i = 2;
j = 2;

if col>200  %图片的大小与判别阈值有关
    while i<col
        if h1(i+1)-h1(i)>27 && h1(i-1)-h1(i)>27
            x_cut = [x_cut i];
        end
        i = i+1;
    end
    x_cut = [x_cut col];
    
    while j <row
        if h2(j+1)-h2(j)>90 && h2(j-1)-h2(j)>90
            y_cut = [y_cut j];
        end
        j = j+1;
    end
    y_cut = [y_cut row];
    
    
else
    while i<col
        if h1(i+1)-h1(i)>10 && h1(i-1)-h1(i)>10
            x_cut = [x_cut i];
        end
        i = i+1;
    end
    x_cut = [x_cut col];
    
    
    while j <row
        if h2(j+1)-h2(j)>70 && h2(j-1)-h2(j)>70
            y_cut = [y_cut j];
        end
        j = j+1;
    end
    y_cut = [y_cut row];
end


end

