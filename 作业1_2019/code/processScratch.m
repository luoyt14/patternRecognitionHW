function [img_roi] = processScratch(img)
%消除划痕的函数
%input: img输入带划痕的二值图像
%output: img_roi输出消除划痕后的二值图像
    SE = strel('rectangle',[4 3]);
    img_roi = imerode(img,SE);
    img_roi = imdilate(img_roi, SE);

end

