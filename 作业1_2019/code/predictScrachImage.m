function predictMat = predictScrachImage(img)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img = rgb2gray(img);
[height, width] = size(img);
predictMat = zeros(2,8);
for m=1:2
    for n=1:8
        if m==1
            img_roi = img((m-1)*height/2+1:m*height/2,floor((n-1)*width/8+1):floor(n*width/8)-2);
        else
            img_roi = img((m-1)*height/2+7:m*height/2,floor((n-1)*width/8+1):floor(n*width/8)-2);
        end
        if(mean(mean(img_roi))>160)
            img_roi = im2bw(img_roi,0.6);
        else
            img_roi = im2bw(img_roi,0.55);
        end
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