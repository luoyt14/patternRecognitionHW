function [img_roi] = processScratch(img)
%�������۵ĺ���
%input: img��������۵Ķ�ֵͼ��
%output: img_roi����������ۺ�Ķ�ֵͼ��
    SE = strel('rectangle',[4 3]);
    img_roi = imerode(img,SE);
    img_roi = imdilate(img_roi, SE);

end

