clear all;close all;clc;

img = imread('../test/划痕.bmp');
img = rgb2gray(img);
subplot(3,1,1)
imshow(img)
title('原始图片')

img=double(img);
img(img<90)=NaN;
subplot(3,1,2)
imshow(uint8(img))
title('检测划痕')

img1 = inpaintn(double(img));
subplot(3,1,3)
img1 = uint8(img1);
imshow(img1)
title('去除划痕')

imwrite(img1,'../test/处理划痕.bmp');