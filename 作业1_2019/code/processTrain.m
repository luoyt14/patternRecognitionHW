clear all;close all;clc;

index = [0,1,2,3,4,6,8,9];
figure;
for i=1:length(index)
    img = imread(['../train/',num2str(index(i)),'.bmp']);
    subplot(2,8,i);
    imshow(img);
    img_bw = imbinarize(img);
    subplot(2,8,i+8);
    imshow(img_bw)
end