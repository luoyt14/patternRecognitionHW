clear all;close all;clc;

%%
% ���ѵ�����Ķ�ֵͼ��
for k=0:9
    if k==5 || k==7
        continue;
    end
    img = imread(['../train/',num2str(k),'.bmp']);
    img_bw = imbinarize(img);
    imwrite(img_bw,['../train_bw/',num2str(k),'.bmp']);
end

%%
% ������ͼƬ����ʶ��
index = [1,2,3,4,5,6];
for i=1:length(index)
    img = imread(['../test/',num2str(index(i)),'.bmp']);
    predictMat = predictNormalImage(img);
    predictMat(2,1) = inf; predictMat(2,8) = inf;
    disp(['../test/',num2str(index(i)),'.bmp��ʶ����Ϊ:']);
    disp(predictMat)
end

%%
% �Ի���ͼƬ����ʶ��
% img = imread('../test/������.bmp');
% predict = predictNormalImage(img);
% img = imread('../test/����.bmp');
% predict = predictScrachImage(img);
% disp('����ͼƬʶ����Ϊ:');
% disp(predict)
% 
%%
%������ͼƬ����ʶ��
% img = imread('../test/����.bmp');
% predict = predictNoisyImage(img);
% disp('����ͼƬʶ����Ϊ:');
% disp(predict)
