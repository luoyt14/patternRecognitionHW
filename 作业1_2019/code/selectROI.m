function [img_roi] = selectROI(img)
%ȥ��ͼƬ��Χ��ɫ����
[x,y]=find(img==0);
img_roi = img(min(x):max(x),min(y):max(y));

end

