clear all;close all;clc;

img = imread('../test/补充2.bmp');
img = rgb2gray(img);
subplot(2,1,1)
imshow(img)
title('补充2.bmp')

w = 15;
img1 = double(img);
h=fspecial('gaussian',[w w],w);
img2=imfilter(img1,h,'replicate');
img2=imsubtract(double(img1),img2);
img2=img2+mean(mean(img1));
subplot(2,1,2)
imshow(uint8(img2))
title('处理之后的补充2.bmp')
imwrite(uint8(img2),'../test/处理补充2.bmp');