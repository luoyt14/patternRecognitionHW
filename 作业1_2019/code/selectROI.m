function [img_roi] = selectROI(img)
%去掉图片周围白色区域
[x,y]=find(img==0);
img_roi = img(min(x):max(x),min(y):max(y));

end

