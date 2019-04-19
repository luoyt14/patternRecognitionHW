clear all;close all;clc;

img = imread('../test/噪声.bmp');
img = rgb2gray(img);
subplot(3,2,1)
imshow(img)
title('原始图片')

img7 = double(img);
th = graythresh(img7/255);
img7 = im2bw(img7/255, th);
subplot(3,2,2)
imshow(img7)
title('原始图片的二值化')

img2 = wiener2(img);
subplot(3,2,3)
imshow(img2)
title('维纳滤波之后的图片')


img6 = double(img2);
th = graythresh(img6/255);
img6 = im2bw(img6/255, th);
subplot(3,2,4)
imshow(img6)
title('维纳滤波之后的二值化')

w = 55;
img3 = double(img2);
% img4 = ordfilt2(img4,1,ones(w,w),'symmetric');
% h=ones(w,w)/(w*w);
h=fspecial('gaussian',[w w],w);
img4=imfilter(img3,h,'replicate');
img4=imsubtract(double(img2),img4);
img4=img4+mean(mean(img3));
subplot(3,2,5)
imshow(img4,[])
title('调整图片亮度')
imwrite(uint8(img4),'../test/处理噪声.bmp');

th = graythresh(img4/255);
img5 = im2bw(img4/255, th);
img5 = processScratch(img5);
subplot(3,2,6)
imshow(img5)
title('二值化')