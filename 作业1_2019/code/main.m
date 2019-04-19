clear all;close all;clc;

%%
% 获得训练集的二值图像
for k=0:9
    if k==5 || k==7
        continue;
    end
    img = imread(['../train/',num2str(k),'.bmp']);
    img_bw = imbinarize(img);
    imwrite(img_bw,['../train_bw/',num2str(k),'.bmp']);
end

%%
% 对正常图片进行识别
index = [1,2,3,4,5,6];
for i=1:length(index)
    img = imread(['../test/',num2str(index(i)),'.bmp']);
    predictMat = predictNormalImage(img);
    predictMat(2,1) = inf; predictMat(2,8) = inf;
    disp(['../test/',num2str(index(i)),'.bmp的识别结果为:']);
    disp(predictMat)
end

%%
% 对划痕图片进行识别
% img = imread('../test/处理划痕.bmp');
% predict = predictNormalImage(img);
% img = imread('../test/划痕.bmp');
% predict = predictScrachImage(img);
% disp('划痕图片识别结果为:');
% disp(predict)
% 
%%
%对噪声图片进行识别
% img = imread('../test/噪声.bmp');
% predict = predictNoisyImage(img);
% disp('噪声图片识别结果为:');
% disp(predict)
