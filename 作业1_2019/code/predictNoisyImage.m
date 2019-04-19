function predictMat = predictNoisyImage(img)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
img = rgb2gray(img);

img = myfilter(img);
predictMat = zeros(2,8);
[height, width] = size(img);
for m=1:2
    for n=1:8
        if m==1
            img_roi = img((m-1)*height/2+5-5*(n>5)+1+5*(n==7):m*height/2+7-7*(n>5),floor((n-1)*width/8+1+7*(n==7)):floor(n*width/8)-2+4*(n==7));
        else
            img_roi = img((m-1)*height/2+7:m*height/2,floor((n-1)*width/8+1):floor(n*width/8)-2);
        end
        img_roi = im2bw(img_roi,0.6);
        img_roi = processScratch(img_roi);
        if(mean(mean(img_roi))>0.93)
            predictMat(m,n) = inf;
        else
            img_roi = selectROI(img_roi);
            predictMat(m,n) = predictNum(img_roi);
        end
    end
end
end