clear all;close all;clc;

img = imread('../test/����.bmp');
img = rgb2gray(img);
subplot(3,1,1)
imshow(img)
title('ԭʼͼƬ')

img=double(img);
img(img<90)=NaN;
subplot(3,1,2)
imshow(uint8(img))
title('��⻮��')

img1 = inpaintn(double(img));
subplot(3,1,3)
img1 = uint8(img1);
imshow(img1)
title('ȥ������')

imwrite(img1,'../test/������.bmp');